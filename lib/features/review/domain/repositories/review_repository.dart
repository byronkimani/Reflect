import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

abstract class IReviewRepository {
  Future<Either<Failure, Unit>> saveDailyReview(DailyReviewState review);
  Future<Either<Failure, DailyReviewState?>> getDailyReview(DateTime date);
}
