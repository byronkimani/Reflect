import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reflect/core/storage/token_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late TokenStorage tokenStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    tokenStorage = TokenStorage(mockStorage);
  });

  test('saveTokens writes to storage', () async {
    when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});
    await tokenStorage.saveTokens(accessToken: 'access', refreshToken: 'refresh');
    verify(() => mockStorage.write(key: 'ACCESS_TOKEN', value: 'access')).called(1);
    verify(() => mockStorage.write(key: 'REFRESH_TOKEN', value: 'refresh')).called(1);
  });

  test('getAccessToken reads from storage', () async {
    when(() => mockStorage.read(key: 'ACCESS_TOKEN')).thenAnswer((_) async => 'access');
    final token = await tokenStorage.getAccessToken();
    expect(token, 'access');
  });

  test('getRefreshToken reads from storage', () async {
    when(() => mockStorage.read(key: 'REFRESH_TOKEN')).thenAnswer((_) async => 'refresh');
    final token = await tokenStorage.getRefreshToken();
    expect(token, 'refresh');
  });

  test('clearTokens deletes from storage', () async {
    when(() => mockStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    await tokenStorage.clearTokens();
    verify(() => mockStorage.delete(key: 'ACCESS_TOKEN')).called(1);
    verify(() => mockStorage.delete(key: 'REFRESH_TOKEN')).called(1);
  });
}
