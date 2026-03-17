import 'package:dio/dio.dart';
import 'package:reflect/core/config/env_config.dart';
import '../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;

  // Create a separate Dio instance for refreshing to avoid circular interceptor loops
  final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  AuthInterceptor(this._tokenStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Get the token
    final token = await _tokenStorage.getAccessToken();

    // 2. Add Authorization header if token exists
    // We can also exempt specific paths (like login) here if needed
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 1. Check if the error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      try {
        // 2. Get Refresh Token
        final refreshToken = await _tokenStorage.getRefreshToken();

        if (refreshToken == null) {
          // No refresh token? Logout logic should trigger here.
          return handler.next(err);
        }

        // 3. Perform Refresh Call
        // Note: We use _refreshDio, NOT _dio, to avoid hitting this interceptor again
        final response = await _refreshDio.post(
          '/refreshToken', // Your refresh endpoint
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          // 4. Extract new tokens
          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken']; // If rotated

          // 5. Save new tokens
          await _tokenStorage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken ?? refreshToken,
          );

          // 6. Retry the original request
          // Clone the original request options with the new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await _dio.fetch(options);

          // 7. Resolve the original request with the retry response
          return handler.resolve(retryResponse);
        }
      } catch (e) {
        // Refresh failed (Session Expired)
        // You might want to clear tokens here or emit a global "Logout" event
        await _tokenStorage.clearTokens();
        return handler.next(err);
      }
    }

    super.onError(err, handler);
  }
}
