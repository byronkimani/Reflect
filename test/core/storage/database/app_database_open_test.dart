import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/core/storage/database/database_key_service.dart';

import '../../../helpers/fake_path_provider.dart';

class MockDatabaseKeyService extends Mock implements DatabaseKeyService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory documentsDir;
  late MockDatabaseKeyService keyService;
  PathProviderPlatform? previousPathProvider;

  setUp(() {
    documentsDir = Directory.systemTemp.createTempSync('reflect_db_open_test');
    keyService = MockDatabaseKeyService();
    previousPathProvider = PathProviderPlatform.instance;
    PathProviderPlatform.instance = FakePathProvider.using(documentsDir);
    when(() => keyService.hasCompletedEncryptionMigration())
        .thenAnswer((_) async => true);
    when(() => keyService.getOrCreateKey()).thenAnswer((_) async => 'dGVzdA==');
  });

  tearDown(() async {
    PathProviderPlatform.instance = previousPathProvider!;
    if (documentsDir.existsSync()) {
      await documentsDir.delete(recursive: true);
    }
  });

  test('production constructor opens encrypted database file', () async {
    final db = AppDatabase(keyService);
    addTearDown(() async => db.close());

    final row = await db.customSelect('SELECT 1 AS value').getSingle();
    expect(row.read<int>('value'), 1);
    verify(() => keyService.getOrCreateKey()).called(1);
  });

  test('production constructor deletes legacy db on first encryption migration', () async {
    when(() => keyService.hasCompletedEncryptionMigration())
        .thenAnswer((_) async => false);
    when(() => keyService.markEncryptionMigrationComplete())
        .thenAnswer((_) async {});

    final legacyDb = File('${documentsDir.path}/reflect.sqlite');
    await legacyDb.writeAsString('legacy');

    final db = AppDatabase(keyService);
    addTearDown(() async => db.close());

    await db.customSelect('SELECT 1 AS value').getSingle();

    verify(() => keyService.hasCompletedEncryptionMigration()).called(1);
    verify(() => keyService.markEncryptionMigrationComplete()).called(1);
    expect(await legacyDb.exists(), isTrue);
  });
}
