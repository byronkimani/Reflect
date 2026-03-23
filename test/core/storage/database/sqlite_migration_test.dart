import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
}
