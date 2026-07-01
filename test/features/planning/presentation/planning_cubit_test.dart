import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

class MockTaskRepository extends Mock implements ITaskRepository {}
class FakeTask extends Fake implements Task {}

class MockAppAnalyticsService extends Mock implements AppAnalyticsService {}

void main() {
  late MockTaskRepository mockRepo;
  const analytics = NoOpAppAnalyticsService();
  
  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    mockRepo = MockTaskRepository();
  });

  group('PlanningCubit', () {
    final now = DateTime.now();
    final testTask1 = Task(
      id: 't1',
      title: 'Task 1',
      status: TaskStatus.pending,
      createdAt: now,
      updatedAt: now,
    );
    final testTask2 = Task(
      id: 't2',
      title: 'Task 2',
      status: TaskStatus.completed,
      createdAt: now,
      updatedAt: now,
    );

    test('loadPlanningData success populates incomplete and backlog tasks', () async {
      when(() => mockRepo.getTasksForDate(any())).thenAnswer((_) async => Right([testTask1, testTask2]));
      when(() => mockRepo.getBacklogTasks()).thenAnswer((_) async => Right([testTask1]));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.loadPlanningData();

      expect(cubit.state.isLoading, false);
      expect(cubit.state.yesterdayIncomplete.length, 1);
      expect(cubit.state.yesterdayIncomplete.first.id, 't1');
      expect(cubit.state.backlogTasks.length, 1);
      expect(cubit.state.backlogTasks.first.id, 't1');
      expect(cubit.state.error, isNull);
    });

    test('loadPlanningData updates error on getTasksForDate failure', () async {
      when(() => mockRepo.getTasksForDate(any())).thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Error 1')));
      when(() => mockRepo.getBacklogTasks()).thenAnswer((_) async => Right([testTask1]));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.loadPlanningData();

      expect(cubit.state.isLoading, false);
      expect(cubit.state.error, 'Error 1');
    });

    test('loadPlanningData updates error on getBacklogTasks failure', () async {
      when(() => mockRepo.getTasksForDate(any())).thenAnswer((_) async => Right([testTask1]));
      when(() => mockRepo.getBacklogTasks()).thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Error 2')));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.loadPlanningData();

      expect(cubit.state.isLoading, false);
      expect(cubit.state.error, 'Error 2');
    });

    test('doToday adds task id to pulledTodayIds', () async {
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(testTask1));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.doToday(testTask1);

      expect(cubit.state.pulledTodayIds.contains('t1'), isTrue);
    });

    test('doToday sets error on update failure', () async {
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Update Error')));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.doToday(testTask1);

      expect(cubit.state.error, 'Update Error');
    });

    test('pushFurther removes task from yesterdayIncomplete', () async {
      when(() => mockRepo.getTasksForDate(any())).thenAnswer((_) async => Right([testTask1]));
      when(() => mockRepo.getBacklogTasks()).thenAnswer((_) async => Right([]));
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(testTask1));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.loadPlanningData();
      expect(cubit.state.yesterdayIncomplete.length, 1);

      await cubit.pushFurther(testTask1, now.add(const Duration(days: 1)));

      expect(cubit.state.yesterdayIncomplete.isEmpty, isTrue);
    });

    test('moveToBacklog removes from yesterdayIncomplete and adds to backlogTasks', () async {
      when(() => mockRepo.getTasksForDate(any())).thenAnswer((_) async => Right([testTask1]));
      when(() => mockRepo.getBacklogTasks()).thenAnswer((_) async => Right([]));
      when(() => mockRepo.updateTask(any())).thenAnswer((_) async => Right(testTask1));

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.loadPlanningData();
      expect(cubit.state.yesterdayIncomplete.length, 1);
      expect(cubit.state.backlogTasks.isEmpty, isTrue);

      await cubit.moveToBacklog(testTask1);

      expect(cubit.state.yesterdayIncomplete.isEmpty, isTrue);
      expect(cubit.state.backlogTasks.length, 1);
      expect(cubit.state.backlogTasks.first.id, 't1');
    });

    test('pushFurther sets error on update failure', () async {
      when(() => mockRepo.updateTask(any())).thenAnswer(
        (_) async => Left(CacheFailure(errorMessage: 'Push failed')),
      );

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.pushFurther(testTask1, now.add(const Duration(days: 2)));

      expect(cubit.state.error, 'Push failed');
    });

    test('moveToBacklog sets error on update failure', () async {
      when(() => mockRepo.updateTask(any())).thenAnswer(
        (_) async => Left(CacheFailure(errorMessage: 'Backlog failed')),
      );

      final cubit = PlanningCubit(mockRepo, analytics);
      await cubit.moveToBacklog(testTask1);

      expect(cubit.state.error, 'Backlog failed');
    });

    test('confirmPlanning logs analytics and resets state', () async {
      final mockAnalytics = MockAppAnalyticsService();
      when(() => mockAnalytics.logPlanningCompleted()).thenAnswer((_) async {});

      final cubit = PlanningCubit(mockRepo, mockAnalytics);
      await cubit.confirmPlanning();

      verify(() => mockAnalytics.logPlanningCompleted()).called(1);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.pulledTodayIds.isEmpty, isTrue);
    });
  });
}
