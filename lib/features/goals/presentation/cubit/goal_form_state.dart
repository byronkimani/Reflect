import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class GoalFormState {
  const GoalFormState({
    this.title = '',
    this.description,
    this.categoryId,
    this.kpiDescription,
    this.startValue,
    this.targetValue,
    this.priority,
    this.urgency,
    this.why,
    this.startDate,
    this.targetDate,
    this.checkInFrequency,
    this.timeHorizon = GoalTimeHorizon.weekly,
    this.isMeasurable = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
    this.initialGoal,
  });

  final String title;
  final String? description;
  final String? categoryId;
  final String? kpiDescription;
  final String? startValue;
  final String? targetValue;
  final TaskPriority? priority;
  final TaskPriority? urgency;
  final String? why;
  final DateTime? startDate;
  final DateTime? targetDate;
  final CheckInFrequency? checkInFrequency;
  final GoalTimeHorizon timeHorizon;
  final bool isMeasurable;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;
  final Goal? initialGoal;

  GoalFormState copyWith({
    String? title,
    String? description,
    String? categoryId,
    String? kpiDescription,
    String? startValue,
    String? targetValue,
    TaskPriority? priority,
    TaskPriority? urgency,
    String? why,
    DateTime? startDate,
    DateTime? targetDate,
    CheckInFrequency? checkInFrequency,
    GoalTimeHorizon? timeHorizon,
    bool? isMeasurable,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
    Goal? initialGoal,
    bool clearDescription = false,
    bool clearCategoryId = false,
    bool clearPriority = false,
    bool clearUrgency = false,
  }) {
    return GoalFormState(
      title: title ?? this.title,
      description: clearDescription ? null : (description ?? this.description),
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      kpiDescription: kpiDescription ?? this.kpiDescription,
      startValue: startValue ?? this.startValue,
      targetValue: targetValue ?? this.targetValue,
      priority: clearPriority ? null : (priority ?? this.priority),
      urgency: clearUrgency ? null : (urgency ?? this.urgency),
      why: why ?? this.why,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      checkInFrequency: checkInFrequency ?? this.checkInFrequency,
      timeHorizon: timeHorizon ?? this.timeHorizon,
      isMeasurable: isMeasurable ?? this.isMeasurable,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      initialGoal: initialGoal ?? this.initialGoal,
    );
  }
}
