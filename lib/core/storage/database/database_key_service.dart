import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the SQLCipher encryption key and one-time migration flag.
class DatabaseKeyService {
  DatabaseKeyService(this._storage);

  final FlutterSecureStorage _storage;

  static const _encryptionKeyName = 'DB_ENCRYPTION_KEY';
  static const _migrationCompleteName = 'DB_ENCRYPTION_MIGRATED';

  Future<bool> hasCompletedEncryptionMigration() async {
    final value = await _storage.read(key: _migrationCompleteName);
    return value == 'true';
  }

  Future<void> markEncryptionMigrationComplete() async {
    await _storage.write(key: _migrationCompleteName, value: 'true');
  }

  Future<String> getOrCreateKey() async {
    final existing = await _storage.read(key: _encryptionKeyName);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final key = _generateKey();
    await _storage.write(key: _encryptionKeyName, value: key);
    return key;
  }

  String _generateKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }
}
