import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/network/auth_interceptor.dart';
import 'package:reflect/core/storage/token_storage.dart';

class MockTokenStorage extends Mock implements TokenStorage {}
class MockDio extends Mock implements Dio {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  late MockTokenStorage mockTokenStorage;
  late MockDio mockDio;
  late AuthInterceptor interceptor;

  setUp(() {
    mockTokenStorage = MockTokenStorage();
    mockDio = MockDio();
    interceptor = AuthInterceptor(mockTokenStorage, mockDio);
  });

  group('onRequest', () {
    test('adds Authorization header if token exists', () async {
      when(() => mockTokenStorage.getAccessToken()).thenAnswer((_) async => 'token123');
      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers['Authorization'], 'Bearer token123');
      verify(() => handler.next(options)).called(1);
    });

    test('does not add Authorization header if token does not exist', () async {
      when(() => mockTokenStorage.getAccessToken()).thenAnswer((_) async => null);
      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers.containsKey('Authorization'), isFalse);
      verify(() => handler.next(options)).called(1);
    });
  });

  group('onError', () {
    test('calls next if error is not 401', () async {
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(requestOptions: RequestOptions(path: '/test'), statusCode: 400),
      );
      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(err, handler);

      verify(() => handler.next(err)).called(1);
    });

    test('calls next if no refresh token is available', () async {
      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => null);
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(requestOptions: RequestOptions(path: '/test'), statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(err, handler);

      verify(() => handler.next(err)).called(1);
    });
  });
}
