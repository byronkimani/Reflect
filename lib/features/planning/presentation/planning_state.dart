import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

part 'planning_state.freezed.dart';

@freezed
abstract class PlanningState with _$PlanningState {
  const factory PlanningState({
    @Default(false) bool isLoading,
    @Default([]) List<Task> yesterdayIncomplete,
    @Default([]) List<Task> backlogTasks,
    @Default({}) Set<String> pulledTodayIds,
    String? error,
  }) = _PlanningState;
}
