import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'tables/task_tables.dart';
import 'tables/review_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/goal_tables.dart';
import 'package:reflect/features/analytics/data/daos/analytics_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Tasks,
    Subtasks,
    Tags,
    TaskTags,
    RecurrenceRules,
    DailyReviews,
    WeeklyPlans,
    WeeklyReviews,
    WeeklyGoals,
    MonthlyPlans,
    MonthlyReviews,
    MonthlyGoals,
    GoalCategories,
    Goals,
    GCalSyncQueue,
  ],
  daos: [AnalyticsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(tasks, tasks.hasEnabledReminder);
      }
      if (from < 3) {
        await migrator.createTable(goalCategories);
        await migrator.createTable(goals);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Call once after migration to seed default goal categories if table is empty.
  Future<void> seedGoalCategoriesIfEmpty() async {
    final existing = await select(goalCategories).get();
    if (existing.isNotEmpty) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    const seeds = [
      'Meaningful connections with family and friends',
      'Integrity and transparency',
      'Education and open-mindedness',
      'Respect and self-respect',
      'Accountability',
      'Authenticity',
      'Orderliness',
    ];
    for (var i = 0; i < seeds.length; i++) {
      await into(goalCategories).insert(
        GoalCategoriesCompanion.insert(
          id: Value('seed_category_$i'),
          name: seeds[i],
          sortOrder: Value(i),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'reflect.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
