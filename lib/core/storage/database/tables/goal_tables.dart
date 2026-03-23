import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('GoalCategoryData')
class GoalCategories extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GoalData')
class Goals extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get categoryId =>
      text().nullable().customConstraint('REFERENCES goal_categories(id) ON DELETE SET NULL')();
  TextColumn get kpiDescription => text().nullable()();
  TextColumn get startValue => text().nullable()();
  TextColumn get targetValue => text().nullable()();
  TextColumn get priority => text().nullable()(); // p1, p2, p3, p4
  TextColumn get urgency => text().nullable()(); // p1, p2, p3, p4
  TextColumn get why => text().nullable()();
  IntColumn get startDate => integer().nullable()(); // Unix epoch ms
  IntColumn get targetDate => integer().nullable()();
  TextColumn get checkInFrequency => text().nullable()(); // none, daily, weekly, biWeekly, monthly
  TextColumn get timeHorizon => text()(); // weekly, monthly, quarterly, yearly
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
