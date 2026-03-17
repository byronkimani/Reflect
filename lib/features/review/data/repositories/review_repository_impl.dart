import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

class ReviewRepositoryImpl implements IReviewRepository {
  final AppDatabase _db;

  ReviewRepositoryImpl(this._db);

  @override
  Future<Either<Failure, Unit>> saveDailyReview(DailyReviewState review) async {
    try {
      final date = DateTime.now();
      final dateMs = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      
      await _db.into(_db.dailyReviews).insertOnConflictUpdate(
        DailyReviewsCompanion.insert(
          reviewDate: dateMs,
          dayRating: review.dayRating,
          wentWell: Value(review.wentWell),
          couldBeBetter: Value(review.couldBeBetter),
          gratitude1: review.gratitude1,
          gratitude2: review.gratitude2,
          gratitude3: review.gratitude3,
          taskCompletionRate: Value(review.taskCompletionRate),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyReviewState?>> getDailyReview(DateTime date) async {
    try {
      final dateMs = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      final query = _db.select(_db.dailyReviews)..where((t) => t.reviewDate.equals(dateMs));
      final result = await query.getSingleOrNull();
      
      if (result == null) return const Right(null);
      
      return Right(DailyReviewState(
        dayRating: result.dayRating,
        wentWell: result.wentWell ?? '',
        couldBeBetter: result.couldBeBetter ?? '',
        gratitude1: result.gratitude1,
        gratitude2: result.gratitude2,
        gratitude3: result.gratitude3,
        taskCompletionRate: result.taskCompletionRate,
      ));
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }
}
