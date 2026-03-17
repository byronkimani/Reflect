import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'planning_state.dart';

class PlanningCubit extends Cubit<PlanningState> {
  final TaskRepository _taskRepository;

  PlanningCubit(this._taskRepository) : super(const PlanningState());

  Future<void> loadPlanningData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final yesterday = await _taskRepository.getYesterdayIncomplete();
      final backlog = await _taskRepository.getBacklogTasks();
      emit(state.copyWith(
        isLoading: false,
        yesterdayIncomplete: yesterday,
        backlogTasks: backlog,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> doToday(String taskId) async {
    try {
      await _taskRepository.pullTaskFromBacklog(taskId, DateTime.now());
      final updatedPulledIds = Set<String>.from(state.pulledTodayIds)..add(taskId);
      emit(state.copyWith(pulledTodayIds: updatedPulledIds));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> pushFurther(String taskId, DateTime newDate) async {
    try {
      await _taskRepository.pushTaskFurther(taskId, newDate);
      final updatedYesterday = state.yesterdayIncomplete.where((t) => t.id != taskId).toList();
      emit(state.copyWith(yesterdayIncomplete: updatedYesterday));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> moveToBacklog(String taskId) async {
    try {
      await _taskRepository.moveToBacklog(taskId);
      final updatedYesterday = state.yesterdayIncomplete.where((t) => t.id != taskId).toList();
      emit(state.copyWith(yesterdayIncomplete: updatedYesterday));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> pullFromBacklog(String taskId) async {
    try {
      await _taskRepository.pullTaskFromBacklog(taskId, DateTime.now());
      final updatedBacklog = state.backlogTasks.where((t) => t.id != taskId).toList();
      final updatedPulledIds = Set<String>.from(state.pulledTodayIds)..add(taskId);
      emit(state.copyWith(
        backlogTasks: updatedBacklog,
        pulledTodayIds: updatedPulledIds,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> confirmPlanning() async {
    // Logic to finalize planning session
    emit(const PlanningState()); // Reset or navigate away
  }
}
