// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'g_cal_sync_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GCalSyncState {

 bool get isSignedIn; bool get isSyncing; int get queueDepth; String? get lastError;
/// Create a copy of GCalSyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GCalSyncStateCopyWith<GCalSyncState> get copyWith => _$GCalSyncStateCopyWithImpl<GCalSyncState>(this as GCalSyncState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GCalSyncState&&(identical(other.isSignedIn, isSignedIn) || other.isSignedIn == isSignedIn)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.queueDepth, queueDepth) || other.queueDepth == queueDepth)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}


@override
int get hashCode => Object.hash(runtimeType,isSignedIn,isSyncing,queueDepth,lastError);

@override
String toString() {
  return 'GCalSyncState(isSignedIn: $isSignedIn, isSyncing: $isSyncing, queueDepth: $queueDepth, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class $GCalSyncStateCopyWith<$Res>  {
  factory $GCalSyncStateCopyWith(GCalSyncState value, $Res Function(GCalSyncState) _then) = _$GCalSyncStateCopyWithImpl;
@useResult
$Res call({
 bool isSignedIn, bool isSyncing, int queueDepth, String? lastError
});




}
/// @nodoc
class _$GCalSyncStateCopyWithImpl<$Res>
    implements $GCalSyncStateCopyWith<$Res> {
  _$GCalSyncStateCopyWithImpl(this._self, this._then);

  final GCalSyncState _self;
  final $Res Function(GCalSyncState) _then;

/// Create a copy of GCalSyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSignedIn = null,Object? isSyncing = null,Object? queueDepth = null,Object? lastError = freezed,}) {
  return _then(_self.copyWith(
isSignedIn: null == isSignedIn ? _self.isSignedIn : isSignedIn // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,queueDepth: null == queueDepth ? _self.queueDepth : queueDepth // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GCalSyncState].
extension GCalSyncStatePatterns on GCalSyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GCalSyncState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GCalSyncState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GCalSyncState value)  $default,){
final _that = this;
switch (_that) {
case _GCalSyncState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GCalSyncState value)?  $default,){
final _that = this;
switch (_that) {
case _GCalSyncState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSignedIn,  bool isSyncing,  int queueDepth,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GCalSyncState() when $default != null:
return $default(_that.isSignedIn,_that.isSyncing,_that.queueDepth,_that.lastError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSignedIn,  bool isSyncing,  int queueDepth,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _GCalSyncState():
return $default(_that.isSignedIn,_that.isSyncing,_that.queueDepth,_that.lastError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSignedIn,  bool isSyncing,  int queueDepth,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _GCalSyncState() when $default != null:
return $default(_that.isSignedIn,_that.isSyncing,_that.queueDepth,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc


class _GCalSyncState implements GCalSyncState {
  const _GCalSyncState({this.isSignedIn = false, this.isSyncing = false, this.queueDepth = 0, this.lastError});
  

@override@JsonKey() final  bool isSignedIn;
@override@JsonKey() final  bool isSyncing;
@override@JsonKey() final  int queueDepth;
@override final  String? lastError;

/// Create a copy of GCalSyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GCalSyncStateCopyWith<_GCalSyncState> get copyWith => __$GCalSyncStateCopyWithImpl<_GCalSyncState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GCalSyncState&&(identical(other.isSignedIn, isSignedIn) || other.isSignedIn == isSignedIn)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.queueDepth, queueDepth) || other.queueDepth == queueDepth)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}


@override
int get hashCode => Object.hash(runtimeType,isSignedIn,isSyncing,queueDepth,lastError);

@override
String toString() {
  return 'GCalSyncState(isSignedIn: $isSignedIn, isSyncing: $isSyncing, queueDepth: $queueDepth, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$GCalSyncStateCopyWith<$Res> implements $GCalSyncStateCopyWith<$Res> {
  factory _$GCalSyncStateCopyWith(_GCalSyncState value, $Res Function(_GCalSyncState) _then) = __$GCalSyncStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSignedIn, bool isSyncing, int queueDepth, String? lastError
});




}
/// @nodoc
class __$GCalSyncStateCopyWithImpl<$Res>
    implements _$GCalSyncStateCopyWith<$Res> {
  __$GCalSyncStateCopyWithImpl(this._self, this._then);

  final _GCalSyncState _self;
  final $Res Function(_GCalSyncState) _then;

/// Create a copy of GCalSyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSignedIn = null,Object? isSyncing = null,Object? queueDepth = null,Object? lastError = freezed,}) {
  return _then(_GCalSyncState(
isSignedIn: null == isSignedIn ? _self.isSignedIn : isSignedIn // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,queueDepth: null == queueDepth ? _self.queueDepth : queueDepth // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
