import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/sqlcipher_key.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('SqlCipherKey', () {
    test('apply uses hex-key PRAGMA without quoting raw key material', () {
      final db = sqlite.sqlite3.openInMemory();
      addTearDown(db.close);

      const keyWithQuote = 'JyI='; // decodes to 0x27 0x22 (`'"`)

      expect(
        () => SqlCipherKey.apply(execute: db.execute, keyMaterial: keyWithQuote),
        returnsNormally,
      );
    });

    test('apply throws when key material decodes to empty bytes', () {
      expect(
        () => SqlCipherKey.apply(execute: (_) {}, keyMaterial: ''),
        throwsArgumentError,
      );
    });
  });
}
