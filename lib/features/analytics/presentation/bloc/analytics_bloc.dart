import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/analytics/data/daos/analytics_dao.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';

part 'analytics_bloc.freezed.dart';

@freezed
abstract class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent.load(DateRange range) = LoadAnalytics;
}

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = _Initial;
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.loaded({
    required DateRange activeRange,
    required List<DailyCompletionPoint> dailyCompletion,
    required StreakData streaks,
    required List<BreakdownItem> tagBreakdown,
    required List<BreakdownItem> priorityBreakdown,
    required List<DayRatingPoint> ratingTrend,
  }) = _Loaded;
  const factory AnalyticsState.error(String message) = _Error;
}

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsDao _analyticsDao;

  AnalyticsBloc(this._analyticsDao) : super(const AnalyticsState.initial()) {
    on<LoadAnalytics>(_onLoadAnalytics);
  }

  Future<void> _onLoadAnalytics(
    LoadAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(const AnalyticsState.loading());

    try {
      final now = DateTime.now();
      final DateTime startDate;
      final DateTime endDate = now;

      switch (event.range) {
        case DateRange.last7Days:
          startDate = now.subtract(const Duration(days: 7));
          break;
        case DateRange.last30Days:
          startDate = now.subtract(const Duration(days: 30));
          break;
        case DateRange.last90Days:
          startDate = now.subtract(const Duration(days: 90));
          break;
      }

      // Execute all data fetching concurrently
      final results = await Future.wait([
        _analyticsDao.getDailyCompletionRates(startDate, endDate),
        _analyticsDao.calculateStreaks(),
        _analyticsDao.getTagBreakdown(startDate, endDate),
        _analyticsDao.getPriorityBreakdown(startDate, endDate),
        _analyticsDao.getDayRatingTrend(startDate, endDate),
      ]);

      emit(
        AnalyticsState.loaded(
          activeRange: event.range,
          dailyCompletion: results[0] as List<DailyCompletionPoint>,
          streaks: results[1] as StreakData,
          tagBreakdown: results[2] as List<BreakdownItem>,
          priorityBreakdown: results[3] as List<BreakdownItem>,
          ratingTrend: results[4] as List<DayRatingPoint>,
        ),
      );
    } catch (e) {
      emit(AnalyticsState.error('Failed to load analytics: ${e.toString()}'));
    }
  }
}
