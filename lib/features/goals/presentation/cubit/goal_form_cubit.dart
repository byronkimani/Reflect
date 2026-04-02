import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_state.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class GoalFormCubit extends Cubit<GoalFormState> {
  GoalFormCubit(this._repo, {Goal? initialGoal, GoalTimeHorizon? timeHorizon})
      : super(GoalFormState(
          initialGoal: initialGoal,
          title: initialGoal?.title ?? '',
          description: initialGoal?.description,
          categoryId: initialGoal?.categoryId,
          kpiDescription: initialGoal?.kpiDescription,
          startValue: initialGoal?.startValue,
          targetValue: initialGoal?.targetValue,
          priority: initialGoal?.priority,
          urgency: initialGoal?.urgency,
          why: initialGoal?.why,
          startDate: initialGoal?.startDate,
          targetDate: initialGoal?.targetDate,
          checkInFrequency: initialGoal?.checkInFrequency,
          timeHorizon: timeHorizon ?? initialGoal?.timeHorizon ?? GoalTimeHorizon.weekly,
          isMeasurable: initialGoal?.isMeasurable ?? true,
        ));

  final IGoalRepository _repo;

  void titleChanged(String value) => emit(state.copyWith(title: value));
  void descriptionChanged(String? value) => emit(state.copyWith(description: value));
  void categoryIdChanged(String? value) => emit(state.copyWith(categoryId: value));
  void kpiDescriptionChanged(String? value) => emit(state.copyWith(kpiDescription: value));
  void startValueChanged(String? value) => emit(state.copyWith(startValue: value));
  void targetValueChanged(String? value) => emit(state.copyWith(targetValue: value));
  void priorityChanged(TaskPriority? value) => emit(
        state.copyWith(priority: value, clearPriority: value == null),
      );
  void urgencyChanged(TaskPriority? value) => emit(
        state.copyWith(urgency: value, clearUrgency: value == null),
      );
  void whyChanged(String? value) => emit(state.copyWith(why: value));
  void startDateChanged(DateTime? value) => emit(state.copyWith(startDate: value));
  void targetDateChanged(DateTime? value) => emit(state.copyWith(targetDate: value));
  void checkInFrequencyChanged(CheckInFrequency? value) =>
      emit(state.copyWith(checkInFrequency: value));
  void timeHorizonChanged(GoalTimeHorizon value) =>
      emit(state.copyWith(timeHorizon: value));
  void isMeasurableChanged(bool value) => emit(state.copyWith(isMeasurable: value));

  Future<void> submit() async {
    if (state.title.trim().isEmpty) {
      emit(state.copyWith(error: 'Title is required'));
      return;
    }
    emit(state.copyWith(isSubmitting: true, error: null));
    final now = DateTime.now();
    final goal = Goal(
      id: state.initialGoal?.id ?? '',
      title: state.title.trim(),
      description: state.description?.trim().isEmpty == true
          ? null
          : state.description?.trim(),
      categoryId: state.categoryId,
      isMeasurable: state.isMeasurable,
      kpiDescription: (!state.isMeasurable || state.kpiDescription?.trim().isEmpty == true)
          ? null
          : state.kpiDescription?.trim(),
      startValue: (!state.isMeasurable || state.startValue?.trim().isEmpty == true)
          ? null
          : state.startValue?.trim(),
      targetValue: (!state.isMeasurable || state.targetValue?.trim().isEmpty == true)
          ? null
          : state.targetValue?.trim(),
      priority: state.priority,
      urgency: state.urgency,
      why: state.why?.trim().isEmpty == true ? null : state.why?.trim(),
      startDate: state.startDate,
      targetDate: state.targetDate,
      checkInFrequency: state.checkInFrequency,
      timeHorizon: state.timeHorizon,
      createdAt: state.initialGoal?.createdAt ?? now,
      updatedAt: now,
    );
    final result = state.initialGoal != null
        ? await _repo.updateGoal(goal)
        : await _repo.createGoal(goal);
    result.fold(
      (f) => emit(state.copyWith(isSubmitting: false, error: f.errorMessage)),
      (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }
}
