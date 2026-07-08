import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

void main() {
  final now = DateTime(2026, 3, 18, 12, 0);

  Task makeTask({
    required String id,
    TaskStatus status = TaskStatus.pending,
    TaskPriority priority = TaskPriority.p4,
    DateTime? dueDate,
    String? dueTime,
    bool isOverdue = false,
    RecurrenceRule? recurrenceRule,
  }) =>
      Task(
        id: id,
        title: id,
        status: status,
        priority: priority,
        dueDate: dueDate,
        dueTime: dueTime,
        isOverdue: isOverdue,
        recurrenceRule: recurrenceRule,
        createdAt: now,
        updatedAt: now,
      );

  group('TaskListFilter.copyWith', () {
    test('preserves unspecified fields', () {
      const filter = TaskListFilter(
        priorities: {TaskPriority.p1},
        hasDueTimeOnly: true,
        repeatingOnly: false,
        statusFilter: TaskStatusFilter.pendingOnly,
      );

      final updated = filter.copyWith(statusFilter: TaskStatusFilter.all);

      expect(updated.priorities, {TaskPriority.p1});
      expect(updated.hasDueTimeOnly, isTrue);
      expect(updated.repeatingOnly, isFalse);
      expect(updated.statusFilter, TaskStatusFilter.all);
    });
  });

  group('processTasks', () {
    final pendingP1 = makeTask(id: 'p1', priority: TaskPriority.p1);
    final pendingP4 = makeTask(id: 'p4', priority: TaskPriority.p4);
    final completed = makeTask(id: 'done', status: TaskStatus.completed);
    final overdue = makeTask(
      id: 'late',
      isOverdue: true,
      dueDate: now.subtract(const Duration(days: 1)),
    );

    test('splits tasks into overdue, pending, and completed', () {
      final (o, p, c) = processTasks(
        [pendingP1, completed, overdue],
        SortMode.statusPendingFirst,
        const TaskListFilter(),
      );

      expect(o.map((t) => t.id), ['late']);
      expect(p.map((t) => t.id), ['p1']);
      expect(c.map((t) => t.id), ['done']);
    });

    test('filters by priority', () {
      final (o, p, c) = processTasks(
        [pendingP1, pendingP4],
        SortMode.priority,
        const TaskListFilter(priorities: {TaskPriority.p1}),
      );

      expect(p.map((t) => t.id), ['p1']);
      expect(o, isEmpty);
      expect(c, isEmpty);
    });

    test('filters completedOnly status', () {
      final (o, p, c) = processTasks(
        [pendingP1, completed, overdue],
        SortMode.statusPendingFirst,
        const TaskListFilter(statusFilter: TaskStatusFilter.completedOnly),
      );

      expect(o, isEmpty);
      expect(p, isEmpty);
      expect(c.map((t) => t.id), ['done']);
    });

    test('sorts by priority when SortMode.priority', () {
      final (o, p, c) = processTasks(
        [pendingP4, pendingP1],
        SortMode.priority,
        const TaskListFilter(),
      );

      expect(p.map((t) => t.id), ['p1', 'p4']);
      expect(o, isEmpty);
      expect(c, isEmpty);
    });

    test('sorts repeating tasks first when SortMode.repeats', () {
      final repeating = makeTask(
        id: 'repeat',
        recurrenceRule: RecurrenceRule(
          id: 'r1',
          frequency: RecurrenceFrequency.DAILY,
        ),
      );
      final (o, p, c) = processTasks(
        [pendingP4, repeating],
        SortMode.repeats,
        const TaskListFilter(),
      );

      expect(p.first.id, 'repeat');
      expect(o, isEmpty);
      expect(c, isEmpty);
    });

    test('returns empty lists when input is empty', () {
      final (o, p, c) = processTasks(
        [],
        SortMode.dueDateTime,
        const TaskListFilter(),
      );

      expect(o, isEmpty);
      expect(p, isEmpty);
      expect(c, isEmpty);
    });
  });
}
