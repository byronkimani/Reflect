import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'tables/task_tables.dart';
import 'tables/review_tables.dart';
import 'tables/goal_tables.dart';

import 'package:reflect/core/storage/database/database_key_service.dart';
import 'package:reflect/core/storage/database/sqlcipher_key.dart';
import 'package:reflect/core/storage/database/sqlite_migration.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Tasks,
    Subtasks,
    Tags,
    TaskTags,
    RecurrenceRules,
    DailyReviews,
    GoalCategories,
    Goals,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(DatabaseKeyService keyService) : super(_openConnection(keyService));
  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        if (!await sqliteTableHasColumn(this, 'tasks', 'has_enabled_reminder')) {
          await migrator.addColumn(tasks, tasks.hasEnabledReminder);
        }
      }
      if (from < 3) {
        if (!await sqliteTableExists(this, 'goal_categories')) {
          await migrator.createTable(goalCategories);
        }
        if (!await sqliteTableExists(this, 'goals')) {
          await migrator.createTable(goals);
        }
      }
      if (from < 4) {
        if (!await sqliteTableHasColumn(
          this,
          'tasks',
          'due_date_local_day_start',
        )) {
          await migrator.addColumn(tasks, tasks.dueDateLocalDayStart);
        }
        if (!await sqliteTableHasColumn(this, 'tasks', 'due_date_utc_ms')) {
          await migrator.addColumn(tasks, tasks.dueDateUtcMs);
        }
        final rows = await select(tasks).get();
        for (final t in rows) {
          if (t.dueDate == null) continue;
          if (t.dueDateLocalDayStart != null && t.dueDateUtcMs != null) {
            continue;
          }
          final d = DateTime.fromMillisecondsSinceEpoch(t.dueDate!);
          final localStart =
              DateTime(d.year, d.month, d.day).millisecondsSinceEpoch;
          var instant = localStart;
          final timeMins = t.dueTime;
          if (timeMins != null) {
            final h = timeMins ~/ 60;
            final m = timeMins % 60;
            instant =
                DateTime(d.year, d.month, d.day, h, m).millisecondsSinceEpoch;
          }
          await (update(tasks)..where((r) => r.id.equals(t.id))).write(
            TasksCompanion(
              dueDateLocalDayStart: Value(localStart),
              dueDateUtcMs: Value(instant),
            ),
          );
        }
      }
      if (from < 5) {
        if (!await sqliteTableHasColumn(this, 'tasks', 'goal_id')) {
          await migrator.addColumn(tasks, tasks.goalId);
        }
      }
      if (from < 6) {
        if (!await sqliteTableHasColumn(this, 'goals', 'is_measurable')) {
          await migrator.addColumn(goals, goals.isMeasurable);
        }
      }
      if (from < 7) {
        // Drop FK on g_cal_sync_queue so DELETE outbox rows survive local task removal.
        if (await sqliteTableExists(this, 'g_cal_sync_queue')) {
          await customStatement('''
            CREATE TABLE g_cal_sync_queue_new (
              id TEXT NOT NULL PRIMARY KEY,
              task_id TEXT NOT NULL,
              operation TEXT NOT NULL,
              payload TEXT NOT NULL,
              retry_count INTEGER NOT NULL DEFAULT 0,
              created_at INTEGER NOT NULL
            )
          ''');
          await customStatement('''
            INSERT INTO g_cal_sync_queue_new
            SELECT id, task_id, operation, payload, retry_count, created_at
            FROM g_cal_sync_queue
          ''');
          await customStatement('DROP TABLE g_cal_sync_queue');
          await customStatement(
            'ALTER TABLE g_cal_sync_queue_new RENAME TO g_cal_sync_queue',
          );
        }
      }
      if (from < 9) {
        if (!await sqliteIndexExists(this, 'idx_tasks_due_date')) {
          await customStatement(
            'CREATE INDEX idx_tasks_due_date ON tasks (due_date)',
          );
        }
        if (!await sqliteIndexExists(this, 'idx_tasks_status')) {
          await customStatement(
            'CREATE INDEX idx_tasks_status ON tasks (status)',
          );
        }
        if (!await sqliteIndexExists(this, 'idx_subtasks_task_id')) {
          if (await sqliteTableExists(this, 'subtasks')) {
            await customStatement(
              'CREATE INDEX idx_subtasks_task_id ON subtasks (task_id)',
            );
          }
        }
      }
      if (from < 10) {
        if (!await sqliteIndexExists(this, 'idx_tasks_due_date_local')) {
          await customStatement(
            'CREATE INDEX idx_tasks_due_date_local ON tasks (due_date_local_day_start)',
          );
        }
        final rows = await select(tasks).get();
        for (final t in rows) {
          if (t.dueDate == null || t.dueDateLocalDayStart != null) continue;
          final d = DateTime.fromMillisecondsSinceEpoch(t.dueDate!);
          final localStart =
              DateTime(d.year, d.month, d.day).millisecondsSinceEpoch;
          await (update(tasks)..where((r) => r.id.equals(t.id))).write(
            TasksCompanion(
              dueDateLocalDayStart: Value(localStart),
            ),
          );
        }
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
      await customStatement('PRAGMA synchronous = NORMAL');
      await customStatement('PRAGMA cache_size = -8000');
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

LazyDatabase _openConnection(DatabaseKeyService keyService) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'reflect.sqlite'));

    if (!await keyService.hasCompletedEncryptionMigration()) {
      await deleteSqliteDatabaseFiles(file);
      await keyService.markEncryptionMigrationComplete();
    }

    final key = await keyService.getOrCreateKey();
    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) => SqlCipherKey.apply(
        execute: rawDb.execute,
        keyMaterial: key,
      ),
    );
  });
}
