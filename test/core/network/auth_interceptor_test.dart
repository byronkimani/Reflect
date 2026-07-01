import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/network/auth_interceptor.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';
import 'package:reflect/core/storage/token_storage.dart';

class MockTokenStorage extends Mock implements TokenStorage {}
class MockDio extends Mock implements Dio {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}

void main() {
  late MockTokenStorage mockTokenStorage;
  late MockDio mockDio;
  late AuthInterceptor interceptor;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Response<dynamic>(requestOptions: RequestOptions(path: '')));
  });

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
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(requestOptions: RequestOptions(path: '/test'), statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(err, handler);

      verify(() => handler.next(err)).called(1);
    });
    test('handles 401 by refreshing token successfully', () async {
      final mockRefreshDio = MockDio();
      final localInterceptor = AuthInterceptor(mockTokenStorage, mockDio, refreshDio: mockRefreshDio);

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => 'old_refresh');
      
      // Mock refresh call success
      when(() => mockRefreshDio.post('/refreshToken', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/refreshToken'),
                statusCode: 200,
                data: {'accessToken': 'new_access', 'refreshToken': 'new_refresh'},
              ));

      when(() => mockTokenStorage.saveTokens(
            accessToken: 'new_access',
            refreshToken: 'new_refresh',
          )).thenAnswer((_) async {});
      when(() => mockTokenStorage.getAccessToken())
          .thenAnswer((_) async => 'new_access');

      // Mock original request retry
      final originalOptions = RequestOptions(path: '/test');
      when(() => mockDio.fetch(any())).thenAnswer((_) async => Response(
            requestOptions: originalOptions,
            statusCode: 200,
          ));

      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.saveTokens(accessToken: 'new_access', refreshToken: 'new_refresh')).called(1);
      verify(() => handler.resolve(any())).called(1);
    });

    test('handles 401 refresh failure by clearing tokens', () async {
      final mockRefreshDio = MockDio();
      final localInterceptor = AuthInterceptor(mockTokenStorage, mockDio, refreshDio: mockRefreshDio);

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => 'old_refresh');
      
      // Mock refresh call fail
      when(() => mockRefreshDio.post('/refreshToken', data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
    });

    test('handles 401 on refresh endpoint by clearing tokens', () async {
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/refreshToken');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
    });

    test('rejects refresh response without accessToken', () async {
      final mockRefreshDio = MockDio();
      final sessionNotifier = AuthSessionNotifier();
      final localInterceptor = AuthInterceptor(
        mockTokenStorage,
        mockDio,
        refreshDio: mockRefreshDio,
        sessionNotifier: sessionNotifier,
      );

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => 'old_refresh');
      when(() => mockRefreshDio.post('/refreshToken', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/refreshToken'),
                statusCode: 200,
                data: {'refreshToken': 'new_refresh'},
              ));
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
      expect(sessionNotifier.lastEvent, AuthSessionEvent.expired);
    });

    test('handles 401 when refresh token disappears during refresh', () async {
      final mockRefreshDio = MockDio();
      final localInterceptor = AuthInterceptor(mockTokenStorage, mockDio, refreshDio: mockRefreshDio);
      var refreshReads = 0;

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async {
        refreshReads++;
        return refreshReads == 1 ? 'old_refresh' : null;
      });
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
    });

    test('handles 401 when refresh succeeds but access token stays empty', () async {
      final mockRefreshDio = MockDio();
      final localInterceptor = AuthInterceptor(mockTokenStorage, mockDio, refreshDio: mockRefreshDio);

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => 'old_refresh');
      when(() => mockRefreshDio.post('/refreshToken', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/refreshToken'),
                statusCode: 200,
                data: {'accessToken': 'new_access', 'refreshToken': 'new_refresh'},
              ));
      when(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockTokenStorage.getAccessToken()).thenAnswer((_) async => '');
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
    });

    test('handles 401 when refresh endpoint returns non-200', () async {
      final mockRefreshDio = MockDio();
      final localInterceptor = AuthInterceptor(mockTokenStorage, mockDio, refreshDio: mockRefreshDio);

      when(() => mockTokenStorage.getRefreshToken()).thenAnswer((_) async => 'old_refresh');
      when(() => mockRefreshDio.post('/refreshToken', data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/refreshToken'),
                statusCode: 500,
              ));
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      final originalOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: originalOptions,
        response: Response(requestOptions: originalOptions, statusCode: 401),
      );
      final handler = MockErrorInterceptorHandler();

      await localInterceptor.onError(err, handler);

      verify(() => mockTokenStorage.clearTokens()).called(1);
      verify(() => handler.next(err)).called(1);
    });
  });
}
