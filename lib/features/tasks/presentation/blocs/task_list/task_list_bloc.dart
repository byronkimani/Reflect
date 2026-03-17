import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'task_list_event.dart';
import 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskRepository _taskRepository;
  StreamSubscription<List<Task>>? _tasksSubscription;

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
    await _tasksSubscription?.cancel();
    _tasksSubscription = _taskRepository.watchTasksForDate(event.date).listen(
      (tasks) => _emitLoadedState(tasks, emit),
      onError: (e) => emit(TaskListState.error(e.toString())),
    );
  }

  Future<void> _onLoadBacklog(
    LoadBacklog event,
    Emitter<TaskListState> emit,
  ) async {
    emit(const TaskListState.loading());
    await _tasksSubscription?.cancel();
    _tasksSubscription = _taskRepository.watchBacklog().listen(
      (tasks) => _emitLoadedState(tasks, emit),
      onError: (e) => emit(TaskListState.error(e.toString())),
    );
  }

  void _emitLoadedState(List<Task> tasks, Emitter<TaskListState> emit) {
    final pending = tasks.where((t) => t.status == TaskStatus.pending && !t.isOverdue).toList();
    final completed = tasks.where((t) => t.status == TaskStatus.completed).toList();
    final overdue = tasks.where((t) => t.isOverdue && t.status != TaskStatus.completed).toList();

    emit(TaskListState.loaded(
      pending: pending,
      completed: completed,
      overdue: overdue,
    ));
  }

  Future<void> _onCompleteTask(
    CompleteTask event,
    Emitter<TaskListState> emit,
  ) async {
    try {
      await _taskRepository.completeTask(event.id);
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  Future<void> _onPushToTomorrow(
    PushToTomorrow event,
    Emitter<TaskListState> emit,
  ) async {
    try {
      await _taskRepository.pushToTomorrow(event.id);
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<TaskListState> emit,
  ) async {
    try {
      await _taskRepository.deleteTask(event.id);
    } catch (e) {
      emit(TaskListState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
