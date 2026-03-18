// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get title; TaskPriority get priority; DateTime? get dueDate; String? get dueTime; String? get notes; List<Tag> get tags; TaskStatus get status; bool get isOverdue; int get overdueDay; RecurrenceRule? get recurrenceRule; String? get recurrenceParentId; List<Subtask> get subtasks; String? get gcalEventId; bool get syncToGcal; bool get hasEnabledReminder; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.dueTime, dueTime) || other.dueTime == dueTime)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.overdueDay, overdueDay) || other.overdueDay == overdueDay)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.recurrenceParentId, recurrenceParentId) || other.recurrenceParentId == recurrenceParentId)&&const DeepCollectionEquality().equals(other.subtasks, subtasks)&&(identical(other.gcalEventId, gcalEventId) || other.gcalEventId == gcalEventId)&&(identical(other.syncToGcal, syncToGcal) || other.syncToGcal == syncToGcal)&&(identical(other.hasEnabledReminder, hasEnabledReminder) || other.hasEnabledReminder == hasEnabledReminder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priority,dueDate,dueTime,notes,const DeepCollectionEquality().hash(tags),status,isOverdue,overdueDay,recurrenceRule,recurrenceParentId,const DeepCollectionEquality().hash(subtasks),gcalEventId,syncToGcal,hasEnabledReminder,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, title: $title, priority: $priority, dueDate: $dueDate, dueTime: $dueTime, notes: $notes, tags: $tags, status: $status, isOverdue: $isOverdue, overdueDay: $overdueDay, recurrenceRule: $recurrenceRule, recurrenceParentId: $recurrenceParentId, subtasks: $subtasks, gcalEventId: $gcalEventId, syncToGcal: $syncToGcal, hasEnabledReminder: $hasEnabledReminder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String title, TaskPriority priority, DateTime? dueDate, String? dueTime, String? notes, List<Tag> tags, TaskStatus status, bool isOverdue, int overdueDay, RecurrenceRule? recurrenceRule, String? recurrenceParentId, List<Subtask> subtasks, String? gcalEventId, bool syncToGcal, bool hasEnabledReminder, DateTime createdAt, DateTime updatedAt
});


$RecurrenceRuleCopyWith<$Res>? get recurrenceRule;

}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? dueDate = freezed,Object? dueTime = freezed,Object? notes = freezed,Object? tags = null,Object? status = null,Object? isOverdue = null,Object? overdueDay = null,Object? recurrenceRule = freezed,Object? recurrenceParentId = freezed,Object? subtasks = null,Object? gcalEventId = freezed,Object? syncToGcal = null,Object? hasEnabledReminder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTime: freezed == dueTime ? _self.dueTime : dueTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,overdueDay: null == overdueDay ? _self.overdueDay : overdueDay // ignore: cast_nullable_to_non_nullable
as int,recurrenceRule: freezed == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule?,recurrenceParentId: freezed == recurrenceParentId ? _self.recurrenceParentId : recurrenceParentId // ignore: cast_nullable_to_non_nullable
as String?,subtasks: null == subtasks ? _self.subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<Subtask>,gcalEventId: freezed == gcalEventId ? _self.gcalEventId : gcalEventId // ignore: cast_nullable_to_non_nullable
as String?,syncToGcal: null == syncToGcal ? _self.syncToGcal : syncToGcal // ignore: cast_nullable_to_non_nullable
as bool,hasEnabledReminder: null == hasEnabledReminder ? _self.hasEnabledReminder : hasEnabledReminder // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<$Res>? get recurrenceRule {
    if (_self.recurrenceRule == null) {
    return null;
  }

  return $RecurrenceRuleCopyWith<$Res>(_self.recurrenceRule!, (value) {
    return _then(_self.copyWith(recurrenceRule: value));
  });
}
}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  TaskPriority priority,  DateTime? dueDate,  String? dueTime,  String? notes,  List<Tag> tags,  TaskStatus status,  bool isOverdue,  int overdueDay,  RecurrenceRule? recurrenceRule,  String? recurrenceParentId,  List<Subtask> subtasks,  String? gcalEventId,  bool syncToGcal,  bool hasEnabledReminder,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.dueDate,_that.dueTime,_that.notes,_that.tags,_that.status,_that.isOverdue,_that.overdueDay,_that.recurrenceRule,_that.recurrenceParentId,_that.subtasks,_that.gcalEventId,_that.syncToGcal,_that.hasEnabledReminder,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  TaskPriority priority,  DateTime? dueDate,  String? dueTime,  String? notes,  List<Tag> tags,  TaskStatus status,  bool isOverdue,  int overdueDay,  RecurrenceRule? recurrenceRule,  String? recurrenceParentId,  List<Subtask> subtasks,  String? gcalEventId,  bool syncToGcal,  bool hasEnabledReminder,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.title,_that.priority,_that.dueDate,_that.dueTime,_that.notes,_that.tags,_that.status,_that.isOverdue,_that.overdueDay,_that.recurrenceRule,_that.recurrenceParentId,_that.subtasks,_that.gcalEventId,_that.syncToGcal,_that.hasEnabledReminder,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  TaskPriority priority,  DateTime? dueDate,  String? dueTime,  String? notes,  List<Tag> tags,  TaskStatus status,  bool isOverdue,  int overdueDay,  RecurrenceRule? recurrenceRule,  String? recurrenceParentId,  List<Subtask> subtasks,  String? gcalEventId,  bool syncToGcal,  bool hasEnabledReminder,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.title,_that.priority,_that.dueDate,_that.dueTime,_that.notes,_that.tags,_that.status,_that.isOverdue,_that.overdueDay,_that.recurrenceRule,_that.recurrenceParentId,_that.subtasks,_that.gcalEventId,_that.syncToGcal,_that.hasEnabledReminder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, required this.title, this.priority = TaskPriority.p4, this.dueDate, this.dueTime, this.notes, final  List<Tag> tags = const [], this.status = TaskStatus.pending, this.isOverdue = false, this.overdueDay = 0, this.recurrenceRule, this.recurrenceParentId, final  List<Subtask> subtasks = const [], this.gcalEventId, this.syncToGcal = false, this.hasEnabledReminder = false, required this.createdAt, required this.updatedAt}): _tags = tags,_subtasks = subtasks,super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  TaskPriority priority;
@override final  DateTime? dueDate;
@override final  String? dueTime;
@override final  String? notes;
 final  List<Tag> _tags;
