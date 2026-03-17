// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyReview _$DailyReviewFromJson(Map<String, dynamic> json) => _DailyReview(
  id: json['id'] as String,
  reviewDate: DateTime.parse(json['reviewDate'] as String),
  dayRating: (json['dayRating'] as num).toInt(),
  wentWell: json['wentWell'] as String?,
  couldBeBetter: json['couldBeBetter'] as String?,
  gratitude1: json['gratitude1'] as String,
  gratitude2: json['gratitude2'] as String,
  gratitude3: json['gratitude3'] as String,
  taskCompletionRate: (json['taskCompletionRate'] as num?)?.toDouble() ?? 0.0,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DailyReviewToJson(_DailyReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reviewDate': instance.reviewDate.toIso8601String(),
      'dayRating': instance.dayRating,
      'wentWell': instance.wentWell,
      'couldBeBetter': instance.couldBeBetter,
      'gratitude1': instance.gratitude1,
      'gratitude2': instance.gratitude2,
      'gratitude3': instance.gratitude3,
      'taskCompletionRate': instance.taskCompletionRate,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_WeeklyPlan _$WeeklyPlanFromJson(Map<String, dynamic> json) => _WeeklyPlan(
  id: json['id'] as String,
  weekStartDate: DateTime.parse(json['weekStartDate'] as String),
  theme: json['theme'] as String?,
  intentions: json['intentions'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  goals:
      (json['goals'] as List<dynamic>?)
          ?.map((e) => WeeklyGoal.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  review: json['review'] == null
      ? null
      : WeeklyReview.fromJson(json['review'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeeklyPlanToJson(_WeeklyPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'theme': instance.theme,
      'intentions': instance.intentions,
      'createdAt': instance.createdAt.toIso8601String(),
      'goals': instance.goals,
      'review': instance.review,
    };

_WeeklyReview _$WeeklyReviewFromJson(Map<String, dynamic> json) =>
    _WeeklyReview(
      id: json['id'] as String,
      weekStartDate: DateTime.parse(json['weekStartDate'] as String),
      themeAchieved: json['themeAchieved'] as bool?,
      reflectionNotes: json['reflectionNotes'] as String?,
      weekRating: (json['weekRating'] as num).toInt(),
      goalHitRate: (json['goalHitRate'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WeeklyReviewToJson(_WeeklyReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'themeAchieved': instance.themeAchieved,
      'reflectionNotes': instance.reflectionNotes,
      'weekRating': instance.weekRating,
      'goalHitRate': instance.goalHitRate,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_WeeklyGoal _$WeeklyGoalFromJson(Map<String, dynamic> json) => _WeeklyGoal(
  id: json['id'] as String,
  weekStartDate: DateTime.parse(json['weekStartDate'] as String),
  title: json['title'] as String,
  isAchieved: json['isAchieved'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WeeklyGoalToJson(_WeeklyGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'title': instance.title,
      'isAchieved': instance.isAchieved,
      'sortOrder': instance.sortOrder,
    };

_MonthlyPlan _$MonthlyPlanFromJson(Map<String, dynamic> json) => _MonthlyPlan(
  id: json['id'] as String,
  monthYear: json['monthYear'] as String,
  intentions: json['intentions'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  goals:
      (json['goals'] as List<dynamic>?)
          ?.map((e) => MonthlyGoal.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  review: json['review'] == null
      ? null
      : MonthlyReview.fromJson(json['review'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MonthlyPlanToJson(_MonthlyPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'monthYear': instance.monthYear,
      'intentions': instance.intentions,
      'createdAt': instance.createdAt.toIso8601String(),
      'goals': instance.goals,
      'review': instance.review,
    };

_MonthlyReview _$MonthlyReviewFromJson(Map<String, dynamic> json) =>
    _MonthlyReview(
      id: json['id'] as String,
      monthYear: json['monthYear'] as String,
      overallRating: (json['overallRating'] as num).toInt(),
      win1: json['win1'] as String?,
      win2: json['win2'] as String?,
      win3: json['win3'] as String?,
      challenge1: json['challenge1'] as String?,
      challenge2: json['challenge2'] as String?,
      challenge3: json['challenge3'] as String?,
      gratitudeSummary: json['gratitudeSummary'] as String?,
      intentionsNextMonth: json['intentionsNextMonth'] as String?,
      goalCompletionRate:
          (json['goalCompletionRate'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MonthlyReviewToJson(_MonthlyReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'monthYear': instance.monthYear,
      'overallRating': instance.overallRating,
      'win1': instance.win1,
      'win2': instance.win2,
      'win3': instance.win3,
      'challenge1': instance.challenge1,
      'challenge2': instance.challenge2,
      'challenge3': instance.challenge3,
      'gratitudeSummary': instance.gratitudeSummary,
      'intentionsNextMonth': instance.intentionsNextMonth,
      'goalCompletionRate': instance.goalCompletionRate,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_MonthlyGoal _$MonthlyGoalFromJson(Map<String, dynamic> json) => _MonthlyGoal(
  id: json['id'] as String,
  monthYear: json['monthYear'] as String,
  title: json['title'] as String,
  isAchieved: json['isAchieved'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MonthlyGoalToJson(_MonthlyGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'monthYear': instance.monthYear,
      'title': instance.title,
      'isAchieved': instance.isAchieved,
      'sortOrder': instance.sortOrder,
    };
