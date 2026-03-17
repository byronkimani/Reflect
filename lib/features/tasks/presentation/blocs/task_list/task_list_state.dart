import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

part 'task_list_state.freezed.dart';

enum SortMode { manual, priority, dueDate }

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.initial() = _Initial;
  const factory TaskListState.loading() = _Loading;
  const factory TaskListState.loaded({
    required List<Task> pending,
    required List<Task> completed,
    required List<Task> overdue,
    @Default(SortMode.manual) SortMode sortMode,
  }) = _Loaded;
  const factory TaskListState.error(String message) = _Error;
}
