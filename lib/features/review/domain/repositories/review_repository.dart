abstract class ReviewRepository {
  Future<void> submitDailyReview({
    required int rating,
    required String wentWell,
    required String couldBeBetter,
    required List<String> gratitudes,
    required double completionRate,
  });
}
