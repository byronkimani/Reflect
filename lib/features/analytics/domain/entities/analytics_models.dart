import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_models.freezed.dart';

enum DateRange { last7Days, last30Days, last90Days }

@freezed
abstract class DailyCompletionPoint with _$DailyCompletionPoint {
  const factory DailyCompletionPoint({
    required DateTime date,
    required double completionRate,
  }) = _DailyCompletionPoint;
}

@freezed
abstract class StreakData with _$StreakData {
  const factory StreakData({
    required int currentStreak,
    required int bestStreak,
  }) = _StreakData;
}

@freezed
abstract class GoalHitPoint with _$GoalHitPoint {
  const factory GoalHitPoint({
    required String periodLabel,
    required double hitRate,
  }) = _GoalHitPoint;
}

@freezed
abstract class BreakdownItem with _$BreakdownItem {
  const factory BreakdownItem({
    required String label,
    required int count,
    required String hexColor,
  }) = _BreakdownItem;
}

@freezed
abstract class DayRatingPoint with _$DayRatingPoint {
  const factory DayRatingPoint({required DateTime date, required int rating}) =
      _DayRatingPoint;
}
