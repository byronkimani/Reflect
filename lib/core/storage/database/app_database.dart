import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'tables/task_tables.dart';
import 'tables/review_tables.dart';
import 'tables/sync_tables.dart';
import 'package:reflect/features/analytics/data/daos/analytics_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
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
  GCalSyncQueue,
], daos: [
  AnalyticsDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'reflect.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
