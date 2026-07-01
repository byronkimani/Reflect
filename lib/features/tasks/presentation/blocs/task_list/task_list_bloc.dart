import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'task_list_event.dart';
import 'task_list_state.dart';

typedef ProcessTaskArgs = ({
  List<Task> rawTasks,
  SortMode sortMode,
  TaskListFilter filter,
});

(List<Task>, List<Task>, List<Task>) _computeProcessTasks(ProcessTaskArgs args) {
  return processTasks(args.rawTasks, args.sortMode, args.filter);
}

bool get _isTestEnv => !kIsWeb && Platform.environment.containsKey('FLUTTER_TEST');

/// Task lists smaller than this are processed on the main isolate to avoid
/// compute() marshalling overhead.
const _isolateTaskThreshold = 50;

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final ITaskRepository _taskRepository;

  /// When false, lists at or above [_isolateTaskThreshold] use [compute].
  @visibleForTesting
  final bool processOnMainIsolate;

  TaskListBloc(
    this._taskRepository, {
    bool? processOnMainIsolate,
  })  : processOnMainIsolate = processOnMainIsolate ?? _isTestEnv,
        super(const TaskListState.initial()) {
    // 1. Loading events (Today tasks or Backlog tasks)
    // Use a single on<TaskListEvent> for these to ensure they are mutually exclusive via restartable().
    on<TaskListEvent>(
      (event, emit) async {
        if (event is LoadTasksForDate) {
          await _onLoadTasksForDate(event, emit);
        } else if (event is LoadBacklog) {
          await _onLoadBacklog(event, emit);
        }
      },
      transformer: (events, mapper) {
        final loadEvents = events.where((e) => e is LoadTasksForDate || e is LoadBacklog);
        return restartable<TaskListEvent>().call(loadEvents, mapper);
      },
    );

    // 2. Action events (complete, delete, etc.)
    // Use default concurrent() to allow multiple independent operations.
    on<CompleteTask>(_onCompleteTask);
    on<ReopenTask>(_onReopenTask);
    on<PushToTomorrow>(_onPushToTomorrow);
    on<DeleteTask>(_onDeleteTask);
    on<BulkCompleteTasks>(_onBulkCompleteTasks);
    on<BulkReopenTasks>(_onBulkReopenTasks);
    on<BulkMoveToBacklog>(_onBulkMoveToBacklog);
    on<BulkDeleteTasks>(_onBulkDeleteTasks);
    on<SortChanged>(_onSortChanged);
    on<FilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoadTasksForDate(
    LoadTasksForDate event,
    Emitter<TaskListState> emit,
  ) async {
    _emitLoadingIfNeeded(emit);
    final stream = _taskRepository.watchTasksForDate(event.date).asyncMap(
      (result) async => await result.fold(
        (failure) async => TaskListState.error(failure.errorMessage),
        (tasks) async => await _mapTasksToState(tasks),
      ),
    );
    await emit.forEach<TaskListState>(
      stream,
      onData: (state) => state,
    );
  }

  Future<void> _onLoadBacklog(
    LoadBacklog event,
    Emitter<TaskListState> emit,
  ) async {
    _emitLoadingIfNeeded(emit);
    final stream = _taskRepository.watchBacklogTasks().asyncMap(
      (result) async => await result.fold(
        (failure) async => TaskListState.error(failure.errorMessage),
        (tasks) async => await _mapTasksToState(tasks),
      ),
    );
    await emit.forEach<TaskListState>(
      stream,
      onData: (state) => state,
    );
  }

  void _emitLoadingIfNeeded(Emitter<TaskListState> emit) {
    final showLoading = state.maybeWhen(
      initial: () => true,
      error: (_) => true,
      orElse: () => false,
    );
    if (showLoading) {
      emit(const TaskListState.loading());
    }
  }

  Future<(List<Task>, List<Task>, List<Task>)> _processTasks(
    List<Task> rawTasks,
    SortMode sortMode,
    TaskListFilter filter,
  ) async {
    final args = (rawTasks: rawTasks, sortMode: sortMode, filter: filter);
    if (processOnMainIsolate || rawTasks.length < _isolateTaskThreshold) {
      return _computeProcessTasks(args);
    }
    return compute(_computeProcessTasks, args);
  }

  Future<TaskListState> _mapTasksToState(List<Task> tasks) async {
    final sortMode = state.maybeWhen(
      loaded: (raw, p, c, o, s, f) => s,
      orElse: () => SortMode.statusPendingFirst,
    );
    final filter = state.maybeWhen(
      loaded: (raw, p, c, o, s, f) => f,
      orElse: () => const TaskListFilter(),
    );

    final (overdue, pending, completed) = await _processTasks(
      tasks,
      sortMode,
      filter,
    );

    return TaskListState.loaded(
      rawTasks: tasks,
      pending: pending,
      completed: completed,
      overdue: overdue,
      sortMode: sortMode,
      filter: filter,
    );
  }

  Future<void> _onSortChanged(SortChanged event, Emitter<TaskListState> emit) async {
    await state.maybeWhen(
      loaded: (rawTasks, p, c, o, _, filter) async {
        final (overdue, pending, completed) = await _processTasks(
          rawTasks,
          event.sortMode,
          filter,
        );
        emit(TaskListState.loaded(
          rawTasks: rawTasks,
          pending: pending,
          completed: completed,
          overdue: overdue,
          sortMode: event.sortMode,
          filter: filter,
        ));
      },
      orElse: () async {},
    );
  }

  Future<void> _onFilterChanged(FilterChanged event, Emitter<TaskListState> emit) async {
    await state.maybeWhen(
      loaded: (rawTasks, _, _, _, sortMode, _) async {
        if (rawTasks.isEmpty) {
          emit(
            TaskListState.loaded(
              rawTasks: rawTasks,
              pending: const [],
              completed: const [],
              overdue: const [],
              sortMode: sortMode,
              filter: event.filter,
            ),
          );
          return;
        }
        final (overdue, pending, completed) = await _processTasks(
          rawTasks,
          sortMode,
          event.filter,
        );
        emit(TaskListState.loaded(
          rawTasks: rawTasks,
          pending: pending,
          completed: completed,
          overdue: overdue,
          sortMode: sortMode,
          filter: event.filter,
        ));
      },
      orElse: () async {},
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
    // Not yet implemented in the repository; preserve the loaded list state.
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

  Future<void> _onBulkCompleteTasks(
    BulkCompleteTasks event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.completeTasks(event.ids);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null,
    );
  }

  Future<void> _onBulkReopenTasks(
    BulkReopenTasks event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.reopenTasks(event.ids);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null,
    );
  }

  Future<void> _onBulkMoveToBacklog(
    BulkMoveToBacklog event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.moveTasksToBacklog(event.ids);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null,
    );
  }

  Future<void> _onBulkDeleteTasks(
    BulkDeleteTasks event,
    Emitter<TaskListState> emit,
  ) async {
    final result = await _taskRepository.deleteTasks(event.ids);
    result.fold(
      (failure) => emit(TaskListState.error(failure.errorMessage)),
      (_) => null,
    );
  }
}
