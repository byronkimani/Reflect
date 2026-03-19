import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_selection_state.freezed.dart';

@freezed
abstract class TaskSelectionState with _$TaskSelectionState {
  const factory TaskSelectionState({
    @Default(<String>{}) Set<String> selectedTaskIds,
    @Default(false) bool isSelectionMode,
  }) = _TaskSelectionState;
}
