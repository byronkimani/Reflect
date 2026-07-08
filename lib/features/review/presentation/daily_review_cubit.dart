import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';

import 'daily_review_state.dart';

class DailyReviewCubit extends Cubit<DailyReviewState> {
  DailyReviewCubit(
    this._reviewRepository,
    this._taskRepository,
    this._analytics,
  ) : super(const DailyReviewState());

  final IReviewRepository _reviewRepository;
  final ITaskRepository _taskRepository;
  final AppAnalyticsService _analytics;

  Future<void> initializeForToday() async {
    emit(const DailyReviewState());
    final result = await _taskRepository.getTasksForDate(DateTime.now());
    result.fold((_) {}, (tasks) {
      if (tasks.isEmpty) return;
      final completed =
          tasks.where((t) => t.status == TaskStatus.completed).length;
      emit(
        state.copyWith(
          tasksCompletedToday: completed,
          tasksTotalToday: tasks.length,
          taskCompletionRate: completed / tasks.length,
        ),
      );
    });
  }

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

  void addGratitudeField() {
    if (state.gratitudeFieldCount < 3) {
      emit(state.copyWith(gratitudeFieldCount: state.gratitudeFieldCount + 1));
    }
  }

  void completionRateChanged(double rate) {
    emit(state.copyWith(taskCompletionRate: rate));
  }

  Future<void> submitReview() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(isSubmitting: true, error: null));
    final result = await _reviewRepository.saveDailyReview(state);

    await result.fold<Future<void>>(
      (failure) async {
        emit(state.copyWith(isSubmitting: false, error: failure.errorMessage));
      },
      (_) async {
        await _analytics.logDailyReviewSubmitted();
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      },
    );
  }
}
