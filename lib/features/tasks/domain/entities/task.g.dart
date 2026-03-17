// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  priority:
      $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
      TaskPriority.p4,
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  dueTime: json['dueTime'] as String?,
  notes: json['notes'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.pending,
  isOverdue: json['isOverdue'] as bool? ?? false,
  overdueDay: (json['overdueDay'] as num?)?.toInt() ?? 0,
  recurrenceRule: json['recurrenceRule'] == null
      ? null
      : RecurrenceRule.fromJson(json['recurrenceRule'] as Map<String, dynamic>),
  recurrenceParentId: json['recurrenceParentId'] as String?,
  subtasks:
      (json['subtasks'] as List<dynamic>?)
          ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  gcalEventId: json['gcalEventId'] as String?,
  syncToGcal: json['syncToGcal'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'dueDate': instance.dueDate?.toIso8601String(),
  'dueTime': instance.dueTime,
  'notes': instance.notes,
  'tags': instance.tags,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'isOverdue': instance.isOverdue,
  'overdueDay': instance.overdueDay,
  'recurrenceRule': instance.recurrenceRule,
  'recurrenceParentId': instance.recurrenceParentId,
  'subtasks': instance.subtasks,
  'gcalEventId': instance.gcalEventId,
  'syncToGcal': instance.syncToGcal,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$TaskPriorityEnumMap = {
  TaskPriority.p1: 'p1',
  TaskPriority.p2: 'p2',
  TaskPriority.p3: 'p3',
  TaskPriority.p4: 'p4',
};

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.completed: 'completed',
  TaskStatus.overdue: 'overdue',
};
