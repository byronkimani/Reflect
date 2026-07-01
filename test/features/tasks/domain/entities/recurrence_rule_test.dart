import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';

void main() {
  group('RecurrenceRule', () {
    test('fromJson deserializes all fields', () {
      final json = {
        'id': 'rule-1',
        'frequency': 'WEEKLY',
        'intervalVal': 2,
        'daysOfWeek': [1, 3, 5],
        'dayOfMonth': 15,
        'endType': 'COUNT',
        'endDate': '2025-12-31T00:00:00.000',
        'endCount': 10,
        'occurrenceCount': 3,
      };

      final rule = RecurrenceRule.fromJson(json);

      expect(rule.id, 'rule-1');
      expect(rule.frequency, RecurrenceFrequency.WEEKLY);
      expect(rule.intervalVal, 2);
      expect(rule.daysOfWeek, [1, 3, 5]);
      expect(rule.dayOfMonth, 15);
      expect(rule.endType, RecurrenceEndType.COUNT);
      expect(rule.endDate, DateTime.parse('2025-12-31T00:00:00.000'));
      expect(rule.endCount, 10);
      expect(rule.occurrenceCount, 3);
    });

    test('toJson round-trips through fromJson', () {
      final original = RecurrenceRule(
        id: 'rule-2',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 3,
        endType: RecurrenceEndType.DATE,
        endDate: DateTime(2025, 6, 1),
        occurrenceCount: 1,
      );

      final restored = RecurrenceRule.fromJson(original.toJson());

      expect(restored, original);
    });

    test('fromJson applies defaults for optional fields', () {
      final rule = RecurrenceRule.fromJson({
        'id': 'rule-3',
        'frequency': 'MONTHLY',
      });

      expect(rule.intervalVal, 1);
      expect(rule.endType, RecurrenceEndType.NEVER);
      expect(rule.occurrenceCount, 0);
      expect(rule.daysOfWeek, isNull);
    });
  });
}
