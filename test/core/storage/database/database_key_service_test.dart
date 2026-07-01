import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/storage/database/database_key_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late DatabaseKeyService service;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = DatabaseKeyService(mockStorage);
  });

  test('getOrCreateKey returns existing key', () async {
    when(() => mockStorage.read(key: any(named: 'key')))
        .thenAnswer((_) async => 'existing-key');

    final key = await service.getOrCreateKey();

    expect(key, 'existing-key');
    verifyNever(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')));
  });

  test('getOrCreateKey generates and stores key when missing', () async {
    when(() => mockStorage.read(key: any(named: 'key')))
        .thenAnswer((_) async => null);
    when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    final key = await service.getOrCreateKey();

    expect(key, isNotEmpty);
    verify(() => mockStorage.write(key: 'DB_ENCRYPTION_KEY', value: key)).called(1);
  });

  test('markEncryptionMigrationComplete writes migration flag', () async {
    when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    await service.markEncryptionMigrationComplete();

    verify(() => mockStorage.write(key: 'DB_ENCRYPTION_MIGRATED', value: 'true')).called(1);
  });

  test('hasCompletedEncryptionMigration reads migration flag', () async {
    when(() => mockStorage.read(key: 'DB_ENCRYPTION_MIGRATED'))
        .thenAnswer((_) async => 'true');

    expect(await service.hasCompletedEncryptionMigration(), isTrue);
  });
}
