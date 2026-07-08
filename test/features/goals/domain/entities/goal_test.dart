import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  final now = DateTime(2026, 3, 18);

  Goal baseGoal() => Goal(
        id: 'g1',
        title: 'Run marathon',
        timeHorizon: GoalTimeHorizon.yearly,
        createdAt: now,
        updatedAt: now,
      );

  group('Goal', () {
    test('copyWith updates fields and preserves others', () {
      final goal = baseGoal().copyWith(
        title: 'Updated',
        priority: TaskPriority.p2,
        isMeasurable: true,
      );

      expect(goal.title, 'Updated');
      expect(goal.priority, TaskPriority.p2);
      expect(goal.isMeasurable, isTrue);
      expect(goal.id, 'g1');
      expect(goal.timeHorizon, GoalTimeHorizon.yearly);
    });

    test('equality compares value fields', () {
      expect(baseGoal(), baseGoal());
      expect(baseGoal(), isNot(baseGoal().copyWith(title: 'Other')));
    });
  });
}
