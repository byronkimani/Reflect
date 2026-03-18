import 'package:freezed_annotation/freezed_annotation.dart';
import 'subtask.dart';
import 'tag.dart';
import 'recurrence_rule.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskPriority { p1, p2, p3, p4 }

enum TaskStatus { pending, completed, overdue }

@freezed
abstract class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String title,
    @Default(TaskPriority.p4) TaskPriority priority,
    DateTime? dueDate,
    String? dueTime,
    String? notes,
    @Default([]) List<Tag> tags,
    @Default(TaskStatus.pending) TaskStatus status,
    @Default(false) bool isOverdue,
    @Default(0) int overdueDay,
    RecurrenceRule? recurrenceRule,
    String? recurrenceParentId,
    @Default([]) List<Subtask> subtasks,
    String? gcalEventId,
    @Default(false) bool syncToGcal,
    @Default(false) bool hasEnabledReminder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  bool get hasSubtasks => subtasks.isNotEmpty;
  int get completedSubtasks => subtasks.where((s) => s.isCompleted).length;
  bool get allSubtasksDone =>
      hasSubtasks && subtasks.every((s) => s.isCompleted);
  bool get isBacklog => dueDate == null;
}
