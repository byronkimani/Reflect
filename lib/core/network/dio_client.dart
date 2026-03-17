import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/network/auth_interceptor.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../errors/failure.dart';

class DioClient {
  final Dio _dio;

  // Accept baseUrl as a parameter
  // the override is to allow for overriding when testing the client
  DioClient({
    required String baseUrl,
    required TokenStorage tokenStorage,
    Dio? dioOverride,
  }) : _dio =
           dioOverride ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: const Duration(seconds: 10),
               receiveTimeout: const Duration(seconds: 10),
               headers: {'Content-Type': 'application/json'},
             ),
           ) {
    // Only add interceptors if we're not using override (for testing)
    if (dioOverride == null) {
      _dio.interceptors.add(AuthInterceptor(tokenStorage, _dio));
      _dio.interceptors.add(_SentryLoggingInterceptor());
    }
  }

  Dio get instance => _dio;

  Future<Either<Failure, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: "An unknown error occurred"));
    }
  }

  Future<Either<Failure, dynamic>> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    final message =
        error.response?.statusMessage ?? error.message ?? 'Unknown error';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(errorMessage: 'Connection timed out');
      case DioExceptionType.connectionError:
        return const NetworkFailure(errorMessage: 'No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure(errorMessage: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const NetworkFailure(errorMessage: 'Request cancelled');
      default:
        return ServerFailure(
          errorMessage: 'Unexpected network error: $message',
          statusCode: statusCode,
        );
    }
  }
}

class _SentryLoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final sanitizedResponse = _sanitizeData(err.response?.data);

    Sentry.addBreadcrumb(
      Breadcrumb(
        type: 'http',
        category: 'network.error',
        data: {
          'url': err.requestOptions.uri.toString(),
          'method': err.requestOptions.method,
          'status_code': err.response?.statusCode,
          'response_snippet': sanitizedResponse,
        },
        level: SentryLevel.error,
      ),
    );

    Sentry.captureException(
      err,
      stackTrace: err.stackTrace,
      withScope: (scope) {
        scope.setTag('network_error', '${err.response?.statusCode}');
      },
    );

    super.onError(err, handler);
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is Map<String, dynamic>) {
      final Map<String, dynamic> sanitized = Map.from(data);
      const sensitiveKeys = ['password', 'token', 'auth', 'credit_card'];

      for (var key in sensitiveKeys) {
        if (sanitized.containsKey(key)) {
          sanitized[key] = '[REDACTED]';
        }
      }
      return sanitized;
    }
    return data;
  }
}
