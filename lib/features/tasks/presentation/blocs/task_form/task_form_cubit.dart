import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

import 'task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final ITaskRepository _taskRepository;

  TaskFormCubit(this._taskRepository, Task? initialTask)
      : super(TaskFormState.initial(initialTask));

  void titleChanged(String value) => emit(state.copyWith(title: value));
  void notesChanged(String value) => emit(state.copyWith(notes: value));
  void priorityChanged(TaskPriority value) => emit(state.copyWith(priority: value));
  void dueDateChanged(DateTime? value) => emit(state.copyWith(dueDate: value));
  void syncToGcalChanged(bool value) => emit(state.copyWith(syncToGcal: value));

  Future<void> submit() async {
    if (state.title.isEmpty) {
      emit(state.copyWith(error: 'Title cannot be empty'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, error: null));

    final notes = state.notes.isEmpty ? null : state.notes;
    final task = state.initialTask?.copyWith(
          title: state.title,
          notes: notes,
          priority: state.priority,
          dueDate: state.dueDate,
          syncToGcal: state.syncToGcal,
          updatedAt: DateTime.now(),
        ) ??
        Task(
          id: const Uuid().v4(),
          title: state.title,
          priority: state.priority,
          status: TaskStatus.pending,
          dueDate: state.dueDate,
          notes: notes,
          syncToGcal: state.syncToGcal,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
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
