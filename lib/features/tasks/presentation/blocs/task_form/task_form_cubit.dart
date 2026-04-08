import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

import 'task_form_state.dart';
import 'subtask_form_item.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final ITaskRepository _taskRepository;
  final IGoalRepository _goalRepository;
  StreamSubscription<Either<Failure, List<Goal>>>? _goalsSub;

  TaskFormCubit(
    this._taskRepository,
    this._goalRepository,
    Task? initialTask, {
    bool isBacklogContext = false,
  }) : super(TaskFormState.initial(
          initialTask,
          createAsBacklog: isBacklogContext && initialTask == null,
        )) {
    _goalsSub = _goalRepository.watchAllGoals().listen(_onGoalsEmitted);
  }

  void _onGoalsEmitted(Either<Failure, List<Goal>> either) {
    if (isClosed) return;
    either.fold(
      (_) => emit(state.copyWith(availableGoals: [])),
      (goals) {
        var nextId = state.selectedGoalId;
        if (nextId != null && !goals.any((g) => g.id == nextId)) {
          nextId = null;
        }
        emit(state.copyWith(availableGoals: goals, selectedGoalId: nextId));
      },
    );
  }

  @override
  Future<void> close() {
    _goalsSub?.cancel();
    return super.close();
  }

  void titleChanged(String value) => emit(state.copyWith(title: value, isModified: true));
  void notesChanged(String value) => emit(state.copyWith(notes: value, isModified: true));
  void priorityChanged(TaskPriority value) => emit(state.copyWith(priority: value, isModified: true));
  void dueDateChanged(DateTime? value) => emit(state.copyWith(dueDate: value, isModified: true));
  void dueTimeChanged(String? value) => emit(state.copyWith(dueTime: value, isModified: true));
  void hasEnabledReminderChanged(bool value) => emit(state.copyWith(hasEnabledReminder: value, isModified: true));
  void syncToGcalChanged(bool value) => emit(state.copyWith(syncToGcal: value, isModified: true));
  void goalIdChanged(String? goalId) => emit(state.copyWith(selectedGoalId: goalId, isModified: true));

  void isRepeatingChanged(bool value) {
    if (value) {
      emit(state.copyWith(
        isRepeating: true,
        recurrenceFrequency: RecurrenceFrequency.DAILY,
        recurrenceDaysOfWeek: [],
        isModified: true,
      ));
    } else {
      emit(state.copyWith(
        isRepeating: false,
        recurrenceFrequency: null,
        recurrenceDaysOfWeek: [],
        isModified: true,
      ));
    }
  }

  void recurrenceFrequencyChanged(RecurrenceFrequency value) {
    emit(state.copyWith(
      recurrenceFrequency: value,
      recurrenceDaysOfWeek: value == RecurrenceFrequency.WEEKLY ? weekdaysPreset : [],
      isModified: true,
    ));
  }

  void recurrenceDaysOfWeekChanged(List<int> days) {
    emit(state.copyWith(recurrenceDaysOfWeek: List<int>.from(days), isModified: true));
  }

  void toggleRecurrenceDay(int weekday) {
    final current = List<int>.from(state.recurrenceDaysOfWeek);
    if (current.contains(weekday)) {
      current.remove(weekday);
    } else {
      current.add(weekday);
      current.sort();
    }
    emit(state.copyWith(recurrenceDaysOfWeek: current, isModified: true));
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
      isModified: true,
    ));
  }

  void removeSubtaskAt(int index) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    emit(state.copyWith(
      subtaskItems: [
        ...state.subtaskItems.take(index),
        ...state.subtaskItems.skip(index + 1),
      ],
      isModified: true,
    ));
  }

  void updateSubtaskAt(int index, String title) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    final updated = List<SubtaskFormItem>.from(state.subtaskItems);
    updated[index] = updated[index].copyWith(title: title.trim());
    emit(state.copyWith(subtaskItems: updated, isModified: true));
  }

  void toggleSubtaskCompletedAt(int index) {
    if (index < 0 || index >= state.subtaskItems.length) return;
    final oldList = List<SubtaskFormItem>.from(state.subtaskItems);
    final item = oldList[index];
    final updatedItem = item.copyWith(isCompleted: !item.isCompleted);
    oldList[index] = updatedItem;

    final pending = oldList.where((e) => !e.isCompleted).toList();
    final completed = oldList.where((e) => e.isCompleted).toList();
    final updated = [...pending, ...completed];

    emit(state.copyWith(subtaskItems: updated));

    // Save silently so the today page reflects changes immediately
    _saveSilently();
  }

  Future<void> _saveSilently() async {
    if (state.initialTask == null) return;
    final taskId = state.initialTask!.id;
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

    final task = state.initialTask!.copyWith(
      title: state.title,
      notes: state.notes.isEmpty ? null : state.notes,
      priority: state.priority,
      dueDate: state.dueDate,
      dueTime: state.dueTime,
      hasEnabledReminder: state.hasEnabledReminder,
      subtasks: subtasks,
      syncToGcal: state.syncToGcal,
      goalId: state.selectedGoalId,
      updatedAt: now,
    );

    // We do not await or handle failure/success here to avoid disrupting the UI
    _taskRepository.updateTask(task);
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

    final goalId = state.selectedGoalId;

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
          goalId: goalId,
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
          goalId: goalId,
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

  /// Moves the current task to backlog by clearing due date/time and saving.
  /// No-op if no initial task or task has no due date.
  Future<void> moveToBacklog() async {
    final t = state.initialTask;
    if (t == null || (t.dueDate == null && t.dueTime == null)) return;
    emit(state.copyWith(isSubmitting: true, error: null));
    final now = DateTime.now();
    final updated = t.copyWith(
      dueDate: null,
      dueTime: null,
      updatedAt: now,
    );
    final result = await _taskRepository.updateTask(updated);
    result.fold(
      (failure) => emit(state.copyWith(
          isSubmitting: false, error: failure.errorMessage)),
      (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }
}
