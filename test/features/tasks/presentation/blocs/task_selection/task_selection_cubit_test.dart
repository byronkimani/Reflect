import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

void main() {
  group('TaskSelectionCubit', () {
    late TaskSelectionCubit cubit;

    setUp(() {
      cubit = TaskSelectionCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const TaskSelectionState());
    });

    blocTest<TaskSelectionCubit, TaskSelectionState>(
      'toggleSelection adds ID and enters selection mode when empty',
      build: () => cubit,
      act: (cubit) => cubit.toggleSelection('1'),
      expect: () => [
        const TaskSelectionState(selectedTaskIds: {'1'}, isSelectionMode: true),
      ],
    );

    blocTest<TaskSelectionCubit, TaskSelectionState>(
      'toggleSelection removes ID and exits selection mode when last ID removed',
      build: () => cubit,
      seed: () => const TaskSelectionState(selectedTaskIds: {'1'}, isSelectionMode: true),
      act: (cubit) => cubit.toggleSelection('1'),
      expect: () => [
        const TaskSelectionState(),
      ],
    );

    blocTest<TaskSelectionCubit, TaskSelectionState>(
      'toggleSelection adds multiple IDs',
      build: () => cubit,
      act: (cubit) => cubit..toggleSelection('1')..toggleSelection('2'),
      expect: () => [
        const TaskSelectionState(selectedTaskIds: {'1'}, isSelectionMode: true),
        const TaskSelectionState(selectedTaskIds: {'1', '2'}, isSelectionMode: true),
      ],
    );

    blocTest<TaskSelectionCubit, TaskSelectionState>(
      'selectAll selects all provided IDs',
      build: () => cubit,
      act: (cubit) => cubit.selectAll(['1', '2', '3']),
      expect: () => [
        const TaskSelectionState(selectedTaskIds: {'1', '2', '3'}, isSelectionMode: true),
      ],
    );

    blocTest<TaskSelectionCubit, TaskSelectionState>(
      'clearSelection resets to initial state',
      build: () => cubit,
      seed: () => const TaskSelectionState(selectedTaskIds: {'1', '2'}, isSelectionMode: true),
      act: (cubit) => cubit.clearSelection(),
      expect: () => [
        const TaskSelectionState(),
      ],
    );
  });
}
