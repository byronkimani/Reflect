import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/utils/recurrence_engine.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';

void main() {
  group('RecurrenceEngine - Daily', () {
    test('Calculates next daily occurrence with interval 1', () {
      final rule = RecurrenceRule(
        id: '1',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 1,
      );
      final from = DateTime(2024, 1, 1, 10, 30);
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 1, 2, 10, 30));
    });

    test('Calculates next daily occurrence with interval 3', () {
      final rule = RecurrenceRule(
        id: '2',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 3,
      );
      final from = DateTime(2024, 1, 1, 10, 30);
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 1, 4, 10, 30));
    });
  });

  group('RecurrenceEngine - Weekly', () {
    test('Calculates next weekly occurrence on the same week', () {
      // Monday (1) to Wednesday (3)
      final rule = RecurrenceRule(
        id: '3',
        frequency: RecurrenceFrequency.WEEKLY,
        intervalVal: 1,
        daysOfWeek: [1, 3, 5],
      );
      final from = DateTime(2024, 1, 1, 10, 30); // 2024-01-01 is Monday
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 1, 3, 10, 30));
    });

    test('Calculates next weekly occurrence jumping to next week', () {
      // Friday (5) to next Monday (1)
      final rule = RecurrenceRule(
        id: '4',
        frequency: RecurrenceFrequency.WEEKLY,
        intervalVal: 1,
        daysOfWeek: [1, 3, 5],
      );
      final from = DateTime(2024, 1, 5, 10, 30); // Friday
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 1, 8, 10, 30)); // Next Monday
    });

    test('Calculates next weekly occurrence with interval 2', () {
      // Friday (5) to Monday (1) after 2 weeks
      final rule = RecurrenceRule(
        id: '5',
        frequency: RecurrenceFrequency.WEEKLY,
        intervalVal: 2,
        daysOfWeek: [1, 5],
      );
      final from = DateTime(2024, 1, 5, 10, 30); // Friday
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 1, 15, 10, 30)); // Monday in 2 weeks
    });
  });

  group('RecurrenceEngine - Monthly Edge Cases', () {
    test('Regular month addition', () {
      final rule = RecurrenceRule(
        id: '6',
        frequency: RecurrenceFrequency.MONTHLY,
        intervalVal: 1,
      );
      final from = DateTime(2024, 1, 15, 10, 30);
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 2, 15, 10, 30));
    });

    test('Month-end clamping (Jan 31 to Feb 28/29)', () {
      final rule = RecurrenceRule(
        id: '7',
        frequency: RecurrenceFrequency.MONTHLY,
        intervalVal: 1,
      );
      final from = DateTime(2023, 1, 31, 10, 30); // Non-leap year
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2023, 2, 28, 10, 30));
    });

    test('Leap year month-end clamping (Jan 31 2024 to Feb 29 2024)', () {
      final rule = RecurrenceRule(
        id: '8',
        frequency: RecurrenceFrequency.MONTHLY,
        intervalVal: 1,
      );
      final from = DateTime(2024, 1, 31, 10, 30); // Leap year
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      expect(next, DateTime(2024, 2, 29, 10, 30));
    });
  });

  group('RecurrenceEngine - End Conditions', () {
    test('Stops after reaching endCount', () {
      final rule = RecurrenceRule(
        id: '9',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 1,
        endType: RecurrenceEndType.COUNT,
        endCount: 3,
        occurrenceCount: 2, // We've done 2, next calculation is for the 3rd one.
      );
      final from = DateTime(2024, 1, 1, 10, 30);
      final next = RecurrenceEngine.nextOccurrenceDate(rule, from);

      // Rule says end after 3 occurrences. Current is 2. Next is 3rd.
      // Wait, if it says "end after 3", then the 3rd one is the LAST valid one.
      // Usually "endCount" means the TOTAL number of occurrences.
      // If occurrenceCount is 2, it means we have had 2 occurrences.
      // The 3rd one is the next one. After that, it should return null.
      // 0, 1, 2 are valid. 3 is the threshold.
      // If occurrenceCount = 2, the next one (3rd) is still valid? 
      // iCal COUNT includes the start date. 
      // If COUNT=3, occurrences are: 1, 2, 3. 
      // If we are at 2nd (occurrenceCount=1), next is 3rd.
      // If we are at 3rd (occurrenceCount=2), next would be 4th (null).
      
      expect(next, isNull);
    });

    test('Stops after reaching endDate', () {
      final endDate = DateTime(2024, 1, 1, 12, 0);
      final rule = RecurrenceRule(
        id: '10',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 1,
        endType: RecurrenceEndType.DATE,
        endDate: endDate,
      );
      final from = DateTime(2023, 12, 31, 10, 30);
      
      // Next is 2024-01-01 10:30, which is BEFORE 12:00. This is VALID.
      final nextValid = RecurrenceEngine.nextOccurrenceDate(rule, from);
      expect(nextValid, DateTime(2024, 1, 1, 10, 30));

      // Next after that is 2024-01-02 10:30, which is AFTER endDate. Should be null.
      final nextInvalid = RecurrenceEngine.nextOccurrenceDate(rule, nextValid!);
      expect(nextInvalid, isNull);
    });
  });
}
