import 'dart:io';

import 'package:drift/drift.dart';

/// Returns whether [columnName] exists on [tableName] (SQLite `PRAGMA table_info`).
///
/// [tableName] must be a fixed identifier from application code, not user input.
Future<bool> sqliteTableHasColumn(
  GeneratedDatabase db,
  String tableName,
  String columnName,
) async {
  final rows = await db.customSelect(
    'PRAGMA table_info($tableName)',
    readsFrom: const {},
  ).get();
  return rows.any((row) => row.read<String>('name') == columnName);
}

/// [tableName] must be a fixed identifier from application code, not user input.
Future<bool> sqliteTableExists(GeneratedDatabase db, String tableName) async {
  final rows = await db.customSelect(
    "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = '$tableName'",
    readsFrom: const {},
  ).get();
  return rows.isNotEmpty;
}

/// [indexName] must be a fixed identifier from application code, not user input.
Future<bool> sqliteIndexExists(GeneratedDatabase db, String indexName) async {
  final rows = await db.customSelect(
    "SELECT 1 FROM sqlite_master WHERE type = 'index' AND name = '$indexName'",
    readsFrom: const {},
  ).get();
  return rows.isNotEmpty;
}

/// Deletes a SQLite database file and its `-wal` / `-shm` sidecars if present.
Future<void> deleteSqliteDatabaseFiles(File file) async {
  for (final path in [file.path, '${file.path}-wal', '${file.path}-shm']) {
    final entry = File(path);
    if (await entry.exists()) {
      await entry.delete();
    }
  }
}
