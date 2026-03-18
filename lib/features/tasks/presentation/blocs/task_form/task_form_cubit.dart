import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
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
  void dueTimeChanged(String? value) => emit(state.copyWith(dueTime: value));
  void hasEnabledReminderChanged(bool value) => emit(state.copyWith(hasEnabledReminder: value));
  void syncToGcalChanged(bool value) => emit(state.copyWith(syncToGcal: value));

  void isRepeatingChanged(bool value) {
    if (value) {
      emit(state.copyWith(
        isRepeating: true,
        recurrenceFrequency: RecurrenceFrequency.DAILY,
        recurrenceDaysOfWeek: [],
      ));
    } else {
      emit(state.copyWith(
        isRepeating: false,
        recurrenceFrequency: null,
        recurrenceDaysOfWeek: [],
      ));
    }
  }

  void recurrenceFrequencyChanged(RecurrenceFrequency value) {
    emit(state.copyWith(
      recurrenceFrequency: value,
      recurrenceDaysOfWeek: value == RecurrenceFrequency.WEEKLY ? weekdaysPreset : [],
    ));
  }

  void recurrenceDaysOfWeekChanged(List<int> days) {
    emit(state.copyWith(recurrenceDaysOfWeek: List<int>.from(days)));
  }

  void toggleRecurrenceDay(int weekday) {
    final current = List<int>.from(state.recurrenceDaysOfWeek);
    if (current.contains(weekday)) {
      current.remove(weekday);
    } else {
      current.add(weekday);
      current.sort();
    }
    emit(state.copyWith(recurrenceDaysOfWeek: current));
  }

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

    RecurrenceRule? recurrenceRule;
    if (state.isRepeating && state.recurrenceFrequency != null) {
      final ruleId = state.initialTask?.recurrenceRule?.id ?? const Uuid().v4();
      if (state.recurrenceFrequency == RecurrenceFrequency.DAILY) {
        recurrenceRule = RecurrenceRule(
          id: ruleId,
          frequency: RecurrenceFrequency.DAILY,
          intervalVal: 1,
          endType: RecurrenceEndType.NEVER,
        );
      } else {
        final days = state.recurrenceDaysOfWeek.isNotEmpty
            ? state.recurrenceDaysOfWeek
            : weekdaysPreset;
        recurrenceRule = RecurrenceRule(
          id: ruleId,
          frequency: RecurrenceFrequency.WEEKLY,
          intervalVal: 1,
          daysOfWeek: days,
          endType: RecurrenceEndType.NEVER,
        );
      }
    }

    final task = state.initialTask?.copyWith(
          title: state.title,
          notes: notes,
          priority: state.priority,
          dueDate: state.dueDate,
          dueTime: state.dueTime,
          hasEnabledReminder: state.hasEnabledReminder,
          recurrenceRule: recurrenceRule,
          recurrenceParentId: null,
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
          dueTime: state.dueTime,
          hasEnabledReminder: state.hasEnabledReminder,
          recurrenceRule: recurrenceRule,
          recurrenceParentId: null,
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
