import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/analytics/data/daos/analytics_dao.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';
import 'package:reflect/features/analytics/presentation/bloc/analytics_bloc.dart';

class MockAnalyticsDao extends Mock implements AnalyticsDao {}

void main() {
  late AnalyticsBloc bloc;
  late MockAnalyticsDao mockDao;

  setUp(() {
    mockDao = MockAnalyticsDao();
    bloc = AnalyticsBloc(mockDao);
  });

  tearDown(() {
    bloc.close();
  });

  group('AnalyticsBloc', () {
    final tDailyCompletion = [
      DailyCompletionPoint(date: DateTime.now(), completionRate: 0.8),
    ];
    final tStreaks = const StreakData(currentStreak: 5, bestStreak: 10);
    final tBreakdown = [
      const BreakdownItem(label: 'Work', count: 10, hexColor: '#FF0000'),
    ];
    const tRatingTrend = <DayRatingPoint>[];

    void setupMockSuccess() {
      when(() => mockDao.getDailyCompletionRates(any(), any()))
          .thenAnswer((_) async => tDailyCompletion);
      when(() => mockDao.calculateStreaks())
          .thenAnswer((_) async => tStreaks);
      when(() => mockDao.getTagBreakdown(any(), any()))
          .thenAnswer((_) async => tBreakdown);
      when(() => mockDao.getPriorityBreakdown(any(), any()))
          .thenAnswer((_) async => tBreakdown);
      when(() => mockDao.getDayRatingTrend(any(), any()))
          .thenAnswer((_) async => tRatingTrend);
    }

    blocTest<AnalyticsBloc, AnalyticsState>(
      'emits [loading, loaded] when LoadAnalytics is successful',
      build: () {
        setupMockSuccess();
        return bloc;
      },
      act: (bloc) => bloc.add(const AnalyticsEvent.load(DateRange.last7Days)),
      expect: () => [
        const AnalyticsState.loading(),
        AnalyticsState.loaded(
          activeRange: DateRange.last7Days,
          dailyCompletion: tDailyCompletion,
          streaks: tStreaks,
          tagBreakdown: tBreakdown,
          priorityBreakdown: tBreakdown,
          ratingTrend: tRatingTrend,
        ),
      ],
      verify: (_) {
        verify(() => mockDao.getDailyCompletionRates(any(), any())).called(1);
        verify(() => mockDao.calculateStreaks()).called(1);
      },
    );

    blocTest<AnalyticsBloc, AnalyticsState>(
      'emits [loading, error] when data fetching fails',
      build: () {
        when(() => mockDao.getDailyCompletionRates(any(), any()))
            .thenThrow(Exception('DB Error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const AnalyticsEvent.load(DateRange.last7Days)),
      expect: () => [
        const AnalyticsState.loading(),
        const AnalyticsState.error('Failed to load analytics: Exception: DB Error'),
      ],
    );
  });
}
