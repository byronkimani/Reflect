import 'package:drift/drift.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/reviews/domain/entities/review_entities.dart';

extension DailyReviewDataX on DailyReviewData {
  DailyReview toDomain() {
    return DailyReview(
      id: id,
      reviewDate: DateTime.fromMillisecondsSinceEpoch(reviewDate),
      dayRating: dayRating,
      wentWell: wentWell,
      couldBeBetter: couldBeBetter,
      gratitude1: gratitude1,
      gratitude2: gratitude2,
      gratitude3: gratitude3,
      taskCompletionRate: taskCompletionRate,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}

extension DailyReviewX on DailyReview {
  DailyReviewsCompanion toCompanion() {
    return DailyReviewsCompanion(
      id: Value(id),
      reviewDate: Value(reviewDate.millisecondsSinceEpoch),
      dayRating: Value(dayRating),
      wentWell: Value(wentWell),
      couldBeBetter: Value(couldBeBetter),
      gratitude1: Value(gratitude1),
      gratitude2: Value(gratitude2),
      gratitude3: Value(gratitude3),
      taskCompletionRate: Value(taskCompletionRate),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension WeeklyPlanDataX on WeeklyPlanData {
  WeeklyPlan toDomain({List<WeeklyGoal> goals = const [], WeeklyReview? review}) {
    return WeeklyPlan(
      id: id,
      weekStartDate: DateTime.fromMillisecondsSinceEpoch(weekStartDate),
      theme: theme,
      intentions: intentions,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      goals: goals,
      review: review,
    );
  }
}

extension WeeklyPlanX on WeeklyPlan {
  WeeklyPlansCompanion toCompanion() {
    return WeeklyPlansCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate.millisecondsSinceEpoch),
      theme: Value(theme),
      intentions: Value(intentions),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension WeeklyReviewDataX on WeeklyReviewData {
  WeeklyReview toDomain() {
    return WeeklyReview(
      id: id,
      weekStartDate: DateTime.fromMillisecondsSinceEpoch(weekStartDate),
      themeAchieved: themeAchieved == null ? null : themeAchieved == 1,
      reflectionNotes: reflectionNotes,
      weekRating: weekRating,
      goalHitRate: goalHitRate,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}

extension WeeklyReviewX on WeeklyReview {
  WeeklyReviewsCompanion toCompanion() {
    return WeeklyReviewsCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate.millisecondsSinceEpoch),
      themeAchieved: Value(themeAchieved == null ? null : (themeAchieved! ? 1 : 0)),
      reflectionNotes: Value(reflectionNotes),
      weekRating: Value(weekRating),
      goalHitRate: Value(goalHitRate),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension WeeklyGoalDataX on WeeklyGoalData {
  WeeklyGoal toDomain() {
    return WeeklyGoal(
      id: id,
      weekStartDate: DateTime.fromMillisecondsSinceEpoch(weekStartDate),
      title: title,
      isAchieved: isAchieved == 1,
      sortOrder: sortOrder,
    );
  }
}

extension WeeklyGoalX on WeeklyGoal {
  WeeklyGoalsCompanion toCompanion() {
    return WeeklyGoalsCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate.millisecondsSinceEpoch),
      title: Value(title),
      isAchieved: Value(isAchieved ? 1 : 0),
      sortOrder: Value(sortOrder),
    );
  }
}

extension MonthlyPlanDataX on MonthlyPlanData {
  MonthlyPlan toDomain({List<MonthlyGoal> goals = const [], MonthlyReview? review}) {
    return MonthlyPlan(
      id: id,
      monthYear: monthYear,
      intentions: intentions,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      goals: goals,
      review: review,
    );
  }
}

extension MonthlyPlanX on MonthlyPlan {
  MonthlyPlansCompanion toCompanion() {
    return MonthlyPlansCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      intentions: Value(intentions),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension MonthlyReviewDataX on MonthlyReviewData {
  MonthlyReview toDomain() {
    return MonthlyReview(
      id: id,
      monthYear: monthYear,
      overallRating: overallRating,
      win1: win1,
      win2: win2,
      win3: win3,
      challenge1: challenge1,
      challenge2: challenge2,
      challenge3: challenge3,
      gratitudeSummary: gratitudeSummary,
      intentionsNextMonth: intentionsNextMonth,
      goalCompletionRate: goalCompletionRate,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}

extension MonthlyReviewX on MonthlyReview {
  MonthlyReviewsCompanion toCompanion() {
    return MonthlyReviewsCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      overallRating: Value(overallRating),
      win1: Value(win1),
      win2: Value(win2),
      win3: Value(win3),
      challenge1: Value(challenge1),
      challenge2: Value(challenge2),
      challenge3: Value(challenge3),
      gratitudeSummary: Value(gratitudeSummary),
      intentionsNextMonth: Value(intentionsNextMonth),
      goalCompletionRate: Value(goalCompletionRate),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension MonthlyGoalDataX on MonthlyGoalData {
  MonthlyGoal toDomain() {
    return MonthlyGoal(
      id: id,
      monthYear: monthYear,
      title: title,
      isAchieved: isAchieved == 1,
      sortOrder: sortOrder,
    );
  }
}

extension MonthlyGoalX on MonthlyGoal {
  MonthlyGoalsCompanion toCompanion() {
    return MonthlyGoalsCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      title: Value(title),
      isAchieved: Value(isAchieved ? 1 : 0),
      sortOrder: Value(sortOrder),
    );
  }
}
