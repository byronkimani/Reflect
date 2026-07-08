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
  });

  late MockReviewRepository mockRepository;
  late MockTaskRepository mockTaskRepository;
  late MockAppAnalyticsService mockAnalytics;
  late DailyReviewCubit cubit;

  setUp(() {
    mockRepository = MockReviewRepository();
    mockTaskRepository = MockTaskRepository();
    mockAnalytics = MockAppAnalyticsService();
    when(() => mockAnalytics.logDailyReviewSubmitted()).thenAnswer((_) async {});
    when(() => mockTaskRepository.getTasksForDate(any()))
        .thenAnswer((_) async => const Right([]));
    cubit = DailyReviewCubit(mockRepository, mockTaskRepository, mockAnalytics);
  });

  tearDown(() {
    cubit.close();
  });

  group('DailyReviewCubit', () {
    test('initial state is default', () {
      expect(cubit.state, const DailyReviewState());
    });

    blocTest<DailyReviewCubit, DailyReviewState>(
      'initializeForToday loads task completion stats',
      build: () {
        when(() => mockTaskRepository.getTasksForDate(any())).thenAnswer(
          (_) async => Right([
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
        return cubit;
      },
      act: (cubit) => cubit.initializeForToday(),
      expect: () => [
        const DailyReviewState(),
        const DailyReviewState(
          tasksCompletedToday: 1,
          tasksTotalToday: 2,
          taskCompletionRate: 0.5,
        ),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'emits updated state when ratingChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.ratingChanged(4),
      expect: () => [
        const DailyReviewState(dayRating: 4),
      ],
    );

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
