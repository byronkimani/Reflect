import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';

import 'daily_review_state.dart';

class DailyReviewCubit extends Cubit<DailyReviewState> {
  final IReviewRepository _reviewRepository;

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
    final result = await _reviewRepository.saveDailyReview(state);
    
    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, error: failure.errorMessage)),
      (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }
}
