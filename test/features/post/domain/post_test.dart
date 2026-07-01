import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/post/domain/post.dart';

void main() {
  group('Post', () {
    test('fromJson and toJson round-trip', () {
      const post = Post(id: 1, title: 'Hello', body: 'World', isRead: true);

      final json = post.toJson();
      final restored = Post.fromJson(json);

      expect(restored, post);
    });
  });
}
