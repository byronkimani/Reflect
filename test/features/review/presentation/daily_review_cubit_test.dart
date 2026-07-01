import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

class MockReviewRepository extends Mock implements IReviewRepository {}
class FakeDailyReviewState extends Fake implements DailyReviewState {}

class MockAppAnalyticsService extends Mock implements AppAnalyticsService {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDailyReviewState());
  });

  late MockReviewRepository mockRepository;
  late MockAppAnalyticsService mockAnalytics;
  late DailyReviewCubit cubit;

  setUp(() {
    mockRepository = MockReviewRepository();
    mockAnalytics = MockAppAnalyticsService();
    when(() => mockAnalytics.logDailyReviewSubmitted()).thenAnswer((_) async {});
    cubit = DailyReviewCubit(mockRepository, mockAnalytics);
  });

  tearDown(() {
    cubit.close();
  });

  group('DailyReviewCubit', () {
    test('initial state is default', () {
      expect(cubit.state, const DailyReviewState());
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
      'emits updated state when wentWellChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.wentWellChanged('Everything'),
      expect: () => [
        const DailyReviewState(wentWell: 'Everything'),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'emits updated state when couldBeBetterChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.couldBeBetterChanged('Nothing'),
      expect: () => [
        const DailyReviewState(couldBeBetter: 'Nothing'),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'emits updated state when gratitudeChanged is called',
      build: () => cubit,
      act: (cubit) {
        cubit.gratitudeChanged(0, 'Health');
        cubit.gratitudeChanged(1, 'Family');
        cubit.gratitudeChanged(2, 'Food');
      },
      expect: () => [
        const DailyReviewState(gratitude1: 'Health'),
        const DailyReviewState(gratitude1: 'Health', gratitude2: 'Family'),
        const DailyReviewState(gratitude1: 'Health', gratitude2: 'Family', gratitude3: 'Food'),
      ],
    );

    blocTest<DailyReviewCubit, DailyReviewState>(
      'emits updated state when completionRateChanged is called',
      build: () => cubit,
      act: (cubit) => cubit.completionRateChanged(0.8),
      expect: () => [
        const DailyReviewState(taskCompletionRate: 0.8),
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
        gratitude1: 'A',
        gratitude2: 'B',
        gratitude3: 'C',
      ),
      act: (cubit) => cubit.submitReview(),
      expect: () => [
        const DailyReviewState(
          dayRating: 5,
          gratitude1: 'A',
          gratitude2: 'B',
          gratitude3: 'C',
          isSubmitting: true,
        ),
        const DailyReviewState(
          dayRating: 5,
          gratitude1: 'A',
          gratitude2: 'B',
          gratitude3: 'C',
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
        gratitude1: 'A',
        gratitude2: 'B',
        gratitude3: 'C',
      ),
      act: (cubit) => cubit.submitReview(),
      expect: () => [
        const DailyReviewState(
          dayRating: 5,
          gratitude1: 'A',
          gratitude2: 'B',
          gratitude3: 'C',
          isSubmitting: true,
        ),
        const DailyReviewState(
          dayRating: 5,
          gratitude1: 'A',
          gratitude2: 'B',
          gratitude3: 'C',
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
