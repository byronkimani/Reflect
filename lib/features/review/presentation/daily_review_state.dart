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
    @Default(0.0) double taskCompletionRate,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSuccess,
    String? error,
  }) = _DailyReviewState;

  bool get canSubmit =>
      dayRating > 0 &&
      gratitude1.isNotEmpty &&
      gratitude2.isNotEmpty &&
      gratitude3.isNotEmpty;
}
