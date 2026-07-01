import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/core/storage/database/sqlite_migration.dart';

void main() {
  test('sqliteTableHasColumn is true for tasks.id', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    expect(await sqliteTableHasColumn(db, 'tasks', 'id'), isTrue);
    await db.close();
  });

  test('sqliteTableHasColumn is false for fictitious column', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    expect(
      await sqliteTableHasColumn(db, 'tasks', '__no_such_column__'),
      isFalse,
    );
    await db.close();
  });

  test('sqliteTableExists is true for tasks', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    expect(await sqliteTableExists(db, 'tasks'), isTrue);
    expect(await sqliteTableExists(db, '__missing__'), isFalse);
    await db.close();
  });

  test('sqliteIndexExists is true for drift task indexes', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    expect(await sqliteIndexExists(db, 'idx_tasks_due_date'), isTrue);
    expect(await sqliteIndexExists(db, 'idx_tasks_status'), isTrue);
    expect(await sqliteIndexExists(db, 'idx_subtasks_task_id'), isTrue);
    expect(await sqliteIndexExists(db, '__missing__'), isFalse);
    await db.close();
  });

  test('deleteSqliteDatabaseFiles removes db, wal, and shm files', () async {
    final tempDir = await Directory.systemTemp.createTemp('reflect_sqlite_delete');
    addTearDown(() => tempDir.delete(recursive: true));

    final dbFile = File('${tempDir.path}/reflect.sqlite');
    await dbFile.writeAsString('db');
    await File('${dbFile.path}-wal').writeAsString('wal');
    await File('${dbFile.path}-shm').writeAsString('shm');

    await deleteSqliteDatabaseFiles(dbFile);

    expect(await dbFile.exists(), isFalse);
    expect(await File('${dbFile.path}-wal').exists(), isFalse);
    expect(await File('${dbFile.path}-shm').exists(), isFalse);
  });
}
