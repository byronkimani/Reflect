import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

void main() {
  late DateTime now;

  setUp(() {
    now = DateTime(2025, 3, 15, 12, 0);
  });

  Task task({
    String id = '1',
    String title = 'Task',
    TaskPriority priority = TaskPriority.p4,
    DateTime? dueDate,
    String? dueTime,
    TaskStatus status = TaskStatus.pending,
    bool isOverdue = false,
    RecurrenceRule? recurrenceRule,
  }) {
    return Task(
      id: id,
      title: title,
      priority: priority,
      dueDate: dueDate,
      dueTime: dueTime,
      status: status,
      isOverdue: isOverdue,
      recurrenceRule: recurrenceRule,
      createdAt: now,
      updatedAt: now,
    );
  }

  RecurrenceRule recurrenceRule({String id = 'r1'}) => RecurrenceRule(
        id: id,
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 1,
        endType: RecurrenceEndType.NEVER,
      );

  group('applyTaskListFilterAndSort', () {
    group('default filter', () {
      test('returns all sections unchanged when filter is default and sort is statusPendingFirst', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p2),
          task(id: '2', priority: TaskPriority.p1),
        ];
        final completed = [task(id: '3', priority: TaskPriority.p4, status: TaskStatus.completed)];
        const overdue = <Task>[];

        final (o, p, c) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.statusPendingFirst,
          const TaskListFilter(),
        );

        expect(o, isEmpty);
        expect(p.length, 2);
        expect(c.length, 1);
      });

      test('returns empty sections when statusFilter is completedOnly for overdue and pending', () {
        final pending = [task(id: '1')];
        final completed = [task(id: '2', status: TaskStatus.completed)];
        const overdue = <Task>[];

        final (o, p, c) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(statusFilter: TaskStatusFilter.completedOnly),
        );

        expect(o, isEmpty);
        expect(p, isEmpty);
        expect(c.length, 1);
      });

      test('returns empty completed when statusFilter is pendingOnly', () {
        final pending = [task(id: '1')];
        final completed = [task(id: '2', status: TaskStatus.completed)];
        const overdue = <Task>[];

        final (o, p, c) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly),
        );

        expect(p.length, 1);
        expect(c, isEmpty);
      });
    });

    group('priority filter', () {
      test('filters pending by single priority', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p1),
          task(id: '2', priority: TaskPriority.p2),
          task(id: '3', priority: TaskPriority.p1),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          TaskListFilter(priorities: {TaskPriority.p1}),
        );

        expect(p.length, 2);
        expect(p.every((t) => t.priority == TaskPriority.p1), isTrue);
      });

      test('filters by multiple priorities', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p1),
          task(id: '2', priority: TaskPriority.p3),
          task(id: '3', priority: TaskPriority.p2),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          TaskListFilter(priorities: {TaskPriority.p1, TaskPriority.p2}),
        );

        expect(p.length, 2);
        expect(p.any((t) => t.priority == TaskPriority.p1), isTrue);
        expect(p.any((t) => t.priority == TaskPriority.p2), isTrue);
        expect(p.any((t) => t.priority == TaskPriority.p3), isFalse);
      });

      test('priority null shows all priorities', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p1),
          task(id: '2', priority: TaskPriority.p4),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(),
        );

        expect(p.length, 2);
      });
    });

    group('due time filter', () {
      test('hasDueTimeOnly true keeps only tasks with due time', () {
        final pending = [
          task(id: '1', dueDate: now, dueTime: '10:00'),
          task(id: '2', dueDate: now),
          task(id: '3', dueDate: now, dueTime: '14:30'),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(hasDueTimeOnly: true),
        );

        expect(p.length, 2);
        expect(p.every((t) => t.dueTime != null && t.dueTime!.isNotEmpty), isTrue);
      });

      test('hasDueTimeOnly false keeps only tasks without due time', () {
        final pending = [
          task(id: '1', dueDate: now, dueTime: '10:00'),
          task(id: '2', dueDate: now),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(hasDueTimeOnly: false),
        );

        expect(p.length, 1);
        expect(p.single.id, '2');
      });

      test('hasDueTimeOnly null keeps all', () {
        final pending = [
          task(id: '1', dueTime: '10:00'),
          task(id: '2'),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(),
        );

        expect(p.length, 2);
      });
    });

    group('repeats filter', () {
      test('repeatingOnly true keeps only repeating tasks', () {
        final rule = recurrenceRule();
        final pending = [
          task(id: '1', recurrenceRule: rule),
          task(id: '2'),
          task(id: '3', recurrenceRule: recurrenceRule(id: 'r2')),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(repeatingOnly: true),
        );

        expect(p.length, 2);
        expect(p.every((t) => t.recurrenceRule != null), isTrue);
      });

      test('repeatingOnly false keeps only non-repeating tasks', () {
        final rule = recurrenceRule();
        final pending = [
          task(id: '1', recurrenceRule: rule),
          task(id: '2'),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(repeatingOnly: false),
        );

        expect(p.length, 1);
        expect(p.single.id, '2');
      });
    });

    group('sort modes', () {
      test('SortMode.priority sorts by priority index ascending (P1 first)', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p4),
          task(id: '2', priority: TaskPriority.p1),
          task(id: '3', priority: TaskPriority.p2),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.priority,
          const TaskListFilter(),
        );

        expect(p.map((t) => t.priority).toList(), [TaskPriority.p1, TaskPriority.p2, TaskPriority.p4]);
      });

      test('SortMode.dueDateTime sorts by due date then time, no-time as start of day', () {
        final base = DateTime(2025, 3, 15);
        final pending = [
          task(id: '1', dueDate: base, dueTime: '14:00'),
          task(id: '2', dueDate: base, dueTime: '09:00'),
          task(id: '3', dueDate: base),
          task(id: '4', dueDate: base.add(const Duration(days: 1))),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.dueDateTime,
          const TaskListFilter(),
        );

        expect(p.length, 4);
        expect(p[0].dueTime, isNull);
        expect(p[0].id, '3');
        expect(p[1].dueTime, '09:00');
        expect(p[2].dueTime, '14:00');
        expect(p[3].dueDate, base.add(const Duration(days: 1)));
      });

      test('SortMode.repeats puts repeating tasks first', () {
        final rule = recurrenceRule();
        final pending = [
          task(id: '1'),
          task(id: '2', recurrenceRule: rule),
          task(id: '3'),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.repeats,
          const TaskListFilter(),
        );

        expect(p.length, 3);
        expect(p.first.recurrenceRule, isNotNull);
        expect(p[1].recurrenceRule, isNull);
        expect(p[2].recurrenceRule, isNull);
      });

      test('SortMode.statusPendingFirst sorts by status then priority', () {
        final pending = [
          task(id: '1', priority: TaskPriority.p2, status: TaskStatus.pending),
          task(id: '2', priority: TaskPriority.p1, status: TaskStatus.pending),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.statusPendingFirst,
          const TaskListFilter(),
        );

        expect(p.map((t) => t.priority).toList(), [TaskPriority.p1, TaskPriority.p2]);
      });
    });

    group('combined filter and sort', () {
      test('filters by priority and sort by dueDateTime', () {
        final base = DateTime(2025, 3, 15);
        final pending = [
          task(id: '1', priority: TaskPriority.p1, dueDate: base, dueTime: '14:00'),
          task(id: '2', priority: TaskPriority.p2, dueDate: base, dueTime: '09:00'),
          task(id: '3', priority: TaskPriority.p1, dueDate: base, dueTime: '10:00'),
        ];
        const completed = <Task>[];
        const overdue = <Task>[];

        final (_, p, _) = applyTaskListFilterAndSort(
          overdue,
          pending,
          completed,
          SortMode.dueDateTime,
          TaskListFilter(priorities: {TaskPriority.p1}),
        );

        expect(p.length, 2);
        expect(p[0].dueTime, '10:00');
        expect(p[1].dueTime, '14:00');
      });
    });
  });

  group('TaskListFilter', () {
    test('default has null priorities, hasDueTimeOnly, repeatingOnly and all status', () {
      const f = TaskListFilter();
      expect(f.priorities, isNull);
      expect(f.hasDueTimeOnly, isNull);
      expect(f.repeatingOnly, isNull);
      expect(f.statusFilter, TaskStatusFilter.all);
    });

    test('copyWith preserves unspecified fields', () {
      const f = TaskListFilter(
        priorities: {TaskPriority.p1},
        statusFilter: TaskStatusFilter.pendingOnly,
      );
      final next = f.copyWith(hasDueTimeOnly: true);
      expect(next.priorities, {TaskPriority.p1});
      expect(next.hasDueTimeOnly, true);
      expect(next.repeatingOnly, isNull);
      expect(next.statusFilter, TaskStatusFilter.pendingOnly);
    });

    test('copyWith with explicit value updates the field', () {
      const f = TaskListFilter(priorities: {TaskPriority.p1});
      final next = f.copyWith(priorities: {TaskPriority.p2});
      expect(next.priorities, {TaskPriority.p2});
    });
  });
}
