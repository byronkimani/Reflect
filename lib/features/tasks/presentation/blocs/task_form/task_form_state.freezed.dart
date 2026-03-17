// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskFormState {

 String get title; TaskPriority get priority; DateTime? get dueDate; bool get syncToGcal; bool get isSubmitting; bool get isSuccess; String? get error; Task? get initialTask;
/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFormStateCopyWith<TaskFormState> get copyWith => _$TaskFormStateCopyWithImpl<TaskFormState>(this as TaskFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFormState&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.syncToGcal, syncToGcal) || other.syncToGcal == syncToGcal)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error)&&(identical(other.initialTask, initialTask) || other.initialTask == initialTask));
}


@override
int get hashCode => Object.hash(runtimeType,title,priority,dueDate,syncToGcal,isSubmitting,isSuccess,error,initialTask);

@override
String toString() {
  return 'TaskFormState(title: $title, priority: $priority, dueDate: $dueDate, syncToGcal: $syncToGcal, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error, initialTask: $initialTask)';
}


}

/// @nodoc
abstract mixin class $TaskFormStateCopyWith<$Res>  {
  factory $TaskFormStateCopyWith(TaskFormState value, $Res Function(TaskFormState) _then) = _$TaskFormStateCopyWithImpl;
@useResult
$Res call({
 String title, TaskPriority priority, DateTime? dueDate, bool syncToGcal, bool isSubmitting, bool isSuccess, String? error, Task? initialTask
});


$TaskCopyWith<$Res>? get initialTask;

}
/// @nodoc
class _$TaskFormStateCopyWithImpl<$Res>
    implements $TaskFormStateCopyWith<$Res> {
  _$TaskFormStateCopyWithImpl(this._self, this._then);

  final TaskFormState _self;
  final $Res Function(TaskFormState) _then;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? priority = null,Object? dueDate = freezed,Object? syncToGcal = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,Object? initialTask = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,syncToGcal: null == syncToGcal ? _self.syncToGcal : syncToGcal // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,initialTask: freezed == initialTask ? _self.initialTask : initialTask // ignore: cast_nullable_to_non_nullable
as Task?,
  ));
}
/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get initialTask {
    if (_self.initialTask == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.initialTask!, (value) {
    return _then(_self.copyWith(initialTask: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskFormState].
extension TaskFormStatePatterns on TaskFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFormState value)  $default,){
final _that = this;
switch (_that) {
case _TaskFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFormState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  TaskPriority priority,  DateTime? dueDate,  bool syncToGcal,  bool isSubmitting,  bool isSuccess,  String? error,  Task? initialTask)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
return $default(_that.title,_that.priority,_that.dueDate,_that.syncToGcal,_that.isSubmitting,_that.isSuccess,_that.error,_that.initialTask);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  TaskPriority priority,  DateTime? dueDate,  bool syncToGcal,  bool isSubmitting,  bool isSuccess,  String? error,  Task? initialTask)  $default,) {final _that = this;
switch (_that) {
case _TaskFormState():
return $default(_that.title,_that.priority,_that.dueDate,_that.syncToGcal,_that.isSubmitting,_that.isSuccess,_that.error,_that.initialTask);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  TaskPriority priority,  DateTime? dueDate,  bool syncToGcal,  bool isSubmitting,  bool isSuccess,  String? error,  Task? initialTask)?  $default,) {final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
return $default(_that.title,_that.priority,_that.dueDate,_that.syncToGcal,_that.isSubmitting,_that.isSuccess,_that.error,_that.initialTask);case _:
  return null;

}
}

}

/// @nodoc


class _TaskFormState implements TaskFormState {
  const _TaskFormState({this.title = '', this.priority = TaskPriority.p4, this.dueDate, this.syncToGcal = false, this.isSubmitting = false, this.isSuccess = false, this.error, this.initialTask});
  

@override@JsonKey() final  String title;
@override@JsonKey() final  TaskPriority priority;
@override final  DateTime? dueDate;
@override@JsonKey() final  bool syncToGcal;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;
@override final  Task? initialTask;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFormStateCopyWith<_TaskFormState> get copyWith => __$TaskFormStateCopyWithImpl<_TaskFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFormState&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.syncToGcal, syncToGcal) || other.syncToGcal == syncToGcal)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error)&&(identical(other.initialTask, initialTask) || other.initialTask == initialTask));
}


@override
int get hashCode => Object.hash(runtimeType,title,priority,dueDate,syncToGcal,isSubmitting,isSuccess,error,initialTask);

@override
String toString() {
  return 'TaskFormState(title: $title, priority: $priority, dueDate: $dueDate, syncToGcal: $syncToGcal, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error, initialTask: $initialTask)';
}


}

/// @nodoc
abstract mixin class _$TaskFormStateCopyWith<$Res> implements $TaskFormStateCopyWith<$Res> {
  factory _$TaskFormStateCopyWith(_TaskFormState value, $Res Function(_TaskFormState) _then) = __$TaskFormStateCopyWithImpl;
@override @useResult
$Res call({
 String title, TaskPriority priority, DateTime? dueDate, bool syncToGcal, bool isSubmitting, bool isSuccess, String? error, Task? initialTask
});


@override $TaskCopyWith<$Res>? get initialTask;

}
/// @nodoc
class __$TaskFormStateCopyWithImpl<$Res>
    implements _$TaskFormStateCopyWith<$Res> {
  __$TaskFormStateCopyWithImpl(this._self, this._then);

  final _TaskFormState _self;
  final $Res Function(_TaskFormState) _then;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? priority = null,Object? dueDate = freezed,Object? syncToGcal = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,Object? initialTask = freezed,}) {
  return _then(_TaskFormState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,syncToGcal: null == syncToGcal ? _self.syncToGcal : syncToGcal // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,initialTask: freezed == initialTask ? _self.initialTask : initialTask // ignore: cast_nullable_to_non_nullable
as Task?,
  ));
}

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get initialTask {
    if (_self.initialTask == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.initialTask!, (value) {
    return _then(_self.copyWith(initialTask: value));
  });
}
}

// dart format on
