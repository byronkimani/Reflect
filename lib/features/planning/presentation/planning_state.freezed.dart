// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planning_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanningState {

 bool get isLoading; List<Task> get yesterdayIncomplete; List<Task> get backlogTasks; Set<String> get pulledTodayIds; String? get error;
/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanningStateCopyWith<PlanningState> get copyWith => _$PlanningStateCopyWithImpl<PlanningState>(this as PlanningState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanningState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.yesterdayIncomplete, yesterdayIncomplete)&&const DeepCollectionEquality().equals(other.backlogTasks, backlogTasks)&&const DeepCollectionEquality().equals(other.pulledTodayIds, pulledTodayIds)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(yesterdayIncomplete),const DeepCollectionEquality().hash(backlogTasks),const DeepCollectionEquality().hash(pulledTodayIds),error);

@override
String toString() {
  return 'PlanningState(isLoading: $isLoading, yesterdayIncomplete: $yesterdayIncomplete, backlogTasks: $backlogTasks, pulledTodayIds: $pulledTodayIds, error: $error)';
}


}

/// @nodoc
abstract mixin class $PlanningStateCopyWith<$Res>  {
  factory $PlanningStateCopyWith(PlanningState value, $Res Function(PlanningState) _then) = _$PlanningStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Task> yesterdayIncomplete, List<Task> backlogTasks, Set<String> pulledTodayIds, String? error
});




}
/// @nodoc
class _$PlanningStateCopyWithImpl<$Res>
    implements $PlanningStateCopyWith<$Res> {
  _$PlanningStateCopyWithImpl(this._self, this._then);

  final PlanningState _self;
  final $Res Function(PlanningState) _then;

/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? yesterdayIncomplete = null,Object? backlogTasks = null,Object? pulledTodayIds = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,yesterdayIncomplete: null == yesterdayIncomplete ? _self.yesterdayIncomplete : yesterdayIncomplete // ignore: cast_nullable_to_non_nullable
as List<Task>,backlogTasks: null == backlogTasks ? _self.backlogTasks : backlogTasks // ignore: cast_nullable_to_non_nullable
as List<Task>,pulledTodayIds: null == pulledTodayIds ? _self.pulledTodayIds : pulledTodayIds // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanningState].
extension PlanningStatePatterns on PlanningState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanningState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanningState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanningState value)  $default,){
final _that = this;
switch (_that) {
case _PlanningState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanningState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanningState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Task> yesterdayIncomplete,  List<Task> backlogTasks,  Set<String> pulledTodayIds,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanningState() when $default != null:
return $default(_that.isLoading,_that.yesterdayIncomplete,_that.backlogTasks,_that.pulledTodayIds,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Task> yesterdayIncomplete,  List<Task> backlogTasks,  Set<String> pulledTodayIds,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PlanningState():
return $default(_that.isLoading,_that.yesterdayIncomplete,_that.backlogTasks,_that.pulledTodayIds,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Task> yesterdayIncomplete,  List<Task> backlogTasks,  Set<String> pulledTodayIds,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PlanningState() when $default != null:
return $default(_that.isLoading,_that.yesterdayIncomplete,_that.backlogTasks,_that.pulledTodayIds,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PlanningState implements PlanningState {
  const _PlanningState({this.isLoading = false, final  List<Task> yesterdayIncomplete = const [], final  List<Task> backlogTasks = const [], final  Set<String> pulledTodayIds = const {}, this.error}): _yesterdayIncomplete = yesterdayIncomplete,_backlogTasks = backlogTasks,_pulledTodayIds = pulledTodayIds;
  

@override@JsonKey() final  bool isLoading;
 final  List<Task> _yesterdayIncomplete;
@override@JsonKey() List<Task> get yesterdayIncomplete {
  if (_yesterdayIncomplete is EqualUnmodifiableListView) return _yesterdayIncomplete;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_yesterdayIncomplete);
}

 final  List<Task> _backlogTasks;
@override@JsonKey() List<Task> get backlogTasks {
  if (_backlogTasks is EqualUnmodifiableListView) return _backlogTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backlogTasks);
}

 final  Set<String> _pulledTodayIds;
@override@JsonKey() Set<String> get pulledTodayIds {
  if (_pulledTodayIds is EqualUnmodifiableSetView) return _pulledTodayIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_pulledTodayIds);
}

@override final  String? error;

/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanningStateCopyWith<_PlanningState> get copyWith => __$PlanningStateCopyWithImpl<_PlanningState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanningState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._yesterdayIncomplete, _yesterdayIncomplete)&&const DeepCollectionEquality().equals(other._backlogTasks, _backlogTasks)&&const DeepCollectionEquality().equals(other._pulledTodayIds, _pulledTodayIds)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_yesterdayIncomplete),const DeepCollectionEquality().hash(_backlogTasks),const DeepCollectionEquality().hash(_pulledTodayIds),error);

@override
String toString() {
  return 'PlanningState(isLoading: $isLoading, yesterdayIncomplete: $yesterdayIncomplete, backlogTasks: $backlogTasks, pulledTodayIds: $pulledTodayIds, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PlanningStateCopyWith<$Res> implements $PlanningStateCopyWith<$Res> {
  factory _$PlanningStateCopyWith(_PlanningState value, $Res Function(_PlanningState) _then) = __$PlanningStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Task> yesterdayIncomplete, List<Task> backlogTasks, Set<String> pulledTodayIds, String? error
});




}
/// @nodoc
class __$PlanningStateCopyWithImpl<$Res>
    implements _$PlanningStateCopyWith<$Res> {
  __$PlanningStateCopyWithImpl(this._self, this._then);

  final _PlanningState _self;
  final $Res Function(_PlanningState) _then;

/// Create a copy of PlanningState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? yesterdayIncomplete = null,Object? backlogTasks = null,Object? pulledTodayIds = null,Object? error = freezed,}) {
  return _then(_PlanningState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,yesterdayIncomplete: null == yesterdayIncomplete ? _self._yesterdayIncomplete : yesterdayIncomplete // ignore: cast_nullable_to_non_nullable
as List<Task>,backlogTasks: null == backlogTasks ? _self._backlogTasks : backlogTasks // ignore: cast_nullable_to_non_nullable
as List<Task>,pulledTodayIds: null == pulledTodayIds ? _self._pulledTodayIds : pulledTodayIds // ignore: cast_nullable_to_non_nullable
as Set<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
