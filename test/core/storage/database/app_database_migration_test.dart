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
}

