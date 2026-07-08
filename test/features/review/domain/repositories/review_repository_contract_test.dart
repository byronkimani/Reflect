import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/review/data/repositories/review_repository_impl.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

class MockIReviewRepository extends Mock implements IReviewRepository {}

class FakeDailyReviewState extends Fake implements DailyReviewState {}

void main() {
  final reviewDate = DateTime(2026, 6, 30);
  const review = DailyReviewState(dayRating: 4, wentWell: 'Productive day');

  group('IReviewRepository contract', () {
    late MockIReviewRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeDailyReviewState());
      registerFallbackValue(reviewDate);
    });

    setUp(() {
      repository = MockIReviewRepository();
    });

    test('saveDailyReview and getDailyReview return stubbed results', () async {
      when(() => repository.saveDailyReview(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.getDailyReview(any()))
          .thenAnswer((_) async => Right(review));

      expect(await repository.saveDailyReview(review), const Right(unit));
      expect(await repository.getDailyReview(reviewDate), Right(review));
    });

    test('getDailyReview can return null when no review exists', () async {
      when(() => repository.getDailyReview(any()))
          .thenAnswer((_) async => const Right(null));

      expect(await repository.getDailyReview(reviewDate), const Right(null));
    });

    test('failure results propagate through the interface', () async {
      const failure = CacheFailure(errorMessage: 'write failed');

      when(() => repository.saveDailyReview(any()))
          .thenAnswer((_) async => const Left(failure));
      when(() => repository.getDailyReview(any()))
          .thenAnswer((_) async => const Left(failure));

      expect(await repository.saveDailyReview(review), const Left(failure));
      expect(await repository.getDailyReview(reviewDate), const Left(failure));
    });
  });

  group('IReviewRepository implementation binding', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    });

    tearDown(() async {
      await db.close();
    });

    test('ReviewRepositoryImpl satisfies the interface', () {
      expect(ReviewRepositoryImpl(db), isA<IReviewRepository>());
    });
  });
}
