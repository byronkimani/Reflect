// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecurrenceRule _$RecurrenceRuleFromJson(Map<String, dynamic> json) =>
    _RecurrenceRule(
      id: json['id'] as String,
      frequency: $enumDecode(_$RecurrenceFrequencyEnumMap, json['frequency']),
      intervalVal: (json['intervalVal'] as num?)?.toInt() ?? 1,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      endType:
          $enumDecodeNullable(_$RecurrenceEndTypeEnumMap, json['endType']) ??
          RecurrenceEndType.NEVER,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      endCount: (json['endCount'] as num?)?.toInt(),
      occurrenceCount: (json['occurrenceCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RecurrenceRuleToJson(_RecurrenceRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frequency': _$RecurrenceFrequencyEnumMap[instance.frequency]!,
      'intervalVal': instance.intervalVal,
      'daysOfWeek': instance.daysOfWeek,
      'dayOfMonth': instance.dayOfMonth,
      'endType': _$RecurrenceEndTypeEnumMap[instance.endType]!,
      'endDate': instance.endDate?.toIso8601String(),
      'endCount': instance.endCount,
      'occurrenceCount': instance.occurrenceCount,
    };

const _$RecurrenceFrequencyEnumMap = {
  RecurrenceFrequency.DAILY: 'DAILY',
  RecurrenceFrequency.WEEKLY: 'WEEKLY',
  RecurrenceFrequency.MONTHLY: 'MONTHLY',
  RecurrenceFrequency.YEARLY: 'YEARLY',
};

const _$RecurrenceEndTypeEnumMap = {
  RecurrenceEndType.NEVER: 'NEVER',
  RecurrenceEndType.DATE: 'DATE',
  RecurrenceEndType.COUNT: 'COUNT',
};
