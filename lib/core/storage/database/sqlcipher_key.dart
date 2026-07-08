import 'dart:convert';

/// Applies a SQLCipher encryption key without string-interpolating the raw key.
class SqlCipherKey {
  SqlCipherKey._(); // coverage:ignore-line

  /// Sets the SQLCipher key using the hex-key PRAGMA form.
  ///
  /// [execute] is typically [Database.execute] from the opened SQLite handle.
  /// [keyMaterial] is the base64url-encoded 32-byte key from [DatabaseKeyService].
  static void apply({
    required void Function(String sql) execute,
    required String keyMaterial,
  }) {
    final bytes = base64Url.decode(keyMaterial);
    if (bytes.isEmpty) {
      throw ArgumentError.value(
        keyMaterial,
        'keyMaterial',
        'must not decode to empty bytes',
      );
    }

    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    execute("PRAGMA key = \"x'$hex'\";");
  }
}
