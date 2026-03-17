import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'planning_state.dart';

class PlanningCubit extends Cubit<PlanningState> {
  final ITaskRepository _taskRepository;

  PlanningCubit(this._taskRepository) : super(const PlanningState());

  Future<void> loadPlanningData() async {
    emit(state.copyWith(isLoading: true));

    final yesterday = await _taskRepository.getTasksForDate(
      DateTime.now().subtract(const Duration(days: 1)),
    );
    final backlog = await _taskRepository.getBacklogTasks();

    yesterday.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (yesterdayTasks) {
        backlog.fold(
          (failure) => emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
          (backlogTasks) {
            final incomplete = yesterdayTasks
                .where((t) => t.status != TaskStatus.completed)
                .toList();
            emit(state.copyWith(
              isLoading: false,
              yesterdayIncomplete: incomplete,
              backlogTasks: backlogTasks,
            ));
          },
        );
      },
    );
  }

  Future<void> doToday(Task task) async {
    final updatedTask = task.copyWith(
      dueDate: DateTime.now(),
      status: TaskStatus.pending,
      updatedAt: DateTime.now(),
    );
    final result = await _taskRepository.updateTask(updatedTask);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.errorMessage)),
      (_) {
        final updatedPulledIds = Set<String>.from(state.pulledTodayIds)
          ..add(task.id);
        emit(state.copyWith(pulledTodayIds: updatedPulledIds));
      },
    );
  }

  Future<void> pushFurther(Task task, DateTime newDate) async {
    final updatedTask = task.copyWith(
      dueDate: newDate,
      updatedAt: DateTime.now(),
    );
    final result = await _taskRepository.updateTask(updatedTask);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.errorMessage)),
      (_) {
        final updatedYesterday =
            state.yesterdayIncomplete.where((t) => t.id != task.id).toList();
        emit(state.copyWith(yesterdayIncomplete: updatedYesterday));
      },
    );
  }

  Future<void> moveToBacklog(Task task) async {
    final updatedTask = task.copyWith(
      dueDate: null,
      updatedAt: DateTime.now(),
    );
    final result = await _taskRepository.updateTask(updatedTask);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.errorMessage)),
      (_) {
        final updatedYesterday =
            state.yesterdayIncomplete.where((t) => t.id != task.id).toList();
        final updatedBacklog = List<Task>.from(state.backlogTasks)..add(updatedTask);
        emit(state.copyWith(
          yesterdayIncomplete: updatedYesterday,
          backlogTasks: updatedBacklog,
        ));
      },
    );
  }

  Future<void> confirmPlanning() async {
    emit(const PlanningState());
  }
}
