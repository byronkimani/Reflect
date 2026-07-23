import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
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

  StreamSubscription<Either<Failure, List<Task>>>? _todayTasksSubscription;

  void startWatchingTodayTasks() {
    _todayTasksSubscription?.cancel();
    _todayTasksSubscription = _taskRepository
        .watchTasksForDate(DateTime.now())
        .listen(_onTodayTasksUpdate);
  }

  void _onTodayTasksUpdate(Either<Failure, List<Task>> result) {
    if (isClosed) return;
    result.fold((_) {}, (tasks) {
      final completed =
          tasks.where((t) => t.status == TaskStatus.completed).length;
      final total = tasks.length;
      emit(
        state.copyWith(
          tasksCompletedToday: completed,
          tasksTotalToday: total,
          taskCompletionRate: total == 0 ? 0.0 : completed / total,
        ),
      );
    });
  }

  Future<void> initializeForToday() async {
    startWatchingTodayTasks();
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

  void removeGratitudeField(int index) {
    if (index <= 0 || index >= state.gratitudeFieldCount) return;

    var gratitude1 = state.gratitude1;
    var gratitude2 = state.gratitude2;
    var gratitude3 = state.gratitude3;

    if (index == 1) {
      gratitude2 = gratitude3;
      gratitude3 = '';
    } else if (index == 2) {
      gratitude3 = '';
    }

    emit(
      state.copyWith(
        gratitude1: gratitude1,
        gratitude2: gratitude2,
        gratitude3: gratitude3,
        gratitudeFieldCount: state.gratitudeFieldCount - 1,
      ),
    );
  }

  void completionRateChanged(double rate) {
    emit(state.copyWith(taskCompletionRate: rate));
  }

  DailyReviewState _trimmedForSubmit() {
    return state.copyWith(
      wentWell: state.wentWell.trim(),
      couldBeBetter: state.couldBeBetter.trim(),
      gratitude1: state.gratitude1.trim(),
      gratitude2: state.gratitude2.trim(),
      gratitude3: state.gratitude3.trim(),
    );
  }

  Future<void> submitReview() async {
    if (!state.canSubmit) return;

    final trimmed = _trimmedForSubmit();
    emit(trimmed.copyWith(isSubmitting: true, error: null));
    final result = await _reviewRepository.saveDailyReview(trimmed);

    await result.fold<Future<void>>(
      (failure) async {
        emit(trimmed.copyWith(isSubmitting: false, error: failure.errorMessage));
      },
      (_) async {
        await _analytics.logDailyReviewSubmitted();
        emit(trimmed.copyWith(isSubmitting: false, isSuccess: true));
      },
    );
  }

  @override
  Future<void> close() {
    _todayTasksSubscription?.cancel();
    return super.close();
  }
}
