// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskSelectionState {

 Set<String> get selectedTaskIds; bool get isSelectionMode;
/// Create a copy of TaskSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSelectionStateCopyWith<TaskSelectionState> get copyWith => _$TaskSelectionStateCopyWithImpl<TaskSelectionState>(this as TaskSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSelectionState&&const DeepCollectionEquality().equals(other.selectedTaskIds, selectedTaskIds)&&(identical(other.isSelectionMode, isSelectionMode) || other.isSelectionMode == isSelectionMode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedTaskIds),isSelectionMode);

@override
String toString() {
  return 'TaskSelectionState(selectedTaskIds: $selectedTaskIds, isSelectionMode: $isSelectionMode)';
}


}

/// @nodoc
abstract mixin class $TaskSelectionStateCopyWith<$Res>  {
  factory $TaskSelectionStateCopyWith(TaskSelectionState value, $Res Function(TaskSelectionState) _then) = _$TaskSelectionStateCopyWithImpl;
@useResult
$Res call({
 Set<String> selectedTaskIds, bool isSelectionMode
});




}
/// @nodoc
class _$TaskSelectionStateCopyWithImpl<$Res>
    implements $TaskSelectionStateCopyWith<$Res> {
  _$TaskSelectionStateCopyWithImpl(this._self, this._then);

  final TaskSelectionState _self;
  final $Res Function(TaskSelectionState) _then;

/// Create a copy of TaskSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedTaskIds = null,Object? isSelectionMode = null,}) {
  return _then(_self.copyWith(
selectedTaskIds: null == selectedTaskIds ? _self.selectedTaskIds : selectedTaskIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isSelectionMode: null == isSelectionMode ? _self.isSelectionMode : isSelectionMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSelectionState].
extension TaskSelectionStatePatterns on TaskSelectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSelectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _TaskSelectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSelectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> selectedTaskIds,  bool isSelectionMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskSelectionState() when $default != null:
return $default(_that.selectedTaskIds,_that.isSelectionMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> selectedTaskIds,  bool isSelectionMode)  $default,) {final _that = this;
switch (_that) {
case _TaskSelectionState():
return $default(_that.selectedTaskIds,_that.isSelectionMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> selectedTaskIds,  bool isSelectionMode)?  $default,) {final _that = this;
switch (_that) {
case _TaskSelectionState() when $default != null:
return $default(_that.selectedTaskIds,_that.isSelectionMode);case _:
  return null;

}
}

}

/// @nodoc


class _TaskSelectionState implements TaskSelectionState {
  const _TaskSelectionState({final  Set<String> selectedTaskIds = const <String>{}, this.isSelectionMode = false}): _selectedTaskIds = selectedTaskIds;
  

 final  Set<String> _selectedTaskIds;
@override@JsonKey() Set<String> get selectedTaskIds {
  if (_selectedTaskIds is EqualUnmodifiableSetView) return _selectedTaskIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedTaskIds);
}

@override@JsonKey() final  bool isSelectionMode;

/// Create a copy of TaskSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSelectionStateCopyWith<_TaskSelectionState> get copyWith => __$TaskSelectionStateCopyWithImpl<_TaskSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSelectionState&&const DeepCollectionEquality().equals(other._selectedTaskIds, _selectedTaskIds)&&(identical(other.isSelectionMode, isSelectionMode) || other.isSelectionMode == isSelectionMode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedTaskIds),isSelectionMode);

@override
String toString() {
  return 'TaskSelectionState(selectedTaskIds: $selectedTaskIds, isSelectionMode: $isSelectionMode)';
}


}

/// @nodoc
abstract mixin class _$TaskSelectionStateCopyWith<$Res> implements $TaskSelectionStateCopyWith<$Res> {
  factory _$TaskSelectionStateCopyWith(_TaskSelectionState value, $Res Function(_TaskSelectionState) _then) = __$TaskSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 Set<String> selectedTaskIds, bool isSelectionMode
});




}
/// @nodoc
class __$TaskSelectionStateCopyWithImpl<$Res>
    implements _$TaskSelectionStateCopyWith<$Res> {
  __$TaskSelectionStateCopyWithImpl(this._self, this._then);

  final _TaskSelectionState _self;
  final $Res Function(_TaskSelectionState) _then;

/// Create a copy of TaskSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedTaskIds = null,Object? isSelectionMode = null,}) {
  return _then(_TaskSelectionState(
selectedTaskIds: null == selectedTaskIds ? _self._selectedTaskIds : selectedTaskIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isSelectionMode: null == isSelectionMode ? _self.isSelectionMode : isSelectionMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
