import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure_mapper.dart';
import 'package:reflect/core/network/auth_interceptor.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';
import 'package:reflect/core/storage/token_storage.dart';
import '../errors/failure.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    required String baseUrl,
    required TokenStorage tokenStorage,
    AuthSessionNotifier? sessionNotifier,
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
    if (dioOverride == null) {
      _dio.interceptors.add(
        AuthInterceptor(
          tokenStorage,
          _dio,
          sessionNotifier: sessionNotifier,
        ),
      );
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
      return Left(FailureMapper.serverFailureFromDio(e));
    } catch (e) {
      return Left(FailureMapper.serverFailure(e, debugContext: 'get'));
    }
  }

  Future<Either<Failure, dynamic>> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(FailureMapper.serverFailureFromDio(e));
    } catch (e) {
      return Left(FailureMapper.serverFailure(e, debugContext: 'post'));
    }
  }
}
