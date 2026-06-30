import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';

void main() {
  late RecurrenceEngine engine;

  setUp(() {
    engine = RecurrenceEngineImpl();
  });

  group('RecurrenceEngineImpl', () {
    final baseDate = DateTime(2026, 6, 30); // A Tuesday
    final now = DateTime.now();

    test('returns null if recurrenceRule is null', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate,
        createdAt: now,
        updatedAt: now,
      );
      expect(engine.getNextOccurrence(task), isNull);
    });

    test('daily recurrence adds intervalVal days', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate,
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule1',
          frequency: RecurrenceFrequency.DAILY,
          intervalVal: 3,
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2026, 7, 3));
    });

    test('weekly recurrence without daysOfWeek adds intervalVal weeks', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate,
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule2',
          frequency: RecurrenceFrequency.WEEKLY,
          intervalVal: 2,
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2026, 7, 14));
    });

    test('weekly recurrence with daysOfWeek finds the next day', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate, // Tuesday
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule3',
          frequency: RecurrenceFrequency.WEEKLY,
          intervalVal: 1,
          daysOfWeek: [DateTime.friday, DateTime.saturday],
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2026, 7, 3)); // Friday
    });

    test('weekly recurrence with daysOfWeek rolls over to next week if none found this week', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: DateTime(2026, 7, 4), // Saturday
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule4',
          frequency: RecurrenceFrequency.WEEKLY,
          intervalVal: 1,
          daysOfWeek: [DateTime.monday],
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2026, 7, 6)); // Monday
    });

    test('monthly recurrence adds intervalVal months', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate,
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule5',
          frequency: RecurrenceFrequency.MONTHLY,
          intervalVal: 1,
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2026, 7, 30));
    });

    test('yearly recurrence adds intervalVal years', () {
      final task = Task(
        id: '1',
        title: 'Test',
        dueDate: baseDate,
        createdAt: now,
        updatedAt: now,
        recurrenceRule: const RecurrenceRule(
          id: 'rule6',
          frequency: RecurrenceFrequency.YEARLY,
          intervalVal: 2,
        ),
      );
      final next = engine.getNextOccurrence(task);
      expect(next, DateTime(2028, 6, 30));
    });
  });
}
