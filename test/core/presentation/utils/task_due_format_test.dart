import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/utils/task_due_format.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  final reference = DateTime(2026, 3, 18, 12, 0);

  Task task({
    DateTime? dueDate,
    String? dueTime,
    bool isOverdue = false,
  }) =>
      Task(
        id: 't1',
        title: 'Task',
        dueDate: dueDate,
        dueTime: dueTime,
        isOverdue: isOverdue,
        createdAt: reference,
        updatedAt: reference,
      );

  group('formatTaskRelativeDue', () {
    test('returns empty when no due date or time', () {
      expect(
        formatTaskRelativeDue(task(), reference: reference),
        '',
      );
    });

    test('returns formatted time when due today with time', () {
      final result = formatTaskRelativeDue(
        task(dueDate: reference, dueTime: '14:30'),
        reference: reference,
      );
      expect(result, isNotEmpty);
      expect(result.contains('2:30') || result.contains('14:30'), isTrue);
    });

    test('returns Tomorrow for due tomorrow', () {
      final tomorrow = reference.add(const Duration(days: 1));
      expect(
        formatTaskRelativeDue(task(dueDate: tomorrow), reference: reference),
        'Tomorrow',
      );
    });

    test('returns Yesterday when overdue by one day', () {
      final yesterday = reference.subtract(const Duration(days: 1));
      expect(
        formatTaskRelativeDue(
          task(dueDate: yesterday, isOverdue: true),
          reference: reference,
        ),
        'Yesterday',
      );
    });

    test('returns N days late when overdue by multiple days', () {
      final threeDaysAgo = reference.subtract(const Duration(days: 3));
      expect(
        formatTaskRelativeDue(
          task(dueDate: threeDaysAgo, isOverdue: true),
          reference: reference,
        ),
        '3 days late',
      );
    });

    test('returns MMM d for future dates beyond tomorrow', () {
      final nextWeek = DateTime(2026, 3, 25);
      expect(
        formatTaskRelativeDue(task(dueDate: nextWeek), reference: reference),
        'Mar 25',
      );
    });

    test('returns raw time string when time format is invalid', () {
      expect(
        formatTaskRelativeDue(
          task(dueTime: 'invalid'),
          reference: reference,
        ),
        'invalid',
      );
    });
  });
}
