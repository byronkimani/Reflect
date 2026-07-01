import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/data/models/mappers.dart';

void main() {
  group('localDayStartEpochMs', () {
    test('returns midnight local epoch for due date', () {
      final due = DateTime(2026, 3, 15, 14, 30);
      final expected =
          DateTime(2026, 3, 15).millisecondsSinceEpoch;

      expect(localDayStartEpochMs(due), expected);
    });

    test('returns null when due date is null', () {
      expect(localDayStartEpochMs(null), isNull);
    });
  });
}
