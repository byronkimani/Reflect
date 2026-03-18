import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class RecurrenceEngine {
  /// Calculates the next occurrence of a task based on its recurrence rule.
  DateTime? getNextOccurrence(Task task);
}

class RecurrenceEngineImpl implements RecurrenceEngine {
  @override
  DateTime? getNextOccurrence(Task task) {
    if (task.recurrenceRule == null) return null;
    final rule = task.recurrenceRule!;
    final current = task.dueDate ?? DateTime.now();
    // Use date only for day comparison (weekday).
    final today = DateTime(current.year, current.month, current.day);

    switch (rule.frequency.name.toUpperCase()) {
      case 'DAILY':
        return today.add(Duration(days: rule.intervalVal));
      case 'WEEKLY':
        if (rule.daysOfWeek != null && rule.daysOfWeek!.isNotEmpty) {
          // Find next date that falls on one of the selected weekdays.
          for (var d = 1; d <= 7; d++) {
            final next = today.add(Duration(days: d));
            if (rule.daysOfWeek!.contains(next.weekday)) {
              return next;
            }
          }
          return today.add(const Duration(days: 7));
        }
        return today.add(Duration(days: 7 * rule.intervalVal));
      case 'MONTHLY':
        return DateTime(current.year, current.month + rule.intervalVal, current.day);
      case 'YEARLY':
        return DateTime(current.year + rule.intervalVal, current.month, current.day);
      default:
        return null;
    }
  }
}
