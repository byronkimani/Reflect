import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskRepository mockRepository;
  late TaskListBloc bloc;

  setUp(() {
    mockRepository = MockTaskRepository();
    bloc = TaskListBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('TaskListBloc Bulk Actions', () {
    final ids = ['1', '2', '3'];

    blocTest<TaskListBloc, TaskListState>(
      'emits nothing when bulkCompleteTasks succeeds',
      build: () {
        when(() => mockRepository.completeTasks(ids))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) => bloc.add(TaskListEvent.bulkCompleteTasks(ids)),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepository.completeTasks(ids)).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits error when bulkCompleteTasks fails',
      build: () {
        when(() => mockRepository.completeTasks(ids))
            .thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'Failed to complete')));
        return bloc;
      },
      act: (bloc) => bloc.add(TaskListEvent.bulkCompleteTasks(ids)),
      expect: () => [
        const TaskListState.error('Failed to complete'),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits nothing when bulkReopenTasks succeeds',
      build: () {
        when(() => mockRepository.reopenTasks(ids))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) => bloc.add(TaskListEvent.bulkReopenTasks(ids)),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepository.reopenTasks(ids)).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits nothing when bulkMoveToBacklog succeeds',
      build: () {
        when(() => mockRepository.moveTasksToBacklog(ids))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) => bloc.add(TaskListEvent.bulkMoveToBacklog(ids)),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepository.moveTasksToBacklog(ids)).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits nothing when bulkDeleteTasks succeeds',
      build: () {
        when(() => mockRepository.deleteTasks(ids))
            .thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (bloc) => bloc.add(TaskListEvent.bulkDeleteTasks(ids)),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepository.deleteTasks(ids)).called(1);
      },
    );
  });
}
