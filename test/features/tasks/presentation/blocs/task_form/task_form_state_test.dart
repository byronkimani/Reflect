import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';

void main() {
  final now = DateTime(2025, 3, 18, 12);

  Task taskWithRecurrence() => Task(
        id: 'task-1',
        title: 'Weekly sync',
        recurrenceRule: const RecurrenceRule(
          id: 'rule-1',
          frequency: RecurrenceFrequency.WEEKLY,
          daysOfWeek: [1, 3, 5],
        ),
        createdAt: now,
        updatedAt: now,
      );

  test('initial copies recurrence frequency and days from existing task', () {
    final state = TaskFormState.initial(taskWithRecurrence());

    expect(state.isRepeating, isTrue);
    expect(state.recurrenceFrequency, RecurrenceFrequency.WEEKLY);
    expect(state.recurrenceDaysOfWeek, [1, 3, 5]);
  });

  test('initial sets due date to today for new non-backlog tasks', () {
    final state = TaskFormState.initial(null);

    expect(state.dueDate, isNotNull);
    expect(state.initialTask, isNull);
  });

  test('initial leaves due date null for new backlog tasks', () {
    final state = TaskFormState.initial(null, createAsBacklog: true);

    expect(state.dueDate, isNull);
  });
}
