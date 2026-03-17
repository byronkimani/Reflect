import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entities.freezed.dart';
part 'review_entities.g.dart';

@freezed
abstract class DailyReview with _$DailyReview {
  const factory DailyReview({
    required String id,
    required DateTime reviewDate,
    required int dayRating,
    String? wentWell,
    String? couldBeBetter,
    required String gratitude1,
    required String gratitude2,
    required String gratitude3,
    @Default(0.0) double taskCompletionRate,
    required DateTime createdAt,
  }) = _DailyReview;

  factory DailyReview.fromJson(Map<String, dynamic> json) =>
      _$DailyReviewFromJson(json);
}

@freezed
abstract class WeeklyPlan with _$WeeklyPlan {
  const factory WeeklyPlan({
    required String id,
    required DateTime weekStartDate,
    String? theme,
    String? intentions,
    required DateTime createdAt,
    @Default([]) List<WeeklyGoal> goals,
    WeeklyReview? review,
  }) = _WeeklyPlan;

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) =>
      _$WeeklyPlanFromJson(json);
}

@freezed
abstract class WeeklyReview with _$WeeklyReview {
  const factory WeeklyReview({
    required String id,
    required DateTime weekStartDate,
    bool? themeAchieved,
    String? reflectionNotes,
    required int weekRating,
    @Default(0.0) double goalHitRate,
    required DateTime createdAt,
  }) = _WeeklyReview;

  factory WeeklyReview.fromJson(Map<String, dynamic> json) =>
      _$WeeklyReviewFromJson(json);
}

@freezed
abstract class WeeklyGoal with _$WeeklyGoal {
  const factory WeeklyGoal({
    required String id,
    required DateTime weekStartDate,
    required String title,
    @Default(false) bool isAchieved,
    @Default(0) int sortOrder,
  }) = _WeeklyGoal;

  factory WeeklyGoal.fromJson(Map<String, dynamic> json) =>
      _$WeeklyGoalFromJson(json);
}

@freezed
abstract class MonthlyPlan with _$MonthlyPlan {
  const factory MonthlyPlan({
    required String id,
    required String monthYear,
    String? intentions,
    required DateTime createdAt,
    @Default([]) List<MonthlyGoal> goals,
    MonthlyReview? review,
  }) = _MonthlyPlan;

  factory MonthlyPlan.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPlanFromJson(json);
}

@freezed
abstract class MonthlyReview with _$MonthlyReview {
  const factory MonthlyReview({
    required String id,
    required String monthYear,
    required int overallRating,
    String? win1,
    String? win2,
    String? win3,
    String? challenge1,
    String? challenge2,
    String? challenge3,
    String? gratitudeSummary,
    String? intentionsNextMonth,
    @Default(0.0) double goalCompletionRate,
    required DateTime createdAt,
  }) = _MonthlyReview;

  factory MonthlyReview.fromJson(Map<String, dynamic> json) =>
      _$MonthlyReviewFromJson(json);
}

@freezed
abstract class MonthlyGoal with _$MonthlyGoal {
  const factory MonthlyGoal({
    required String id,
    required String monthYear,
    required String title,
    @Default(false) bool isAchieved,
    @Default(0) int sortOrder,
  }) = _MonthlyGoal;

  factory MonthlyGoal.fromJson(Map<String, dynamic> json) =>
      _$MonthlyGoalFromJson(json);
}
