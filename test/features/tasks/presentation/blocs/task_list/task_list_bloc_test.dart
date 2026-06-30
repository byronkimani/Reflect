import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockITaskRepository mockRepo;
  late TaskListBloc bloc;

  setUp(() {
    mockRepo = MockITaskRepository();
    bloc = TaskListBloc(mockRepo);
  });

  tearDown(() {
    bloc.close();
  });

  final testDate = DateTime(2023, 10, 10);
  final taskPending = Task(
    id: 't1',
    title: 'Pending',
    status: TaskStatus.pending,
    createdAt: testDate,
    updatedAt: testDate,
  );
  final taskCompleted = Task(
    id: 't2',
    title: 'Completed',
    status: TaskStatus.completed,
    createdAt: testDate,
    updatedAt: testDate,
  );
  final taskOverdue = Task(
    id: 't3',
    title: 'Overdue',
    status: TaskStatus.pending,
    dueDate: testDate.subtract(const Duration(days: 1)),
    isOverdue: true,
    createdAt: testDate,
    updatedAt: testDate,
  );

  group('TaskListBloc', () {
    test('initial state is initial', () {
      expect(bloc.state, const TaskListState.initial());
    });

    blocTest<TaskListBloc, TaskListState>(
      'emits [loading, loaded] when LoadTasksForDate is successful',
      build: () {
        when(() => mockRepo.watchTasksForDate(testDate))
            .thenAnswer((_) => Stream.value(Right([taskPending, taskCompleted, taskOverdue])));
        return bloc;
      },
      act: (b) => b.add(TaskListEvent.loadTasksForDate(testDate)),
      expect: () => [
        const TaskListState.loading(),
        TaskListState.loaded(
          pending: [taskPending],
          completed: [taskCompleted],
          overdue: [taskOverdue],
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits [loading, error] when LoadTasksForDate fails',
      build: () {
        when(() => mockRepo.watchTasksForDate(testDate))
            .thenAnswer((_) => Stream.value(const Left(ServerFailure(errorMessage: 'Error'))));
        return bloc;
      },
      act: (b) => b.add(TaskListEvent.loadTasksForDate(testDate)),
      expect: () => [
        const TaskListState.loading(),
        const TaskListState.error('Error'),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'emits [loading, loaded] when LoadBacklog is successful',
      build: () {
        when(() => mockRepo.watchBacklogTasks())
            .thenAnswer((_) => Stream.value(Right([taskPending])));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.loadBacklog()),
      expect: () => [
        const TaskListState.loading(),
        TaskListState.loaded(
          pending: [taskPending],
          completed: const [],
          overdue: const [],
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'SortChanged updates sort mode',
      build: () => bloc,
      seed: () => TaskListState.loaded(
        pending: [taskPending],
        completed: const [],
        overdue: const [],
        sortMode: SortMode.statusPendingFirst,
      ),
      act: (b) => b.add(const TaskListEvent.sortChanged(SortMode.priority)),
      expect: () => [
        TaskListState.loaded(
          pending: [taskPending],
          completed: const [],
          overdue: const [],
          sortMode: SortMode.priority,
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'FilterChanged updates filter',
      build: () => bloc,
      seed: () => TaskListState.loaded(
        pending: [taskPending],
        completed: const [],
        overdue: const [],
      ),
      act: (b) => b.add(const TaskListEvent.filterChanged(TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly))),
      expect: () => [
        TaskListState.loaded(
          pending: [taskPending],
          completed: const [],
          overdue: const [],
          filter: const TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly),
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'CompleteTask calls completeTask on repo',
      build: () {
        when(() => mockRepo.completeTask('t1')).thenAnswer((_) async => Right(taskCompleted));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.completeTask('t1')),
      verify: (_) {
        verify(() => mockRepo.completeTask('t1')).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'ReopenTask calls reopenTask on repo',
      build: () {
        when(() => mockRepo.reopenTask('t2')).thenAnswer((_) async => Right(taskPending));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.reopenTask('t2')),
      verify: (_) {
        verify(() => mockRepo.reopenTask('t2')).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'DeleteTask calls deleteTask on repo',
      build: () {
        when(() => mockRepo.deleteTask('t1')).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.deleteTask('t1')),
      verify: (_) {
        verify(() => mockRepo.deleteTask('t1')).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkCompleteTasks calls completeTasks on repo',
      build: () {
        when(() => mockRepo.completeTasks(['t1'])).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkCompleteTasks(['t1'])),
      verify: (_) {
        verify(() => mockRepo.completeTasks(['t1'])).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkReopenTasks calls reopenTasks on repo',
      build: () {
        when(() => mockRepo.reopenTasks(['t1'])).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkReopenTasks(['t1'])),
      verify: (_) {
        verify(() => mockRepo.reopenTasks(['t1'])).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkMoveToBacklog calls moveTasksToBacklog on repo',
      build: () {
        when(() => mockRepo.moveTasksToBacklog(['t1'])).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkMoveToBacklog(['t1'])),
      verify: (_) {
        verify(() => mockRepo.moveTasksToBacklog(['t1'])).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkDeleteTasks calls deleteTasks on repo',
      build: () {
        when(() => mockRepo.deleteTasks(['t1'])).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkDeleteTasks(['t1'])),
      verify: (_) {
        verify(() => mockRepo.deleteTasks(['t1'])).called(1);
      },
    );
  });
}
