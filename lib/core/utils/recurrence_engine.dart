import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';

/// A utility class for calculating the next occurrence date for recurring tasks.
/// Following Material Design and iCal standards for recurrence logic.
class RecurrenceEngine {
  /// Calculates the next occurrence date based on the [rule] and the current [from] date.
  /// Returns null if the recurrence series has ended.
  static DateTime? nextOccurrenceDate(RecurrenceRule rule, DateTime from) {
    DateTime nextCandidate;

    switch (rule.frequency) {
      case RecurrenceFrequency.DAILY:
        nextCandidate = _nextDaily(rule, from);
        break;
      case RecurrenceFrequency.WEEKLY:
        nextCandidate = _nextWeekly(rule, from);
        break;
      case RecurrenceFrequency.MONTHLY:
        nextCandidate = _nextMonthly(rule, from);
        break;
      case RecurrenceFrequency.YEARLY:
        nextCandidate = _nextYearly(rule, from);
        break;
    }

    // Preserve the time from the original date
    nextCandidate = DateTime(
      nextCandidate.year,
      nextCandidate.month,
      nextCandidate.day,
      from.hour,
      from.minute,
      from.second,
      from.millisecond,
      from.microsecond,
    );

    if (_isSeriesEnded(rule, nextCandidate)) {
      return null;
    }

    return nextCandidate;
  }

  /// Checks if the recurrence series has ended based on [endDate] or [endCount].
  static bool _isSeriesEnded(RecurrenceRule rule, DateTime candidate) {
    if (rule.endType == RecurrenceEndType.DATE && rule.endDate != null) {
      return candidate.isAfter(rule.endDate!);
    }
    if (rule.endType == RecurrenceEndType.COUNT && rule.endCount != null) {
      // occurrenceCount + 1 because we are calculating the *next* one
      return rule.occurrenceCount + 1 >= rule.endCount!;
    }
    return false;
  }

  /// Calculates the next daily occurrence.
  static DateTime _nextDaily(RecurrenceRule rule, DateTime from) {
    return from.add(Duration(days: rule.intervalVal));
  }

  /// Calculates the next weekly occurrence.
  /// Handles multiple days of the week and intervals.
  static DateTime _nextWeekly(RecurrenceRule rule, DateTime from) {
    final days = List<int>.from(rule.daysOfWeek ?? [from.weekday])..sort();
    final currentWeekday = from.weekday;

    // Find the next active day in the current week
    for (final day in days) {
      if (day > currentWeekday) {
        return from.add(Duration(days: day - currentWeekday));
      }
    }

    // No more active days in this week, move to the next cycle
    final firstDayOfNextCycle = days.first;
    final daysUntilEndOfWeek = 7 - currentWeekday;
    final weeksToAdd = rule.intervalVal - 1;

    return from.add(Duration(days: daysUntilEndOfWeek + (weeksToAdd * 7) + firstDayOfNextCycle));
  }

  /// Calculates the next monthly occurrence.
  /// Handles month-end clamping (e.g., Jan 31 -> Feb 28).
  static DateTime _nextMonthly(RecurrenceRule rule, DateTime from) {
    var nextYear = from.year;
    var nextMonth = from.month + rule.intervalVal;

    while (nextMonth > 12) {
      nextYear++;
      nextMonth -= 12;
    }

    final targetDay = rule.dayOfMonth ?? from.day;
    final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
    final clampedDay = targetDay > lastDayOfNextMonth ? lastDayOfNextMonth : targetDay;

    return DateTime(nextYear, nextMonth, clampedDay);
  }

  /// Calculates the next yearly occurrence.
  /// Handles leap year edge cases (Feb 29).
  static DateTime _nextYearly(RecurrenceRule rule, DateTime from) {
    final nextYear = from.year + rule.intervalVal;
    final nextMonth = from.month;
    final targetDay = from.day;

    final lastDayOfTargetMonth = DateTime(nextYear, nextMonth + 1, 0).day;
    final clampedDay = targetDay > lastDayOfTargetMonth ? lastDayOfTargetMonth : targetDay;

    return DateTime(nextYear, nextMonth, clampedDay);
  }
}
