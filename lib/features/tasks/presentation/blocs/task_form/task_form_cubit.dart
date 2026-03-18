import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

import 'task_form_state.dart';
import 'subtask_form_item.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final ITaskRepository _taskRepository;

  TaskFormCubit(this._taskRepository, Task? initialTask)
      : super(TaskFormState.initial(initialTask));

  void titleChanged(String value) => emit(state.copyWith(title: value));
  void notesChanged(String value) => emit(state.copyWith(notes: value));
  void priorityChanged(TaskPriority value) => emit(state.copyWith(priority: value));
  void dueDateChanged(DateTime? value) => emit(state.copyWith(dueDate: value));
  void syncToGcalChanged(bool value) => emit(state.copyWith(syncToGcal: value));

  void addSubtask([String title = '']) {
    emit(state.copyWith(
      subtaskItems: [
        ...state.subtaskItems,
        SubtaskFormItem(
          id: const Uuid().v4(),
          title: title.trim(),
          isCompleted: false,
        ),
      ],
    ));
  }

  void removeSubtaskAt(int index) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    emit(state.copyWith(
      subtaskItems: [
        ...state.subtaskItems.take(index),
        ...state.subtaskItems.skip(index + 1),
      ],
    ));
  }

  void updateSubtaskAt(int index, String title) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    final updated = List<SubtaskFormItem>.from(state.subtaskItems);
    updated[index] = updated[index].copyWith(title: title.trim());
    emit(state.copyWith(subtaskItems: updated));
  }

  void toggleSubtaskCompletedAt(int index) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    final updated = List<SubtaskFormItem>.from(state.subtaskItems);
    updated[index] = updated[index].copyWith(isCompleted: !updated[index].isCompleted);
    emit(state.copyWith(subtaskItems: updated));
  }

  Future<void> submit() async {
    if (state.title.isEmpty) {
      emit(state.copyWith(error: 'Title cannot be empty'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    final notes = state.notes.isEmpty ? null : state.notes;
    final taskId = state.initialTask?.id ?? const Uuid().v4();
    final now = DateTime.now();
    final subtasks = state.subtaskItems
        .where((item) => item.title.trim().isNotEmpty)
        .toList()
        .asMap()
        .entries
        .map((e) => Subtask(
              id: e.value.id,
              taskId: taskId,
              title: e.value.title.trim(),
              isCompleted: e.value.isCompleted,
              sortOrder: e.key,
              createdAt: now,
            ))
        .toList();

    final task = state.initialTask?.copyWith(
          title: state.title,
          notes: notes,
          priority: state.priority,
          dueDate: state.dueDate,
          subtasks: subtasks,
          syncToGcal: state.syncToGcal,
          updatedAt: now,
        ) ??
        Task(
          id: taskId,
          title: state.title,
          priority: state.priority,
          status: TaskStatus.pending,
          dueDate: state.dueDate,
          notes: notes,
          subtasks: subtasks,
          syncToGcal: state.syncToGcal,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialTask != null
        ? await _taskRepository.updateTask(task)
        : await _taskRepository.createTask(task);

    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, error: failure.errorMessage)),
      (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }
}
