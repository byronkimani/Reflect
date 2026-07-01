import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/secure_storage_factory.dart';

void main() {
  test('instance exposes hardened FlutterSecureStorage configuration', () {
    expect(SecureStorageFactory.instance, isA<FlutterSecureStorage>());
  });
}
