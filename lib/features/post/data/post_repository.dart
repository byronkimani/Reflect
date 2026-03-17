import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/features/post/data/post_dto.dart';
import 'package:reflect/features/post/domain/post.dart';

class PostRepository {
  final DioClient _client;

  PostRepository(this._client);

  /// Returns list of Posts (Entities), not DTOs
  Future<Either<Failure, List<Post>>> getPosts() async {
    final result = await _client.get('/posts');

    return result.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> list = data;

        final posts = list
            .map((json) => PostDTO.fromJson(json)) // 1. Parse JSON to DTO
            .map((dto) => dto.toDomain()) // 2. Convert DTO to Entity
            .toList();

        return Right(posts);
      } catch (e) {
        return const Left(
          ServerFailure(
            errorMessage: 'Data serialization failed',
            statusCode: 500,
          ),
        );
      }
    });
  }
}
