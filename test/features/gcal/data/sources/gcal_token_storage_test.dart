import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/gcal/data/sources/gcal_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late GCalTokenStorage tokenStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    tokenStorage = GCalTokenStorage(mockStorage);
  });

  test('saveTokens writes access token only when refresh is omitted', () async {
    when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    await tokenStorage.saveTokens(accessToken: 'access');

    verify(() => mockStorage.write(key: 'GCAL_ACCESS_TOKEN', value: 'access')).called(1);
    verifyNever(() => mockStorage.write(key: 'GCAL_REFRESH_TOKEN', value: any(named: 'value')));
  });

  test('getAccessToken reads access token key', () async {
    when(() => mockStorage.read(key: 'GCAL_ACCESS_TOKEN'))
        .thenAnswer((_) async => 'access');

    expect(await tokenStorage.getAccessToken(), 'access');
  });

  test('getRefreshToken reads refresh token key', () async {
    when(() => mockStorage.read(key: 'GCAL_REFRESH_TOKEN'))
        .thenAnswer((_) async => 'refresh');

    expect(await tokenStorage.getRefreshToken(), 'refresh');
  });

  test('saveTokens writes access and refresh tokens', () async {
    when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    await tokenStorage.saveTokens(
      accessToken: 'access',
      refreshToken: 'refresh',
    );

    verify(() => mockStorage.write(key: 'GCAL_ACCESS_TOKEN', value: 'access')).called(1);
    verify(() => mockStorage.write(key: 'GCAL_REFRESH_TOKEN', value: 'refresh')).called(1);
  });

  test('clear deletes both token keys', () async {
    when(() => mockStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});

    await tokenStorage.clear();

    verify(() => mockStorage.delete(key: 'GCAL_ACCESS_TOKEN')).called(1);
    verify(() => mockStorage.delete(key: 'GCAL_REFRESH_TOKEN')).called(1);
  });
}
