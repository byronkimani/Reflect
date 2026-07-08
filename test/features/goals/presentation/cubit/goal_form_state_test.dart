import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_state.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  final now = DateTime(2026, 3, 18);

  GoalFormState populated() => GoalFormState(
        title: 'Run',
        description: 'Desc',
        categoryId: 'cat-1',
        priority: TaskPriority.p2,
        urgency: TaskPriority.p1,
        startDate: now,
        targetDate: now.add(const Duration(days: 30)),
        timeHorizon: GoalTimeHorizon.monthly,
      );

  group('GoalFormState.copyWith clear flags', () {
    test('clearDescription nulls description', () {
      final cleared = populated().copyWith(clearDescription: true);
      expect(cleared.description, isNull);
      expect(cleared.title, 'Run');
    });

    test('clearCategoryId nulls categoryId', () {
      final cleared = populated().copyWith(clearCategoryId: true);
      expect(cleared.categoryId, isNull);
    });

    test('clearPriority and clearUrgency null priorities', () {
      final cleared = populated().copyWith(
        clearPriority: true,
        clearUrgency: true,
      );
      expect(cleared.priority, isNull);
      expect(cleared.urgency, isNull);
    });

    test('clearStartDate and clearTargetDate null dates', () {
      final cleared = populated().copyWith(
        clearStartDate: true,
        clearTargetDate: true,
      );
      expect(cleared.startDate, isNull);
      expect(cleared.targetDate, isNull);
    });

    test('clear flags take precedence over provided values', () {
      final cleared = populated().copyWith(
        description: 'New desc',
        clearDescription: true,
        priority: TaskPriority.p1,
        clearPriority: true,
      );
      expect(cleared.description, isNull);
      expect(cleared.priority, isNull);
    });
  });
}
