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
    on<PushToTomorrow>(_onPushToTomorrow);
    on<DeleteTask>(_onDeleteTask);
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
    final pending = tasks
        .where((t) => t.status == TaskStatus.pending && !t.isOverdue)
        .toList();
    final completed =
        tasks.where((t) => t.status == TaskStatus.completed).toList();
    final overdue = tasks
        .where((t) => t.isOverdue && t.status != TaskStatus.completed)
        .toList();

    return TaskListState.loaded(
      pending: pending,
      completed: completed,
      overdue: overdue,
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
