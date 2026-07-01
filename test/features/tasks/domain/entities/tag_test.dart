import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/tag.dart';

void main() {
  group('Tag', () {
    final createdAt = DateTime(2025, 4, 10, 8, 30);

    test('fromJson deserializes all fields', () {
      final tag = Tag.fromJson({
        'id': 'tag-1',
        'name': 'Work',
        'colour': '#FF5733',
        'createdAt': createdAt.toIso8601String(),
      });

      expect(tag.id, 'tag-1');
      expect(tag.name, 'Work');
      expect(tag.colour, '#FF5733');
      expect(tag.createdAt, createdAt);
    });

    test('toJson round-trips through fromJson', () {
      final original = Tag(
        id: 'tag-2',
        name: 'Personal',
        colour: '#33FF57',
        createdAt: createdAt,
      );

      final restored = Tag.fromJson(original.toJson());

      expect(restored, original);
    });

    test('copyWith updates name and colour', () {
      final tag = Tag(
        id: 'tag-3',
        name: 'Old',
        colour: '#000000',
        createdAt: createdAt,
      );

      final updated = tag.copyWith(name: 'New', colour: '#FFFFFF');

      expect(updated.name, 'New');
      expect(updated.colour, '#FFFFFF');
      expect(updated.id, tag.id);
    });
  });
}