@override@JsonKey() List<Tag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  TaskStatus status;
@override@JsonKey() final  bool isOverdue;
@override@JsonKey() final  int overdueDay;
@override final  RecurrenceRule? recurrenceRule;
@override final  String? recurrenceParentId;
 final  List<Subtask> _subtasks;
@override@JsonKey() List<Subtask> get subtasks {
  if (_subtasks is EqualUnmodifiableListView) return _subtasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subtasks);
}

@override final  String? gcalEventId;
@override@JsonKey() final  bool syncToGcal;
@override@JsonKey() final  bool hasEnabledReminder;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.dueTime, dueTime) || other.dueTime == dueTime)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.overdueDay, overdueDay) || other.overdueDay == overdueDay)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.recurrenceParentId, recurrenceParentId) || other.recurrenceParentId == recurrenceParentId)&&const DeepCollectionEquality().equals(other._subtasks, _subtasks)&&(identical(other.gcalEventId, gcalEventId) || other.gcalEventId == gcalEventId)&&(identical(other.syncToGcal, syncToGcal) || other.syncToGcal == syncToGcal)&&(identical(other.hasEnabledReminder, hasEnabledReminder) || other.hasEnabledReminder == hasEnabledReminder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priority,dueDate,dueTime,notes,const DeepCollectionEquality().hash(_tags),status,isOverdue,overdueDay,recurrenceRule,recurrenceParentId,const DeepCollectionEquality().hash(_subtasks),gcalEventId,syncToGcal,hasEnabledReminder,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, title: $title, priority: $priority, dueDate: $dueDate, dueTime: $dueTime, notes: $notes, tags: $tags, status: $status, isOverdue: $isOverdue, overdueDay: $overdueDay, recurrenceRule: $recurrenceRule, recurrenceParentId: $recurrenceParentId, subtasks: $subtasks, gcalEventId: $gcalEventId, syncToGcal: $syncToGcal, hasEnabledReminder: $hasEnabledReminder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, TaskPriority priority, DateTime? dueDate, String? dueTime, String? notes, List<Tag> tags, TaskStatus status, bool isOverdue, int overdueDay, RecurrenceRule? recurrenceRule, String? recurrenceParentId, List<Subtask> subtasks, String? gcalEventId, bool syncToGcal, bool hasEnabledReminder, DateTime createdAt, DateTime updatedAt
});


@override $RecurrenceRuleCopyWith<$Res>? get recurrenceRule;

}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? priority = null,Object? dueDate = freezed,Object? dueTime = freezed,Object? notes = freezed,Object? tags = null,Object? status = null,Object? isOverdue = null,Object? overdueDay = null,Object? recurrenceRule = freezed,Object? recurrenceParentId = freezed,Object? subtasks = null,Object? gcalEventId = freezed,Object? syncToGcal = null,Object? hasEnabledReminder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueTime: freezed == dueTime ? _self.dueTime : dueTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,overdueDay: null == overdueDay ? _self.overdueDay : overdueDay // ignore: cast_nullable_to_non_nullable
as int,recurrenceRule: freezed == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRule?,recurrenceParentId: freezed == recurrenceParentId ? _self.recurrenceParentId : recurrenceParentId // ignore: cast_nullable_to_non_nullable
as String?,subtasks: null == subtasks ? _self._subtasks : subtasks // ignore: cast_nullable_to_non_nullable
as List<Subtask>,gcalEventId: freezed == gcalEventId ? _self.gcalEventId : gcalEventId // ignore: cast_nullable_to_non_nullable
as String?,syncToGcal: null == syncToGcal ? _self.syncToGcal : syncToGcal // ignore: cast_nullable_to_non_nullable
as bool,hasEnabledReminder: null == hasEnabledReminder ? _self.hasEnabledReminder : hasEnabledReminder // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<$Res>? get recurrenceRule {
    if (_self.recurrenceRule == null) {
    return null;
  }

  return $RecurrenceRuleCopyWith<$Res>(_self.recurrenceRule!, (value) {
    return _then(_self.copyWith(recurrenceRule: value));
  });
}
}

// dart format on
