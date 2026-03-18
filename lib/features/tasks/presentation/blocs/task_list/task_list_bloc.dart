import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'task_list_event.dart';
import 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final ITaskRepository _taskRepository;

  TaskListBloc(this._taskRepository) : super(const TaskListState.initial()) {
    on<LoadTasksForDate>(_onLoadTasksForDate);
    on<LoadBacklog>(_onLoadBacklog);
    on<CompleteTask>(_onCompleteTask);
    on<ReopenTask>(_onReopenTask);
    on<PushToTomorrow>(_onPushToTomorrow);
    on<DeleteTask>(_onDeleteTask);
    on<SortChanged>(_onSortChanged);
    on<FilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoadTasksForDate(
    LoadTasksForDate event,
    Emitter<TaskListState> emit,
  ) async {
    emit(const TaskListState.loading());
    await emit.forEach<fpdart.Either<Failure, List<Task>>>(
      _taskRepository.watchTasksForDate(event.date),
      onData: (result) => result.fold(
        (failure) => TaskListState.error(failure.errorMessage),
        (tasks) => _mapTasksToState(tasks),
      ),
    );
  }

  Future<void> _onLoadBacklog(
    LoadBacklog event,
    Emitter<TaskListState> emit,
  ) async {
    emit(const TaskListState.loading());
    await emit.forEach<fpdart.Either<Failure, List<Task>>>(
      _taskRepository.watchBacklogTasks(),
      onData: (result) => result.fold(
        (failure) => TaskListState.error(failure.errorMessage),
        (tasks) => _mapTasksToState(tasks),
      ),
    );
  }

  TaskListState _mapTasksToState(List<Task> tasks) {
    // Partition so each task appears in exactly one list (avoids duplicate in UI).
    final List<Task> pending = [];
    final List<Task> completed = [];
    final List<Task> overdue = [];
    for (final t in tasks) {
      if (t.status == TaskStatus.completed) {
        completed.add(t);
      } else if (t.isOverdue) {
        overdue.add(t);
      } else {
        pending.add(t);
      }
    }

    final sortMode = state.maybeWhen(
      loaded: (pending, completed, overdue, s, f) => s,
      orElse: () => SortMode.statusPendingFirst,
    );
    final filter = state.maybeWhen(
      loaded: (pending, completed, overdue, s, f) => f,
      orElse: () => const TaskListFilter(),
    );

    return TaskListState.loaded(
      pending: pending,
      completed: completed,
      overdue: overdue,
      sortMode: sortMode,
      filter: filter,
    );
  }

  void _onSortChanged(SortChanged event, Emitter<TaskListState> emit) {
    state.maybeWhen(
      loaded: (p, c, o, _, filter) => emit(TaskListState.loaded(
        pending: p,
        completed: c,
        overdue: o,
        sortMode: event.sortMode,
        filter: filter,
      )),
      orElse: () {},
    );
  }

  void _onFilterChanged(FilterChanged event, Emitter<TaskListState> emit) {
    state.maybeWhen(
      loaded: (p, c, o, sortMode, _) => emit(TaskListState.loaded(
        pending: p,
        completed: c,
        overdue: o,
        sortMode: sortMode,
        filter: event.filter,
      )),
      orElse: () {},
    );
  }

  Future<void> _onCompleteTask(
    CompleteTask event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.completeTask(event.id);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null, // State will update via broadcast stream
    );
  }

  Future<void> _onReopenTask(
    ReopenTask event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.reopenTask(event.id);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null, // State will update via broadcast stream
    );
  }

  Future<void> _onPushToTomorrow(
    PushToTomorrow event,
    Emitter<TaskListState> emit,
  ) async {
    emit(const TaskListState.error("Push to tomorrow logic not yet implemented in repository"));
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.deleteTask(event.id);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null,
    );
  }
}
