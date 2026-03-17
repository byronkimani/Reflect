import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('DailyReviewData')
class DailyReviews extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get reviewDate => integer().unique()(); // Unix epoch ms
  IntColumn get dayRating => integer()();
  TextColumn get wentWell => text().nullable()();
  TextColumn get couldBeBetter => text().nullable()();
  TextColumn get gratitude1 => text()();
  TextColumn get gratitude2 => text()();
  TextColumn get gratitude3 => text()();
  RealColumn get taskCompletionRate => real().withDefault(const Constant(0.0))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WeeklyPlanData')
class WeeklyPlans extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get weekStartDate => integer().unique()(); // Unix epoch ms
  TextColumn get theme => text().nullable()();
  TextColumn get intentions => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WeeklyReviewData')
class WeeklyReviews extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get weekStartDate => integer().unique().customConstraint('NOT NULL REFERENCES weekly_plans(week_start_date)')();
  IntColumn get themeAchieved => integer().nullable()();
  TextColumn get reflectionNotes => text().nullable()();
  IntColumn get weekRating => integer()();
  RealColumn get goalHitRate => real().withDefault(const Constant(0.0))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WeeklyGoalData')
class WeeklyGoals extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get weekStartDate => integer().customConstraint('NOT NULL REFERENCES weekly_plans(week_start_date)')();
  TextColumn get title => text()();
  IntColumn get isAchieved => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MonthlyPlanData')
class MonthlyPlans extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get monthYear => text().unique()(); // e.g., "2024-03"
  TextColumn get intentions => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MonthlyReviewData')
class MonthlyReviews extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get monthYear => text().unique().customConstraint('NOT NULL REFERENCES monthly_plans(month_year)')();
  IntColumn get overallRating => integer()();
  TextColumn get win1 => text().nullable()();
  TextColumn get win2 => text().nullable()();
  TextColumn get win3 => text().nullable()();
  TextColumn get challenge1 => text().nullable()();
  TextColumn get challenge2 => text().nullable()();
  TextColumn get challenge3 => text().nullable()();
  TextColumn get gratitudeSummary => text().nullable()();
  TextColumn get intentionsNextMonth => text().nullable()();
  RealColumn get goalCompletionRate => real().withDefault(const Constant(0.0))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MonthlyGoalData')
class MonthlyGoals extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get monthYear => text().customConstraint('NOT NULL REFERENCES monthly_plans(month_year)')();
  TextColumn get title => text()();
  IntColumn get isAchieved => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
