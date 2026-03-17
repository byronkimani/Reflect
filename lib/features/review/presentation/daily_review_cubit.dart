import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';

import 'daily_review_state.dart';

class DailyReviewCubit extends Cubit<DailyReviewState> {
  final ReviewRepository _reviewRepository;

  DailyReviewCubit(this._reviewRepository) : super(const DailyReviewState());

  void ratingChanged(int rating) {
    emit(state.copyWith(dayRating: rating));
  }

  void wentWellChanged(String value) {
    emit(state.copyWith(wentWell: value));
  }

  void couldBeBetterChanged(String value) {
    emit(state.copyWith(couldBeBetter: value));
  }

  void gratitudeChanged(int index, String text) {
    if (index == 0) emit(state.copyWith(gratitude1: text));
    if (index == 1) emit(state.copyWith(gratitude2: text));
    if (index == 2) emit(state.copyWith(gratitude3: text));
  }

  void completionRateChanged(double rate) {
    emit(state.copyWith(taskCompletionRate: rate));
  }

  Future<void> submitReview() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      await _reviewRepository.submitDailyReview(
        rating: state.dayRating,
        wentWell: state.wentWell,
        couldBeBetter: state.couldBeBetter,
        gratitudes: [state.gratitude1, state.gratitude2, state.gratitude3],
        completionRate: state.taskCompletionRate,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
