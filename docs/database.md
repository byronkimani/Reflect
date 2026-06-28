# Database (Drift) — Reflect

Reflect is strictly **offline-first**, meaning all data is persisted locally in an SQLite database. We use [Drift](https://drift.simonbinder.eu/) as our ORM/Reactive SQLite library.

## Overview

The database implementation is located in `lib/core/storage/database/`.

- `app_database.dart`: Contains the main `@DriftDatabase` annotation, table definitions, and connection logic.
- `daos/`: Contains Data Access Objects (e.g., `AnalyticsDao`) for scoped query logic.

## Tables

Drift tables are defined as Dart classes extending `Table`.

```dart
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

## DAOs (Data Access Objects)

We use DAOs to keep the main database class clean. A DAO isolates queries related to a specific domain (like Analytics).

```dart
@DriftAccessor(tables: [Tasks])
class AnalyticsDao extends DatabaseAccessor<AppDatabase> with _$AnalyticsDaoMixin {
  AnalyticsDao(AppDatabase db) : super(db);

  Future<int> getCompletedTasksCount() async {
    final query = select(tasks)..where((t) => t.isCompleted.equals(true));
    final result = await query.get();
    return result.length;
  }
}
```

## Code Generation

If you change a `Table`, add a DAO, or modify `@DriftDatabase`, you **must run code generation**:

```bash
make gen
```

This updates `app_database.g.dart` with the latest generated code.

## Migrations

Migrations are handled in the `migration` property of `AppDatabase`. When modifying the schema (adding columns/tables), increment the schema version and define the migration logic.

```dart
@override
int get schemaVersion => 2;

@override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (Migrator m) async {
    await m.createAll();
  },
  onUpgrade: (Migrator m, int from, int to) async {
    if (from == 1) {
      await m.addColumn(tasks, tasks.dueDate);
    }
  },
);
```

## Testing

For unit tests, use an in-memory database:

```dart
AppDatabase.forTesting(NativeDatabase.memory())
```
