import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/goals/presentation/utils/goal_importance.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  group('GoalImportanceMapper', () {
    test('maps critical to P1/P1', () {
      final (p, u) =
          GoalImportanceMapper.toPriorities(GoalImportance.critical);
      expect(p, TaskPriority.p1);
      expect(u, TaskPriority.p1);
    });

    test('round-trips low importance', () {
      const level = GoalImportance.low;
      final (p, u) = GoalImportanceMapper.toPriorities(level);
      expect(GoalImportanceMapper.fromPriorities(p, u), level);
    });

    test('returns null when both priorities are null', () {
      expect(GoalImportanceMapper.fromPriorities(null, null), isNull);
    });

    test('tap selected again clears via null mapping', () {
      final (p, u) = GoalImportanceMapper.toPriorities(null);
      expect(p, isNull);
      expect(u, isNull);
    });
  });
}
