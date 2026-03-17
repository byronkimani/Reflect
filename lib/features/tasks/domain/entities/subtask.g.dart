// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subtask _$SubtaskFromJson(Map<String, dynamic> json) => _Subtask(
  id: json['id'] as String,
  taskId: json['taskId'] as String,
  title: json['title'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SubtaskToJson(_Subtask instance) => <String, dynamic>{
  'id': instance.id,
  'taskId': instance.taskId,
  'title': instance.title,
  'isCompleted': instance.isCompleted,
  'sortOrder': instance.sortOrder,
  'createdAt': instance.createdAt.toIso8601String(),
};
