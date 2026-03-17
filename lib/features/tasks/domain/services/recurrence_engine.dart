import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class RecurrenceEngine {
  /// Calculates the next occurrence of a task based on its recurrence rule.
  DateTime? getNextOccurrence(Task task);
}

class RecurrenceEngineImpl implements RecurrenceEngine {
  @override
  DateTime? getNextOccurrence(Task task) {
    if (task.recurrenceRule == null) return null;
    // Basic implementation for now - adds one interval (e.g., 1 day/week/month)
    final rule = task.recurrenceRule!;
    final current = task.dueDate ?? DateTime.now();
    
    switch (rule.frequency.name.toUpperCase()) {
      case 'DAILY':
        return current.add(Duration(days: rule.intervalVal));
      case 'WEEKLY':
        return current.add(Duration(days: 7 * rule.intervalVal));
      case 'MONTHLY':
        // Simple month addition (approximated for now)
        return DateTime(current.year, current.month + rule.intervalVal, current.day);
      case 'YEARLY':
        return DateTime(current.year + rule.intervalVal, current.month, current.day);
      default:
        return null;
    }
  }
}
