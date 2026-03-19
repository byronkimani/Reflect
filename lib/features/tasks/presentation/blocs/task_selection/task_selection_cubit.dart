import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

class TaskSelectionCubit extends Cubit<TaskSelectionState> {
  TaskSelectionCubit() : super(const TaskSelectionState());

  void toggleSelection(String id) {
    final selectedIds = Set<String>.from(state.selectedTaskIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    if (selectedIds.isEmpty) {
      emit(state.copyWith(
        selectedTaskIds: {},
        isSelectionMode: false,
      ));
    } else {
      emit(state.copyWith(
        selectedTaskIds: selectedIds,
        isSelectionMode: true,
      ));
    }
  }

  void selectAll(List<String> ids) {
    emit(state.copyWith(
      selectedTaskIds: Set<String>.from(ids),
      isSelectionMode: true,
    ));
  }

  void clearSelection() {
    emit(state.copyWith(
      selectedTaskIds: {},
      isSelectionMode: false,
    ));
  }

  void enterSelectionMode(String firstId) {
    emit(state.copyWith(
      selectedTaskIds: {firstId},
      isSelectionMode: true,
    ));
  }
}
