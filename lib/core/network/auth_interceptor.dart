import 'package:dio/dio.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';
import '../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._tokenStorage,
    this._dio, {
    Dio? refreshDio,
    this._sessionNotifier,
  })  : _refreshDio = refreshDio ??
            Dio(
              BaseOptions(
                baseUrl: EnvConfig.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  final TokenStorage _tokenStorage;
  final Dio _dio;
  final Dio _refreshDio;
  final AuthSessionNotifier? _sessionNotifier;

  Future<void>? _inFlightRefresh;

  static const _refreshPath = '/refreshToken';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getAccessToken();

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
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    if (err.requestOptions.path == _refreshPath) {
      await _tokenStorage.clearTokens();
      _sessionNotifier?.notifySessionExpired();
      return handler.next(err);
    }

    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        await _handleRefreshFailure(handler, err);
        return;
      }

      await _refreshTokens();
      final newAccessToken = await _tokenStorage.getAccessToken();
      if (newAccessToken == null || newAccessToken.isEmpty) {
        await _handleRefreshFailure(handler, err);
        return;
      }

      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(options);
      return handler.resolve(retryResponse);
    } catch (_) {
      await _handleRefreshFailure(handler, err);
    }
  }

  Future<void> _refreshTokens() {
    return _inFlightRefresh ??= _performRefresh().whenComplete(() {
      _inFlightRefresh = null;
    });
  }

  Future<void> _performRefresh() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw StateError('No refresh token available');
    }

    final response = await _refreshDio.post(
      _refreshPath,
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }

    final data = response.data;
    if (data is! Map) {
      throw const FormatException('Refresh response is not a JSON object');
    }

    final newAccessToken = data['accessToken'];
    final newRefreshToken = data['refreshToken'];

    if (newAccessToken is! String || newAccessToken.isEmpty) {
      throw const FormatException('Refresh response missing accessToken');
    }

    final rotatedRefresh = newRefreshToken is String && newRefreshToken.isNotEmpty
        ? newRefreshToken
        : refreshToken;

    await _tokenStorage.saveTokens(
      accessToken: newAccessToken,
      refreshToken: rotatedRefresh,
    );
  }

  Future<void> _handleRefreshFailure(
    ErrorInterceptorHandler handler,
    DioException err,
  ) async {
    await _tokenStorage.clearTokens();
    _sessionNotifier?.notifySessionExpired();
    handler.next(err);
  }
}
