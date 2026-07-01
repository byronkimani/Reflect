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
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const TaskListState.loading(),
        TaskListState.loaded(rawTasks: [taskPending, taskCompleted, taskOverdue], 
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
      'emits [loading, error] when LoadBacklog fails',
      build: () {
        when(() => mockRepo.watchBacklogTasks()).thenAnswer(
          (_) => Stream.value(
            const Left(ServerFailure(errorMessage: 'Backlog error')),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.loadBacklog()),
      expect: () => [
        const TaskListState.loading(),
        const TaskListState.error('Backlog error'),
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
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const TaskListState.loading(),
        TaskListState.loaded(rawTasks: [taskPending], 
          pending: [taskPending],
          completed: const [],
          overdue: const [],
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'LoadTasksForDate skips loading when already loaded',
      build: () {
        when(() => mockRepo.watchTasksForDate(testDate)).thenAnswer(
          (_) => Stream.value(Right([taskPending])),
        );
        return bloc;
      },
      seed: () => TaskListState.loaded(
        rawTasks: [taskPending],
        pending: [taskPending],
        completed: const [],
        overdue: const [],
      ),
      act: (b) => b.add(TaskListEvent.loadTasksForDate(testDate)),
      wait: const Duration(milliseconds: 100),
      expect: () => [],
      verify: (b) {
        verify(() => mockRepo.watchTasksForDate(testDate)).called(1);
      },
    );

    blocTest<TaskListBloc, TaskListState>(
      'SortChanged updates sort mode',
      build: () => bloc,
      seed: () => TaskListState.loaded(rawTasks: [taskPending], 
        pending: [taskPending],
        completed: const [],
        overdue: const [],
        sortMode: SortMode.statusPendingFirst,
      ),
      act: (b) => b.add(const TaskListEvent.sortChanged(SortMode.priority)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TaskListState.loaded(rawTasks: [taskPending], 
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
      seed: () => TaskListState.loaded(rawTasks: [taskPending], 
        pending: [taskPending],
        completed: const [],
        overdue: const [],
      ),
      act: (b) => b.add(const TaskListEvent.filterChanged(TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly))),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TaskListState.loaded(rawTasks: [taskPending], 
          pending: [taskPending],
          completed: const [],
          overdue: const [],
          filter: const TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly),
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'CompleteTask emits error when repository fails',
      build: () {
        when(() => mockRepo.completeTask('t1')).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Complete failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.completeTask('t1')),
      expect: () => [const TaskListState.error('Complete failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'ReopenTask emits error when repository fails',
      build: () {
        when(() => mockRepo.reopenTask('t2')).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Reopen failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.reopenTask('t2')),
      expect: () => [const TaskListState.error('Reopen failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'DeleteTask emits error when repository fails',
      build: () {
        when(() => mockRepo.deleteTask('t1')).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Delete failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.deleteTask('t1')),
      expect: () => [const TaskListState.error('Delete failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'PushToTomorrow is a no-op until repository support exists',
      build: () => bloc,
      seed: () => const TaskListState.loaded(
        rawTasks: [],
        pending: [],
        completed: [],
        overdue: [],
      ),
      act: (b) => b.add(const TaskListEvent.pushToTomorrow('t1')),
      expect: () => [],
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkCompleteTasks emits error when repository fails',
      build: () {
        when(() => mockRepo.completeTasks(['t1'])).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Bulk complete failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkCompleteTasks(['t1'])),
      expect: () => [const TaskListState.error('Bulk complete failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkReopenTasks emits error when repository fails',
      build: () {
        when(() => mockRepo.reopenTasks(['t1'])).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Bulk reopen failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkReopenTasks(['t1'])),
      expect: () => [const TaskListState.error('Bulk reopen failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkMoveToBacklog emits error when repository fails',
      build: () {
        when(() => mockRepo.moveTasksToBacklog(['t1'])).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Bulk move failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkMoveToBacklog(['t1'])),
      expect: () => [const TaskListState.error('Bulk move failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'BulkDeleteTasks emits error when repository fails',
      build: () {
        when(() => mockRepo.deleteTasks(['t1'])).thenAnswer(
          (_) async => const Left(CacheFailure(errorMessage: 'Bulk delete failed')),
        );
        return bloc;
      },
      act: (b) => b.add(const TaskListEvent.bulkDeleteTasks(['t1'])),
      expect: () => [const TaskListState.error('Bulk delete failed')],
    );

    blocTest<TaskListBloc, TaskListState>(
      'SortChanged is no-op when state is not loaded',
      build: () => bloc,
      act: (b) => b.add(const TaskListEvent.sortChanged(SortMode.priority)),
      expect: () => [],
    );

    blocTest<TaskListBloc, TaskListState>(
      'FilterChanged is no-op when state is not loaded',
      build: () => bloc,
      act: (b) => b.add(
        const TaskListEvent.filterChanged(
          TaskListFilter(statusFilter: TaskStatusFilter.pendingOnly),
        ),
      ),
      expect: () => [],
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

    blocTest<TaskListBloc, TaskListState>(
      'loadTasksForDate emits loading when recovering from error state',
      build: () {
        when(() => mockRepo.watchTasksForDate(any())).thenAnswer(
          (_) => Stream.value(Right(<Task>[])),
        );
        return bloc;
      },
      seed: () => const TaskListState.error('Previous failure'),
      act: (b) => b.add(TaskListEvent.loadTasksForDate(DateTime(2025, 6, 30))),
      expect: () => [
        const TaskListState.loading(),
        isA<TaskListState>().having(
          (s) => s.maybeWhen(
            loaded: (_, p, c, o, s, f) => true,
            orElse: () => false,
          ),
          'is loaded',
          isTrue,
        ),
      ],
    );

    blocTest<TaskListBloc, TaskListState>(
      'processes large lists on isolate when processOnMainIsolate is false',
      build: () {
        final manyTasks = List.generate(
          50,
          (i) => Task(
            id: 'task-$i',
            title: 'Task $i',
            createdAt: DateTime(2025, 6, 30),
            updatedAt: DateTime(2025, 6, 30),
            dueDate: DateTime(2025, 6, 30),
          ),
        );
        when(() => mockRepo.watchTasksForDate(any())).thenAnswer(
          (_) => Stream.value(Right(manyTasks)),
        );
        return TaskListBloc(mockRepo, processOnMainIsolate: false);
      },
      act: (b) => b.add(TaskListEvent.loadTasksForDate(DateTime(2025, 6, 30))),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verify(() => mockRepo.watchTasksForDate(any())).called(1);
      },
    );
  });
}
