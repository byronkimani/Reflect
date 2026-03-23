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
