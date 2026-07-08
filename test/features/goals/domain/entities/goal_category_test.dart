import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';

void main() {
  final now = DateTime(2026, 3, 18);

  group('GoalCategory', () {
    test('constructs with default sortOrder', () {
      final category = GoalCategory(
        id: 'c1',
        name: 'Health',
        createdAt: now,
        updatedAt: now,
      );

      expect(category.sortOrder, 0);
      expect(category.name, 'Health');
    });

    test('copyWith updates name', () {
      final category = GoalCategory(
        id: 'c1',
        name: 'Health',
        sortOrder: 2,
        createdAt: now,
        updatedAt: now,
      );

      final updated = category.copyWith(name: 'Fitness');

      expect(updated.name, 'Fitness');
      expect(updated.sortOrder, 2);
    });

    test('equality compares value fields', () {
      final a = GoalCategory(
        id: 'c1',
        name: 'Health',
        createdAt: now,
        updatedAt: now,
      );
      final b = GoalCategory(
        id: 'c1',
        name: 'Health',
        createdAt: now,
        updatedAt: now,
      );

      expect(a, b);
      expect(a, isNot(a.copyWith(name: 'Other')));
    });
  });
}
