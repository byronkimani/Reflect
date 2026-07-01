import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/goals/data/mappers/goal_mappers.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  group('GoalCategory Mappers', () {
    final now = DateTime.now();

    test('GoalCategoryDataX toDomain maps correctly', () {
      final data = GoalCategoryData(
        id: 'cat-1',
        name: 'Work',
        sortOrder: 1,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );

      final domain = data.toDomain();
      expect(domain.id, 'cat-1');
      expect(domain.name, 'Work');
      expect(domain.sortOrder, 1);
      expect(domain.createdAt.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
    });

    test('GoalCategoryX toCompanion maps correctly', () {
      final domain = GoalCategory(
        id: 'cat-2',
        name: 'Personal',
        sortOrder: 2,
        createdAt: now,
        updatedAt: now,
      );

      final companion = domain.toCompanion();
      expect(companion.id.value, 'cat-2');
      expect(companion.name.value, 'Personal');
      expect(companion.sortOrder.value, 2);
    });
  });

  group('Goal Mappers', () {
    final now = DateTime.now();

    test('GoalDataX toDomain maps correctly', () {
      final data = GoalData(
        id: 'goal-1',
        title: 'Complete Project',
        description: 'Desc',
        categoryId: 'cat-1',
        kpiDescription: 'KPI',
        startValue: '0.0',
        targetValue: '100.0',
        priority: TaskPriority.p1.name,
        urgency: TaskPriority.p2.name,
        why: 'Why',
        startDate: now.millisecondsSinceEpoch,
        targetDate: now.millisecondsSinceEpoch,
        checkInFrequency: CheckInFrequency.weekly.name,
        isMeasurable: true,
        timeHorizon: GoalTimeHorizon.monthly.name,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );

      final domain = data.toDomain();
      expect(domain.id, 'goal-1');
      expect(domain.priority, TaskPriority.p1);
      expect(domain.urgency, TaskPriority.p2);
      expect(domain.checkInFrequency, CheckInFrequency.weekly);
      expect(domain.timeHorizon, GoalTimeHorizon.monthly);
      expect(domain.isMeasurable, true);
    });

    test('GoalDataX toDomain fallbacks to null on invalid enums', () {
      final data = GoalData(
        id: 'goal-invalid',
        title: 'Title',
        priority: 'invalid_priority',
        urgency: 'invalid_urgency',
        checkInFrequency: 'invalid_freq',
        timeHorizon: 'invalid_horizon',
        isMeasurable: true,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );

      final domain = data.toDomain();
      expect(domain.priority, isNull);
      expect(domain.urgency, isNull);
      expect(domain.checkInFrequency, isNull);
      expect(domain.timeHorizon, GoalTimeHorizon.weekly); // Fallback is weekly
      expect(domain.isMeasurable, true);
    });

    test('GoalDataX toDomain handles null optionals', () {
      final data = GoalData(
        id: 'goal-null',
        title: 'Title',
        priority: null,
        urgency: null,
        checkInFrequency: null,
        timeHorizon: GoalTimeHorizon.quarterly.name,
        startDate: null,
        targetDate: null,
        isMeasurable: true,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );

      final domain = data.toDomain();
      expect(domain.priority, isNull);
      expect(domain.urgency, isNull);
      expect(domain.startDate, isNull);
      expect(domain.targetDate, isNull);
      expect(domain.isMeasurable, true);
    });

    test('GoalX toCompanion maps correctly', () {
      final domain = Goal(
        id: 'goal-2',
        title: 'Title 2',
        priority: TaskPriority.p3,
        timeHorizon: GoalTimeHorizon.yearly,
        checkInFrequency: CheckInFrequency.monthly,
        createdAt: now,
        updatedAt: now,
      );

      final companion = domain.toCompanion();
      expect(companion.id.value, 'goal-2');
      expect(companion.title.value, 'Title 2');
      expect(companion.priority.value, TaskPriority.p3.name);
      expect(companion.timeHorizon.value, GoalTimeHorizon.yearly.name);
      expect(companion.checkInFrequency.value, CheckInFrequency.monthly.name);
    });
  });
}
