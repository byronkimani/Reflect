// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskListEvent()';
}


}

/// @nodoc
class $TaskListEventCopyWith<$Res>  {
$TaskListEventCopyWith(TaskListEvent _, $Res Function(TaskListEvent) __);
}


/// Adds pattern-matching-related methods to [TaskListEvent].
extension TaskListEventPatterns on TaskListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadTasksForDate value)?  loadTasksForDate,TResult Function( LoadBacklog value)?  loadBacklog,TResult Function( CompleteTask value)?  completeTask,TResult Function( ReopenTask value)?  reopenTask,TResult Function( PushToTomorrow value)?  pushToTomorrow,TResult Function( DeleteTask value)?  deleteTask,TResult Function( SortChanged value)?  sortChanged,TResult Function( FilterChanged value)?  filterChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadTasksForDate() when loadTasksForDate != null:
return loadTasksForDate(_that);case LoadBacklog() when loadBacklog != null:
return loadBacklog(_that);case CompleteTask() when completeTask != null:
return completeTask(_that);case ReopenTask() when reopenTask != null:
return reopenTask(_that);case PushToTomorrow() when pushToTomorrow != null:
return pushToTomorrow(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case SortChanged() when sortChanged != null:
return sortChanged(_that);case FilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadTasksForDate value)  loadTasksForDate,required TResult Function( LoadBacklog value)  loadBacklog,required TResult Function( CompleteTask value)  completeTask,required TResult Function( ReopenTask value)  reopenTask,required TResult Function( PushToTomorrow value)  pushToTomorrow,required TResult Function( DeleteTask value)  deleteTask,required TResult Function( SortChanged value)  sortChanged,required TResult Function( FilterChanged value)  filterChanged,}){
final _that = this;
switch (_that) {
case LoadTasksForDate():
return loadTasksForDate(_that);case LoadBacklog():
return loadBacklog(_that);case CompleteTask():
return completeTask(_that);case ReopenTask():
return reopenTask(_that);case PushToTomorrow():
return pushToTomorrow(_that);case DeleteTask():
return deleteTask(_that);case SortChanged():
return sortChanged(_that);case FilterChanged():
return filterChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadTasksForDate value)?  loadTasksForDate,TResult? Function( LoadBacklog value)?  loadBacklog,TResult? Function( CompleteTask value)?  completeTask,TResult? Function( ReopenTask value)?  reopenTask,TResult? Function( PushToTomorrow value)?  pushToTomorrow,TResult? Function( DeleteTask value)?  deleteTask,TResult? Function( SortChanged value)?  sortChanged,TResult? Function( FilterChanged value)?  filterChanged,}){
final _that = this;
switch (_that) {
case LoadTasksForDate() when loadTasksForDate != null:
return loadTasksForDate(_that);case LoadBacklog() when loadBacklog != null:
return loadBacklog(_that);case CompleteTask() when completeTask != null:
return completeTask(_that);case ReopenTask() when reopenTask != null:
return reopenTask(_that);case PushToTomorrow() when pushToTomorrow != null:
return pushToTomorrow(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case SortChanged() when sortChanged != null:
return sortChanged(_that);case FilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime date)?  loadTasksForDate,TResult Function()?  loadBacklog,TResult Function( String id)?  completeTask,TResult Function( String id)?  reopenTask,TResult Function( String id)?  pushToTomorrow,TResult Function( String id)?  deleteTask,TResult Function( SortMode sortMode)?  sortChanged,TResult Function( TaskListFilter filter)?  filterChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadTasksForDate() when loadTasksForDate != null:
return loadTasksForDate(_that.date);case LoadBacklog() when loadBacklog != null:
return loadBacklog();case CompleteTask() when completeTask != null:
return completeTask(_that.id);case ReopenTask() when reopenTask != null:
return reopenTask(_that.id);case PushToTomorrow() when pushToTomorrow != null:
return pushToTomorrow(_that.id);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case SortChanged() when sortChanged != null:
return sortChanged(_that.sortMode);case FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime date)  loadTasksForDate,required TResult Function()  loadBacklog,required TResult Function( String id)  completeTask,required TResult Function( String id)  reopenTask,required TResult Function( String id)  pushToTomorrow,required TResult Function( String id)  deleteTask,required TResult Function( SortMode sortMode)  sortChanged,required TResult Function( TaskListFilter filter)  filterChanged,}) {final _that = this;
switch (_that) {
case LoadTasksForDate():
return loadTasksForDate(_that.date);case LoadBacklog():
return loadBacklog();case CompleteTask():
return completeTask(_that.id);case ReopenTask():
return reopenTask(_that.id);case PushToTomorrow():
return pushToTomorrow(_that.id);case DeleteTask():
return deleteTask(_that.id);case SortChanged():
return sortChanged(_that.sortMode);case FilterChanged():
return filterChanged(_that.filter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime date)?  loadTasksForDate,TResult? Function()?  loadBacklog,TResult? Function( String id)?  completeTask,TResult? Function( String id)?  reopenTask,TResult? Function( String id)?  pushToTomorrow,TResult? Function( String id)?  deleteTask,TResult? Function( SortMode sortMode)?  sortChanged,TResult? Function( TaskListFilter filter)?  filterChanged,}) {final _that = this;
switch (_that) {
case LoadTasksForDate() when loadTasksForDate != null:
return loadTasksForDate(_that.date);case LoadBacklog() when loadBacklog != null:
return loadBacklog();case CompleteTask() when completeTask != null:
return completeTask(_that.id);case ReopenTask() when reopenTask != null:
return reopenTask(_that.id);case PushToTomorrow() when pushToTomorrow != null:
return pushToTomorrow(_that.id);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case SortChanged() when sortChanged != null:
return sortChanged(_that.sortMode);case FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class LoadTasksForDate implements TaskListEvent {
  const LoadTasksForDate(this.date);
  

 final  DateTime date;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadTasksForDateCopyWith<LoadTasksForDate> get copyWith => _$LoadTasksForDateCopyWithImpl<LoadTasksForDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadTasksForDate&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TaskListEvent.loadTasksForDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $LoadTasksForDateCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $LoadTasksForDateCopyWith(LoadTasksForDate value, $Res Function(LoadTasksForDate) _then) = _$LoadTasksForDateCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$LoadTasksForDateCopyWithImpl<$Res>
    implements $LoadTasksForDateCopyWith<$Res> {
  _$LoadTasksForDateCopyWithImpl(this._self, this._then);

  final LoadTasksForDate _self;
  final $Res Function(LoadTasksForDate) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(LoadTasksForDate(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class LoadBacklog implements TaskListEvent {
  const LoadBacklog();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadBacklog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskListEvent.loadBacklog()';
}


}




/// @nodoc


class CompleteTask implements TaskListEvent {
  const CompleteTask(this.id);
  

 final  String id;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteTaskCopyWith<CompleteTask> get copyWith => _$CompleteTaskCopyWithImpl<CompleteTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteTask&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskListEvent.completeTask(id: $id)';
}


}

/// @nodoc
abstract mixin class $CompleteTaskCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $CompleteTaskCopyWith(CompleteTask value, $Res Function(CompleteTask) _then) = _$CompleteTaskCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CompleteTaskCopyWithImpl<$Res>
    implements $CompleteTaskCopyWith<$Res> {
  _$CompleteTaskCopyWithImpl(this._self, this._then);

  final CompleteTask _self;
  final $Res Function(CompleteTask) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(CompleteTask(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReopenTask implements TaskListEvent {
  const ReopenTask(this.id);
  

 final  String id;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReopenTaskCopyWith<ReopenTask> get copyWith => _$ReopenTaskCopyWithImpl<ReopenTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReopenTask&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskListEvent.reopenTask(id: $id)';
}


}

/// @nodoc
abstract mixin class $ReopenTaskCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $ReopenTaskCopyWith(ReopenTask value, $Res Function(ReopenTask) _then) = _$ReopenTaskCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ReopenTaskCopyWithImpl<$Res>
    implements $ReopenTaskCopyWith<$Res> {
  _$ReopenTaskCopyWithImpl(this._self, this._then);

  final ReopenTask _self;
  final $Res Function(ReopenTask) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ReopenTask(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PushToTomorrow implements TaskListEvent {
  const PushToTomorrow(this.id);
  

 final  String id;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushToTomorrowCopyWith<PushToTomorrow> get copyWith => _$PushToTomorrowCopyWithImpl<PushToTomorrow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushToTomorrow&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskListEvent.pushToTomorrow(id: $id)';
}


}

/// @nodoc
abstract mixin class $PushToTomorrowCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $PushToTomorrowCopyWith(PushToTomorrow value, $Res Function(PushToTomorrow) _then) = _$PushToTomorrowCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$PushToTomorrowCopyWithImpl<$Res>
    implements $PushToTomorrowCopyWith<$Res> {
  _$PushToTomorrowCopyWithImpl(this._self, this._then);

  final PushToTomorrow _self;
  final $Res Function(PushToTomorrow) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(PushToTomorrow(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeleteTask implements TaskListEvent {
  const DeleteTask(this.id);
  

 final  String id;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteTaskCopyWith<DeleteTask> get copyWith => _$DeleteTaskCopyWithImpl<DeleteTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteTask&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskListEvent.deleteTask(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteTaskCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $DeleteTaskCopyWith(DeleteTask value, $Res Function(DeleteTask) _then) = _$DeleteTaskCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DeleteTaskCopyWithImpl<$Res>
    implements $DeleteTaskCopyWith<$Res> {
  _$DeleteTaskCopyWithImpl(this._self, this._then);

  final DeleteTask _self;
  final $Res Function(DeleteTask) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteTask(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SortChanged implements TaskListEvent {
  const SortChanged(this.sortMode);
  

 final  SortMode sortMode;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortChangedCopyWith<SortChanged> get copyWith => _$SortChangedCopyWithImpl<SortChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SortChanged&&(identical(other.sortMode, sortMode) || other.sortMode == sortMode));
}


@override
int get hashCode => Object.hash(runtimeType,sortMode);

@override
String toString() {
  return 'TaskListEvent.sortChanged(sortMode: $sortMode)';
}


}

/// @nodoc
abstract mixin class $SortChangedCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $SortChangedCopyWith(SortChanged value, $Res Function(SortChanged) _then) = _$SortChangedCopyWithImpl;
@useResult
$Res call({
 SortMode sortMode
});




}
/// @nodoc
class _$SortChangedCopyWithImpl<$Res>
    implements $SortChangedCopyWith<$Res> {
  _$SortChangedCopyWithImpl(this._self, this._then);

  final SortChanged _self;
  final $Res Function(SortChanged) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sortMode = null,}) {
  return _then(SortChanged(
null == sortMode ? _self.sortMode : sortMode // ignore: cast_nullable_to_non_nullable
as SortMode,
  ));
}


}

/// @nodoc


class FilterChanged implements TaskListEvent {
  const FilterChanged(this.filter);
  

 final  TaskListFilter filter;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterChangedCopyWith<FilterChanged> get copyWith => _$FilterChangedCopyWithImpl<FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'TaskListEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $FilterChangedCopyWith<$Res> implements $TaskListEventCopyWith<$Res> {
  factory $FilterChangedCopyWith(FilterChanged value, $Res Function(FilterChanged) _then) = _$FilterChangedCopyWithImpl;
@useResult
$Res call({
 TaskListFilter filter
});




}
/// @nodoc
class _$FilterChangedCopyWithImpl<$Res>
    implements $FilterChangedCopyWith<$Res> {
  _$FilterChangedCopyWithImpl(this._self, this._then);

  final FilterChanged _self;
  final $Res Function(FilterChanged) _then;

/// Create a copy of TaskListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(FilterChanged(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TaskListFilter,
  ));
}


}

// dart format on
