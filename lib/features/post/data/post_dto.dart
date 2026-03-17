import 'package:reflect/features/post/domain/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// PostDTO (Data Transfer Object)
/// Handles the raw data from the API.
@freezed
abstract class PostDTO with _$PostDTO {
  const PostDTO._();

  const factory PostDTO({
    required int id,
    required String title,
    // Example: If API returns 'post_content', we map it here to 'body'
    // @JsonKey(name: 'post_content') required String body,
    required String body,
    @Default(false) bool isRead,
  }) = _PostDTO;

  factory PostDTO.fromJson(Map<String, dynamic> json) =>
      _$PostDTOFromJson(json);

  /// Maps this DTO to the clean Domain Entity
  Post toDomain() {
    return Post(id: id, title: title, body: body, isRead: isRead);
  }
}
