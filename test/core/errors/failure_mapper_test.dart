import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/errors/failure_mapper.dart';

void main() {
  group('FailureMapper', () {
    test('cacheFailure returns generic message', () {
      final failure = FailureMapper.cacheFailure(
        Exception('SqliteException: sensitive details'),
      );

      expect(failure, isA<CacheFailure>());
      expect(failure.errorMessage, FailureMapper.cacheMessage);
      expect(failure.errorMessage, isNot(contains('SqliteException')));
    });

    test('userFacingMessage returns failure errorMessage', () {
      const failure = CacheFailure(errorMessage: FailureMapper.cacheMessage);

      expect(
        FailureMapper.userFacingMessage(failure),
        FailureMapper.cacheMessage,
      );
    });

    test('serverFailureFromDio maps timeout to network failure', () {
      final failure = FailureMapper.serverFailureFromDio(
        DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(failure, isA<NetworkFailure>());
    });

    test('serverFailure returns generic server message', () {
      final failure = FailureMapper.serverFailure(Exception('internal'));

      expect(failure, isA<ServerFailure>());
      expect(failure.errorMessage, FailureMapper.serverMessage);
    });
  });
}
