import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

/// Regression: [user_version] can lag behind columns already added to `tasks`
/// (e.g. interrupted migration or manual DB edits). Upgrades must not call
/// `ALTER TABLE ... ADD COLUMN` for columns that already exist.
void main() {
  test(
    'upgrade 3→6 succeeds when due_date_local_day_start already exists',
    () async {
      final raw = sqlite.sqlite3.openInMemory();

      raw.execute('''
CREATE TABLE recurrence_rules (
  id TEXT NOT NULL PRIMARY KEY,
  frequency TEXT NOT NULL,
  interval_val INTEGER NOT NULL DEFAULT 1,
  days_of_week TEXT,
  day_of_month INTEGER,
  end_type TEXT NOT NULL DEFAULT 'NEVER',
  end_date INTEGER,
  end_count INTEGER,
  occurrence_count INTEGER NOT NULL DEFAULT 0
);
''');

      raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

      raw.execute(
        'ALTER TABLE tasks ADD COLUMN due_date_local_day_start INTEGER;',
      );
      raw.execute('ALTER TABLE tasks ADD COLUMN due_date_utc_ms INTEGER;');

      raw.execute('''
CREATE TABLE goal_categories (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

      raw.execute('''
CREATE TABLE goals (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category_id TEXT,
  kpi_description TEXT,
  start_value TEXT,
  target_value TEXT,
  priority TEXT,
  urgency TEXT,
  why TEXT,
  start_date INTEGER,
  target_date INTEGER,
  check_in_frequency TEXT,
  time_horizon TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

      raw.userVersion = 3;

      final driftDb = AppDatabase.forTesting(
        DatabaseConnection(NativeDatabase.opened(raw)),
      );

      expect(await driftDb.select(driftDb.tasks).get(), isEmpty);
      await driftDb.close();
    },
  );

  test('upgrade 4→6 succeeds when goal_id already exists', () async {
    final raw = sqlite.sqlite3.openInMemory();

    raw.execute('''
CREATE TABLE recurrence_rules (
  id TEXT NOT NULL PRIMARY KEY,
  frequency TEXT NOT NULL,
  interval_val INTEGER NOT NULL DEFAULT 1,
  days_of_week TEXT,
  day_of_month INTEGER,
  end_type TEXT NOT NULL DEFAULT 'NEVER',
  end_date INTEGER,
  end_count INTEGER,
  occurrence_count INTEGER NOT NULL DEFAULT 0
);
''');

    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  due_date_local_day_start INTEGER,
  due_date_utc_ms INTEGER,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('ALTER TABLE tasks ADD COLUMN goal_id TEXT;');

    raw.execute('''
CREATE TABLE goal_categories (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE goals (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category_id TEXT,
  kpi_description TEXT,
  start_value TEXT,
  target_value TEXT,
  priority TEXT,
  urgency TEXT,
  why TEXT,
  start_date INTEGER,
  target_date INTEGER,
  check_in_frequency TEXT,
  time_horizon TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.userVersion = 4;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    expect(await driftDb.select(driftDb.tasks).get(), isEmpty);
    await driftDb.close();
  });

  test('upgrade 5→6 succeeds when is_measurable already exists', () async {
    final raw = sqlite.sqlite3.openInMemory();

    raw.execute('''
CREATE TABLE recurrence_rules (
  id TEXT NOT NULL PRIMARY KEY,
  frequency TEXT NOT NULL,
  interval_val INTEGER NOT NULL DEFAULT 1,
  days_of_week TEXT,
  day_of_month INTEGER,
  end_type TEXT NOT NULL DEFAULT 'NEVER',
  end_date INTEGER,
  end_count INTEGER,
  occurrence_count INTEGER NOT NULL DEFAULT 0
);
''');

    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  due_date_local_day_start INTEGER,
  due_date_utc_ms INTEGER,
  goal_id TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE goal_categories (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE goals (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category_id TEXT,
  kpi_description TEXT,
  start_value TEXT,
  target_value TEXT,
  priority TEXT,
  urgency TEXT,
  why TEXT,
  start_date INTEGER,
  target_date INTEGER,
  check_in_frequency TEXT,
  time_horizon TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('ALTER TABLE goals ADD COLUMN is_measurable INTEGER NOT NULL DEFAULT 1;');

    raw.userVersion = 5;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    expect(await driftDb.select(driftDb.goals).get(), isEmpty);
    await driftDb.close();
  });

  test('seedGoalCategoriesIfEmpty inserts seeds if empty', () async {
    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.memory()),
    );
    await driftDb.seedGoalCategoriesIfEmpty();
    final categories = await driftDb.select(driftDb.goalCategories).get();
    expect(categories.length, 7);
    expect(categories.first.name, 'Meaningful connections with family and friends');
    
    // Test idempotent
    await driftDb.seedGoalCategoriesIfEmpty();
    final afterSecond = await driftDb.select(driftDb.goalCategories).get();
    expect(afterSecond.length, 7);
    
    await driftDb.close();
  });

  test('upgrade 1→6 normal migration', () async {
    final raw = sqlite.sqlite3.openInMemory();

    // V1 schema
    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');
    // Insert dummy task without new columns
    raw.execute(
      "INSERT INTO tasks (id, title, priority, status, created_at, updated_at, due_date, due_time) VALUES ('t1', 'Test', 'medium', 'pending', 0, 0, 1696982400000, 600);"
    );

    raw.userVersion = 1;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    // This triggers the migration
    final tasks = await driftDb.select(driftDb.tasks).get();
    expect(tasks.length, 1);
    expect(tasks.first.hasEnabledReminder, 0);
    expect(tasks.first.dueDateLocalDayStart != null, true);
    expect(tasks.first.dueDateUtcMs != null, true);
    expect(tasks.first.goalId, null);

    await driftDb.close();
  });

  test('upgrade 8→9 adds task and subtask indexes', () async {
    final raw = sqlite.sqlite3.openInMemory();

    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  due_date_local_day_start INTEGER,
  due_date_utc_ms INTEGER,
  goal_id TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE subtasks (
  id TEXT NOT NULL PRIMARY KEY,
  task_id TEXT NOT NULL,
  title TEXT NOT NULL,
  is_completed INTEGER NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL
);
''');

    raw.userVersion = 8;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    final indexes = await driftDb.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'index' AND name LIKE 'idx_%'",
      readsFrom: const {},
    ).get();

    final indexNames = indexes.map((r) => r.read<String>('name')).toSet();
    expect(indexNames, containsAll([
      'idx_tasks_due_date',
      'idx_tasks_status',
      'idx_subtasks_task_id',
    ]));

    await driftDb.close();
  });

  test('upgrade 9→10 backfills due_date_local_day_start and adds index', () async {
    final raw = sqlite.sqlite3.openInMemory();

    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  due_date_local_day_start INTEGER,
  due_date_utc_ms INTEGER,
  goal_id TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    final dueInstant = DateTime(2026, 6, 15, 9, 0).millisecondsSinceEpoch;
    raw.execute(
      "INSERT INTO tasks (id, title, priority, due_date, status, created_at, updated_at) "
      "VALUES ('t1', 'Due task', 'p4', $dueInstant, 'pending', 0, 0);",
    );

    raw.userVersion = 9;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    final task = await (driftDb.select(driftDb.tasks)
          ..where((t) => t.id.equals('t1')))
        .getSingle();
    expect(
      task.dueDateLocalDayStart,
      DateTime(2026, 6, 15).millisecondsSinceEpoch,
    );

    final indexes = await driftDb.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'index'",
      readsFrom: const {},
    ).get();
    final indexNames = indexes.map((r) => r.read<String>('name')).toSet();
    expect(indexNames, contains('idx_tasks_due_date_local'));

    await driftDb.close();
  });

  test('beforeOpen sets synchronous NORMAL and cache_size pragmas', () async {
    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.memory()),
    );

    final sync = await driftDb.customSelect('PRAGMA synchronous').getSingle();
    expect(int.parse(sync.data.values.first.toString()), 1);

    final cache = await driftDb.customSelect('PRAGMA cache_size').getSingle();
    expect(int.parse(cache.data.values.first.toString()), -8000);

    await driftDb.close();
  });

  test('upgrade 6→7 recreates g_cal_sync_queue without foreign key', () async {
    final raw = sqlite.sqlite3.openInMemory();

    raw.execute('''
CREATE TABLE recurrence_rules (
  id TEXT NOT NULL PRIMARY KEY,
  frequency TEXT NOT NULL,
  interval_val INTEGER NOT NULL DEFAULT 1,
  days_of_week TEXT,
  day_of_month INTEGER,
  end_type TEXT NOT NULL DEFAULT 'NEVER',
  end_date INTEGER,
  end_count INTEGER,
  occurrence_count INTEGER NOT NULL DEFAULT 0
);
''');

    raw.execute('''
CREATE TABLE tasks (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  priority TEXT NOT NULL,
  due_date INTEGER,
  due_time INTEGER,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  is_overdue INTEGER NOT NULL DEFAULT 0,
  overdue_day INTEGER NOT NULL DEFAULT 0,
  recurrence_rule_id TEXT,
  recurrence_parent_id TEXT,
  has_enabled_reminder INTEGER NOT NULL DEFAULT 0,
  gcal_event_id TEXT,
  sync_to_gcal INTEGER NOT NULL DEFAULT 0,
  due_date_local_day_start INTEGER,
  due_date_utc_ms INTEGER,
  goal_id TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE subtasks (
  id TEXT NOT NULL PRIMARY KEY,
  task_id TEXT NOT NULL,
  title TEXT NOT NULL,
  is_completed INTEGER NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE goal_categories (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE goals (
  id TEXT NOT NULL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  category_id TEXT,
  kpi_description TEXT,
  start_value TEXT,
  target_value TEXT,
  priority TEXT,
  urgency TEXT,
  why TEXT,
  start_date INTEGER,
  target_date INTEGER,
  check_in_frequency TEXT,
  time_horizon TEXT NOT NULL,
  is_measurable INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
''');

    raw.execute('''
CREATE TABLE g_cal_sync_queue (
  id TEXT NOT NULL PRIMARY KEY,
  task_id TEXT NOT NULL,
  operation TEXT NOT NULL,
  payload TEXT NOT NULL,
  retry_count INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL
);
''');

    raw.execute(
      "INSERT INTO g_cal_sync_queue "
      "VALUES ('q1', 't1', 'CREATE', '{}', 0, 0);",
    );

    raw.userVersion = 6;

    final driftDb = AppDatabase.forTesting(
      DatabaseConnection(NativeDatabase.opened(raw)),
    );

    final rows = await driftDb
        .customSelect('SELECT id, task_id FROM g_cal_sync_queue')
        .get();
    expect(rows, hasLength(1));
    expect(rows.first.read<String>('id'), 'q1');

    await driftDb.close();
  });
}

