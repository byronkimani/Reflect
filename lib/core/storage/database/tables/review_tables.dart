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
