import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurrence_rule.freezed.dart';
part 'recurrence_rule.g.dart';

enum RecurrenceFrequency { DAILY, WEEKLY, MONTHLY, YEARLY }

enum RecurrenceEndType { NEVER, DATE, COUNT }

@freezed
abstract class RecurrenceRule with _$RecurrenceRule {
  const factory RecurrenceRule({
    required String id,
    required RecurrenceFrequency frequency,
    @Default(1) int intervalVal,
    List<int>? daysOfWeek,
    int? dayOfMonth,
    @Default(RecurrenceEndType.NEVER) RecurrenceEndType endType,
    DateTime? endDate,
    int? endCount,
    @Default(0) int occurrenceCount,
  }) = _RecurrenceRule;

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRuleFromJson(json);
}
