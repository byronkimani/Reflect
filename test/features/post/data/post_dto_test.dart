import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/post/data/post_dto.dart';
import 'package:reflect/features/post/domain/post.dart';

void main() {
  test('PostDTO toDomain maps correctly', () {
    const dto = PostDTO(id: 1, title: 'Test Title', body: 'Test Body', isRead: true);
    final domain = dto.toDomain();
    
    expect(domain.id, 1);
    expect(domain.title, 'Test Title');
    expect(domain.body, 'Test Body');
    expect(domain.isRead, true);
  });
}
