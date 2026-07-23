import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

class MockReviewRepository extends Mock implements IReviewRepository {}
class FakeDailyReviewState extends Fake implements DailyReviewState {}
class MockAppAnalyticsService extends Mock implements AppAnalyticsService {}
class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDailyReviewState());
    registerFallbackValue(
      Task(
        id: 't1',
        title: 'Task',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      ),
    );
    registerFallbackValue(DateTime(2026));
  });

  late MockReviewRepository mockRepository;
  late MockTaskRepository mockTaskRepository;
  late MockAppAnalyticsService mockAnalytics;
  late DailyReviewCubit cubit;
  late StreamController<Either<Failure, List<Task>>> todayTasksController;

  setUp(() {
    mockRepository = MockReviewRepository();
    mockTaskRepository = MockTaskRepository();
    mockAnalytics = MockAppAnalyticsService();
    todayTasksController =
        StreamController<Either<Failure, List<Task>>>.broadcast();
    when(() => mockAnalytics.logDailyReviewSubmitted()).thenAnswer((_) async {});
    when(() => mockTaskRepository.watchTasksForDate(any())).thenAnswer(
      (_) => todayTasksController.stream,
    );
    cubit = DailyReviewCubit(mockRepository, mockTaskRepository, mockAnalytics);
  });

  tearDown(() async {
    await cubit.close();
    await todayTasksController.close();
  });

  group('DailyReviewCubit', () {
    test('initial state is default', () {
      expect(cubit.state, const DailyReviewState());
    });

    test('canSubmit is false when rating set but reflection fields empty', () {
      const state = DailyReviewState(dayRating: 4);
      expect(state.canSubmit, isFalse);
    });

    blocTest<DailyReviewCubit, DailyReviewState>(
      'startWatchingTodayTasks ignores stream failures without clearing form',
      build: () => cubit,
      seed: () => const DailyReviewState(dayRating: 3, wentWell: 'Kept form'),
      act: (cubit) async {
        cubit.startWatchingTodayTasks();
        todayTasksController.add(
          const Left(CacheFailure(errorMessage: 'DB error')),
        );
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'startWatchingTodayTasks updates task completion stats from stream',
      build: () => cubit,
      act: (cubit) async {
        cubit.startWatchingTodayTasks();
        todayTasksController.add(
          Right([
            Task(
              id: '1',
              title: 'A',
              status: TaskStatus.completed,
              createdAt: DateTime(2026),
              updatedAt: DateTime(2026),
            ),
            Task(
              id: '2',
              title: 'B',
              createdAt: DateTime(2026),
              updatedAt: DateTime(2026),
            ),
          ]),
        );
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        const DailyReviewState(
          tasksCompletedToday: 1,
          tasksTotalToday: 2,
          taskCompletionRate: 0.5,
        ),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'startWatchingTodayTasks preserves in-progress form fields',
      build: () => cubit,
      seed: () => const DailyReviewState(
        dayRating: 4,
        wentWell: 'Win',
        tasksCompletedToday: 2,
        tasksTotalToday: 5,
        taskCompletionRate: 0.4,
      ),
      act: (cubit) async {
        cubit.startWatchingTodayTasks();
        todayTasksController.add(const Right([]));
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        const DailyReviewState(
          dayRating: 4,
          wentWell: 'Win',
          tasksCompletedToday: 0,
          tasksTotalToday: 0,
          taskCompletionRate: 0.0,
        ),
      ],
    );

    test('close cancels today task subscription without emit-after-close', () async {
      cubit.startWatchingTodayTasks();
      await cubit.close();
      todayTasksController.add(
        Right([
          Task(
            id: '1',
            title: 'A',
            status: TaskStatus.completed,
            createdAt: DateTime(2026),
            updatedAt: DateTime(2026),
          ),
        ]),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cubit.isClosed, isTrue);
    });

    blocTest<DailyReviewCubit, DailyReviewState>(
      'emits updated state when ratingChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.ratingChanged(4),
      expect: () => [
        const DailyReviewState(dayRating: 4),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'wentWellChanged and couldBeBetterChanged update fields',
      build: () => cubit,
      act: (cubit) {
        cubit.wentWellChanged('Great meeting');
        cubit.couldBeBetterChanged('Sleep earlier');
      },
      expect: () => [
        const DailyReviewState(wentWell: 'Great meeting'),
        const DailyReviewState(
          wentWell: 'Great meeting',
          couldBeBetter: 'Sleep earlier',
        ),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'gratitudeChanged updates the correct gratitude slot',
      build: () => cubit,
      act: (cubit) {
        cubit.gratitudeChanged(0, 'One');
        cubit.gratitudeChanged(1, 'Two');
        cubit.gratitudeChanged(2, 'Three');
      },
      expect: () => [
        const DailyReviewState(gratitude1: 'One'),
        const DailyReviewState(gratitude1: 'One', gratitude2: 'Two'),
        const DailyReviewState(
          gratitude1: 'One',
          gratitude2: 'Two',
          gratitude3: 'Three',
        ),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'completionRateChanged updates taskCompletionRate',
      build: () => cubit,
      act: (cubit) => cubit.completionRateChanged(0.75),
      expect: () => [
        const DailyReviewState(taskCompletionRate: 0.75),
      ],
    );

    test('addGratitudeField does not exceed 3', () {
      cubit.addGratitudeField();
      cubit.addGratitudeField();
      cubit.addGratitudeField();
      cubit.addGratitudeField();
      expect(cubit.state.gratitudeFieldCount, 3);
    });

    blocTest<DailyReviewCubit, DailyReviewState>(
      'addGratitudeField increases visible field count up to 3',
      build: () => cubit,
      act: (cubit) {
        cubit.addGratitudeField();
        cubit.addGratitudeField();
        cubit.addGratitudeField();
      },
      expect: () => [
        const DailyReviewState(gratitudeFieldCount: 2),
        const DailyReviewState(gratitudeFieldCount: 3),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'removeGratitudeField shifts trailing gratitude text down',
      build: () => cubit,
      seed: () => const DailyReviewState(
        gratitudeFieldCount: 3,
        gratitude1: 'A',
        gratitude2: 'B',
        gratitude3: 'C',
      ),
      act: (cubit) => cubit.removeGratitudeField(1),
      expect: () => [
        const DailyReviewState(
          gratitudeFieldCount: 2,
          gratitude1: 'A',
          gratitude2: 'C',
          gratitude3: '',
        ),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'removeGratitudeField ignores invalid indices',
      build: () => cubit,
      seed: () => const DailyReviewState(
        gratitudeFieldCount: 2,
        gratitude1: 'A',
        gratitude2: 'B',
      ),
      act: (cubit) => cubit.removeGratitudeField(0),
      expect: () => [],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'submitReview does not emit anything if canSubmit is false',
      build: () => cubit,
      act: (cubit) => cubit.submitReview(),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockRepository.saveDailyReview(any()));
        verifyNever(() => mockAnalytics.logDailyReviewSubmitted());
      },
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'submitReview emits [isSubmitting, isSuccess] on successful save',
      build: () {
        when(() => mockRepository.saveDailyReview(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      seed: () => const DailyReviewState(
        dayRating: 5,
        wentWell: 'Good day',
        gratitude1: 'A',
      ),
      act: (cubit) => cubit.submitReview(),
      expect: () => [
        const DailyReviewState(
          dayRating: 5,
          wentWell: 'Good day',
          gratitude1: 'A',
          isSubmitting: true,
        ),
        const DailyReviewState(
          dayRating: 5,
          wentWell: 'Good day',
          gratitude1: 'A',
          isSubmitting: false,
          isSuccess: true,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.saveDailyReview(any())).called(1);
        verify(() => mockAnalytics.logDailyReviewSubmitted()).called(1);
      },
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'submitReview trims gratitude and reflection text before save',
      build: () {
        when(() => mockRepository.saveDailyReview(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      seed: () => const DailyReviewState(
        dayRating: 5,
        wentWell: '  Good day  ',
        gratitude1: '  A  ',
        gratitude2: '  B  ',
        gratitudeFieldCount: 2,
      ),
      act: (cubit) => cubit.submitReview(),
      verify: (_) {
        final captured = verify(
          () => mockRepository.saveDailyReview(captureAny()),
        ).captured;
        final saved = captured.single as DailyReviewState;
        expect(saved.wentWell, 'Good day');
        expect(saved.gratitude1, 'A');
        expect(saved.gratitude2, 'B');
      },
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'submitReview emits [isSubmitting, error] on failed save',
      build: () {
        when(() => mockRepository.saveDailyReview(any()))
            .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'Failed to save')));
        return cubit;
      },
      seed: () => const DailyReviewState(
        dayRating: 5,
        wentWell: 'Good day',
        gratitude1: 'A',
      ),
      act: (cubit) => cubit.submitReview(),
      expect: () => [
        const DailyReviewState(
          dayRating: 5,
          wentWell: 'Good day',
          gratitude1: 'A',
          isSubmitting: true,
        ),
        const DailyReviewState(
          dayRating: 5,
          wentWell: 'Good day',
          gratitude1: 'A',
          isSubmitting: false,
          error: 'Failed to save',
        ),
      ],
      verify: (_) {
        verifyNever(() => mockAnalytics.logDailyReviewSubmitted());
      },
    );
  });
}
