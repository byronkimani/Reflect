import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

import 'subtask_form_item.dart';

part 'task_form_state.freezed.dart';

/// Weekday constants for recurrence: 1 = Monday .. 7 = Sunday (DateTime.weekday).
const List<int> weekdaysPreset = [DateTime.monday, DateTime.tuesday, DateTime.wednesday, DateTime.thursday, DateTime.friday];
const List<int> everyDayPreset = [1, 2, 3, 4, 5, 6, 7];
const List<int> weekendPreset = [DateTime.saturday, DateTime.sunday];

@freezed
abstract class TaskFormState with _$TaskFormState {
  const factory TaskFormState({
    @Default('') String title,
    @Default('') String notes,
    @Default(TaskPriority.p4) TaskPriority priority,
    DateTime? dueDate,
    String? dueTime,
    @Default([]) List<SubtaskFormItem> subtaskItems,
    @Default(false) bool hasEnabledReminder,
    @Default(false) bool isRepeating,
    RecurrenceFrequency? recurrenceFrequency,
    @Default([]) List<int> recurrenceDaysOfWeek,
    @Default(false) bool syncToGcal,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? error,
    Task? initialTask,
    @Default([]) List<Goal> availableGoals,
    String? selectedGoalId,
    @Default(false) bool isModified,
  }) = _TaskFormState;

  factory TaskFormState.initial(Task? task, {bool createAsBacklog = false}) {
    RecurrenceFrequency? freq;
    List<int> days = [];
    if (task?.recurrenceRule != null) {
      final r = task!.recurrenceRule!;
      freq = r.frequency;
      days = r.daysOfWeek ?? [];
    }
    final initialDueDate = task?.dueDate ??
        (task == null && !createAsBacklog ? DateTime.now() : null);
    return TaskFormState(
      title: task?.title ?? '',
      notes: task?.notes ?? '',
      priority: task?.priority ?? TaskPriority.p4,
      dueDate: initialDueDate,
      dueTime: task?.dueTime,
      subtaskItems: (() {
        final subs = (task?.subtasks ?? const []);
        final pending = subs.where((s) => !s.isCompleted).toList();
        final completed = subs.where((s) => s.isCompleted).toList();
        return [...pending, ...completed]
            .map((s) => SubtaskFormItem(
                  id: s.id,
                  title: s.title,
                  isCompleted: s.isCompleted,
                ))
            .toList();
      })(),
      hasEnabledReminder: task?.hasEnabledReminder ?? false,
      isRepeating: task?.recurrenceRule != null,
      recurrenceFrequency: freq,
      recurrenceDaysOfWeek: days.isNotEmpty ? days : weekdaysPreset,
      syncToGcal: task?.syncToGcal ?? false,
      initialTask: task,
      selectedGoalId: task?.goalId,
    );
  }
}
