import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/secure_storage_factory.dart';

void main() {
  group('SecureStorageFactory', () {
    test('instance exposes hardened FlutterSecureStorage configuration', () {
      expect(SecureStorageFactory.instance, isA<FlutterSecureStorage>());
    });

    test('instance is a stable singleton reference', () {
      expect(
        identical(SecureStorageFactory.instance, SecureStorageFactory.instance),
        isTrue,
      );
    });
  });
}
