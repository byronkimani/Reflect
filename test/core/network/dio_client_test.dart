import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/storage/token_storage.dart';

class MockDio extends Mock implements Dio {}
class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockDio mockDio;
  late MockTokenStorage mockTokenStorage;
  late DioClient dioClient;

  setUp(() {
    mockDio = MockDio();
    mockTokenStorage = MockTokenStorage();
    dioClient = DioClient(
      baseUrl: 'http://test.com',
      tokenStorage: mockTokenStorage,
      dioOverride: mockDio,
    );
  });

  group('DioClient GET', () {
    test('returns Right with data on successful GET request', () async {
      final data = {'success': true};
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/test'),
                data: data,
                statusCode: 200,
              ));

      final result = await dioClient.get('/test');

      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Should not return Left'),
        (r) => expect(r, equals(data)),
      );
    });

    test('returns Left(NetworkFailure) on connectionTimeout', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      ));

      final result = await dioClient.get('/test');

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (r) => fail('Should not return Right'),
      );
    });

    test('returns Left(ServerFailure) on badResponse', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          statusMessage: 'Internal Server Error',
        ),
      ));

      final result = await dioClient.get('/test');

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) {
          expect(l, isA<ServerFailure>());
          expect((l as ServerFailure).statusCode, equals(500));
        },
        (r) => fail('Should not return Right'),
      );
    });

    test('returns Left(ServerFailure) on unknown exception', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(Exception('Unknown Error'));

      final result = await dioClient.get('/test');

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should not return Right'),
      );
    });
  });

  group('DioClient POST', () {
    test('returns Right with data on successful POST request', () async {
      final data = {'success': true};
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/test'),
                data: data,
                statusCode: 200,
              ));

      final result = await dioClient.post('/test', data: {'key': 'val'});

      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Should not return Left'),
        (r) => expect(r, equals(data)),
      );
    });

    test('returns Left(ServerFailure) on post exception', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(Exception('Post error'));

      final result = await dioClient.post('/test', data: {'key': 'val'});

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should not return Right'),
      );
    });
  });
}
