import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

part 'goal.freezed.dart';

enum GoalTimeHorizon { weekly, monthly, quarterly, yearly }

enum CheckInFrequency { none, daily, weekly, biWeekly, monthly }

@freezed
abstract class Goal with _$Goal {
  const Goal._();

  const factory Goal({
    required String id,
    required String title,
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
    required GoalTimeHorizon timeHorizon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Goal;
}
