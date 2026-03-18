import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

import 'subtask_form_item.dart';

part 'task_form_state.freezed.dart';

@freezed
abstract class TaskFormState with _$TaskFormState {
  const factory TaskFormState({
    @Default('') String title,
    @Default('') String notes,
    @Default(TaskPriority.p4) TaskPriority priority,
    DateTime? dueDate,
    @Default([]) List<SubtaskFormItem> subtaskItems,
    @Default(false) bool syncToGcal,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? error,
    Task? initialTask,
  }) = _TaskFormState;

  factory TaskFormState.initial(Task? task) => TaskFormState(
    title: task?.title ?? '',
    notes: task?.notes ?? '',
    priority: task?.priority ?? TaskPriority.p4,
    dueDate: task?.dueDate ?? (task == null ? DateTime.now() : null),
    subtaskItems: task?.subtasks
            .map((s) => SubtaskFormItem(
                  id: s.id,
                  title: s.title,
                  isCompleted: s.isCompleted,
                ))
            .toList() ??
        [],
    syncToGcal: task?.syncToGcal ?? false,
    initialTask: task,
  );
}
