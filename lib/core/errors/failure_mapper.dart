import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reflect/core/errors/failure.dart';

/// Maps internal errors to safe, user-facing [Failure] instances.
class FailureMapper {
  FailureMapper._(); // coverage:ignore-line

  static const cacheMessage = 'Something went wrong while saving your data.';
  static const serverMessage = 'Something went wrong. Please try again.';
  static const networkMessage = 'Please check your internet connection.';
  static const unknownMessage = 'An unexpected error occurred.';

  static Failure cacheFailure(Object error, {String? debugContext}) {
    debugLogFailure(error, context: debugContext);
    return const CacheFailure(errorMessage: cacheMessage);
  }

  static Failure serverFailureFromDio(DioException error) {
    debugLogFailure(error, context: 'dio');
    final statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(errorMessage: networkMessage);
      case DioExceptionType.connectionError:
        return const NetworkFailure(errorMessage: networkMessage);
      case DioExceptionType.badResponse:
        return ServerFailure(
          errorMessage: serverMessage,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const NetworkFailure(errorMessage: 'Request cancelled');
      default:
        return ServerFailure(
          errorMessage: serverMessage,
          statusCode: statusCode,
        );
    }
  }

  static Failure serverFailure(Object error, {String? debugContext}) {
    debugLogFailure(error, context: debugContext);
    return const ServerFailure(errorMessage: serverMessage);
  }

  static String userFacingMessage(Failure failure) => failure.errorMessage;

  static void debugLogFailure(Object error, {String? context}) {
    if (!kDebugMode) return;
    final prefix = context == null ? '' : '[$context] ';
    debugPrint('$prefix$error');
  }
}
