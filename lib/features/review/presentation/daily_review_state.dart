import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_review_state.freezed.dart';

@freezed
abstract class DailyReviewState with _$DailyReviewState {
  const DailyReviewState._();

  const factory DailyReviewState({
    @Default(0) int dayRating,
    @Default('') String wentWell,
    @Default('') String couldBeBetter,
    @Default('') String gratitude1,
    @Default('') String gratitude2,
    @Default('') String gratitude3,
    @Default(1) int gratitudeFieldCount,
    @Default(0.0) double taskCompletionRate,
    @Default(0) int tasksCompletedToday,
    @Default(0) int tasksTotalToday,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? error,
  }) = _DailyReviewState;

  bool get canSubmit {
    if (dayRating <= 0) return false;
    if (wentWell.isEmpty && couldBeBetter.isEmpty) return false;
    if (gratitudeFieldCount >= 1 && gratitude1.isEmpty) return false;
    if (gratitudeFieldCount >= 2 && gratitude2.isEmpty) return false;
    if (gratitudeFieldCount >= 3 && gratitude3.isEmpty) return false;
    return true;
  }

  bool get showTaskChip => tasksTotalToday > 0;
}
