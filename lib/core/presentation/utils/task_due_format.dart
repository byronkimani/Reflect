import 'package:intl/intl.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

/// Formats relative due label for task cards.
String formatTaskRelativeDue(Task task, {DateTime? reference}) {
  final now = reference ?? DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  if (task.dueTime != null && task.dueTime!.isNotEmpty && task.dueDate != null) {
    final dueDay = DateTime(
      task.dueDate!.year,
      task.dueDate!.month,
      task.dueDate!.day,
    );
    if (dueDay == today) {
      return _formatTime(task.dueTime!);
    }
  }

  if (task.isOverdue && task.dueDate != null) {
    final dueDay = DateTime(
      task.dueDate!.year,
      task.dueDate!.month,
      task.dueDate!.day,
    );
    final diff = today.difference(dueDay).inDays;
    if (diff == 1) return 'Yesterday';
    if (diff > 1) return '$diff days late';
    return 'Overdue';
  }

  if (task.dueDate != null) {
    final dueDay = DateTime(
      task.dueDate!.year,
      task.dueDate!.month,
      task.dueDate!.day,
    );
    final diff = dueDay.difference(today).inDays;
    if (diff == 0 && task.dueTime != null && task.dueTime!.isNotEmpty) {
      return _formatTime(task.dueTime!);
    }
    if (diff == 1) return 'Tomorrow';
    if (diff > 1) return DateFormat('MMM d').format(task.dueDate!);
  }

  if (task.dueTime != null && task.dueTime!.isNotEmpty) {
    return _formatTime(task.dueTime!);
  }

  return '';
}

String _formatTime(String dueTime) {
  final parts = dueTime.split(':');
  if (parts.length < 2) return dueTime;
  final hour = int.tryParse(parts[0]) ?? 0;
  final minute = int.tryParse(parts[1]) ?? 0;
  final dt = DateTime(2000, 1, 1, hour, minute);
  return DateFormat.jm().format(dt);
}
