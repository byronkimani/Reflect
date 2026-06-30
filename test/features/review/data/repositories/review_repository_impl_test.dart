import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/review/data/repositories/review_repository_impl.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

void main() {
  late AppDatabase db;
  late ReviewRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = ReviewRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ReviewRepositoryImpl', () {
    test('saveDailyReview and getDailyReview', () async {
      final date = DateTime.now();
      
      // Get should return null initially
      final initialGet = await repository.getDailyReview(date);
      expect(initialGet.isRight(), isTrue);
      expect(initialGet.getOrElse((_) => null), isNull);
      
      // Save
      final state = const DailyReviewState(
        dayRating: 4,
        wentWell: 'Coding',
        couldBeBetter: 'Sleep',
        gratitude1: 'Coffee',
        taskCompletionRate: 80.0,
      );
      
      final saveResult = await repository.saveDailyReview(state);
      expect(saveResult.isRight(), isTrue);
      
      // Get should return saved review
      final getResult = await repository.getDailyReview(date);
      expect(getResult.isRight(), isTrue);
      final retrieved = getResult.getOrElse((_) => null);
      expect(retrieved, isNotNull);
      expect(retrieved!.dayRating, 4);
      expect(retrieved.wentWell, 'Coding');
      expect(retrieved.couldBeBetter, 'Sleep');
      expect(retrieved.gratitude1, 'Coffee');
    });
  });
}
