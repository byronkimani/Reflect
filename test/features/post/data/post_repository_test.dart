import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/features/post/data/post_repository.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient mockDioClient;
  late PostRepository repository;

  setUp(() {
    mockDioClient = MockDioClient();
    repository = PostRepository(mockDioClient);
  });

  test('getPosts returns right when successful', () async {
    when(() => mockDioClient.get('/posts')).thenAnswer((_) async => Right([
      {'id': 1, 'title': 'Test Title', 'body': 'Test Body'}
    ]));

    final result = await repository.getPosts();

    expect(result.isRight(), true);
    result.fold(
      (l) => fail('should be right'),
      (r) {
        expect(r.length, 1);
        expect(r.first.id, 1);
      },
    );
  });

  test('getPosts returns left when client fails', () async {
    when(() => mockDioClient.get('/posts')).thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'error')));

    final result = await repository.getPosts();

    expect(result.isLeft(), true);
  });

  test('getPosts returns left on parsing error', () async {
    when(() => mockDioClient.get('/posts')).thenAnswer((_) async => Right([
      {'invalid': 'data'}
    ]));

    final result = await repository.getPosts();

    expect(result.isLeft(), true);
  });
}
