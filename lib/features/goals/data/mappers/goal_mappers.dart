import 'package:drift/drift.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

extension GoalCategoryDataX on GoalCategoryData {
  GoalCategory toDomain() {
    return GoalCategory(
      id: id,
      name: name,
      sortOrder: sortOrder,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }
}

extension GoalCategoryX on GoalCategory {
  GoalCategoriesCompanion toCompanion() {
    return GoalCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
      updatedAt: Value(updatedAt.millisecondsSinceEpoch),
    );
  }
}

TaskPriority? _priorityFromString(String? s) {
  if (s == null) return null;
  try {
    return TaskPriority.values.firstWhere((e) => e.name == s);
  } catch (_) {
    return null;
  }
}

CheckInFrequency? _checkInFrequencyFromString(String? s) {
  if (s == null) return null;
  try {
    return CheckInFrequency.values.firstWhere((e) => e.name == s);
  } catch (_) {
    return null;
  }
}

extension GoalDataX on GoalData {
  Goal toDomain() {
    return Goal(
      id: id,
      title: title,
      description: description,
      categoryId: categoryId,
      kpiDescription: kpiDescription,
      startValue: startValue,
      targetValue: targetValue,
      priority: _priorityFromString(priority),
      urgency: _priorityFromString(urgency),
      why: why,
      startDate: startDate != null
          ? DateTime.fromMillisecondsSinceEpoch(startDate!)
          : null,
      targetDate: targetDate != null
          ? DateTime.fromMillisecondsSinceEpoch(targetDate!)
          : null,
      checkInFrequency: _checkInFrequencyFromString(checkInFrequency),
      isMeasurable: isMeasurable,
      timeHorizon: GoalTimeHorizon.values.firstWhere(
        (e) => e.name == timeHorizon,
        orElse: () => GoalTimeHorizon.weekly,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }
}

extension GoalX on Goal {
  GoalsCompanion toCompanion() {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      categoryId: Value(categoryId),
      kpiDescription: Value(kpiDescription),
      startValue: Value(startValue),
      targetValue: Value(targetValue),
      priority: Value(priority?.name),
      urgency: Value(urgency?.name),
      why: Value(why),
      startDate: Value(startDate?.millisecondsSinceEpoch),
      targetDate: Value(targetDate?.millisecondsSinceEpoch),
      checkInFrequency: Value(checkInFrequency?.name),
      isMeasurable: Value(isMeasurable ?? true),
      timeHorizon: Value(timeHorizon.name),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
      updatedAt: Value(updatedAt.millisecondsSinceEpoch),
    );
  }
}
