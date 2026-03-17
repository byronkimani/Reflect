// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectivityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityEvent()';
}


}

/// @nodoc
class $ConnectivityEventCopyWith<$Res>  {
$ConnectivityEventCopyWith(ConnectivityEvent _, $Res Function(ConnectivityEvent) __);
}


/// Adds pattern-matching-related methods to [ConnectivityEvent].
extension ConnectivityEventPatterns on ConnectivityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MonitorConnectivityStarted value)?  monitorStarted,TResult Function( ConnectivityChanged value)?  connectivityChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MonitorConnectivityStarted() when monitorStarted != null:
return monitorStarted(_that);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MonitorConnectivityStarted value)  monitorStarted,required TResult Function( ConnectivityChanged value)  connectivityChanged,}){
final _that = this;
switch (_that) {
case MonitorConnectivityStarted():
return monitorStarted(_that);case ConnectivityChanged():
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MonitorConnectivityStarted value)?  monitorStarted,TResult? Function( ConnectivityChanged value)?  connectivityChanged,}){
final _that = this;
switch (_that) {
case MonitorConnectivityStarted() when monitorStarted != null:
return monitorStarted(_that);case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  monitorStarted,TResult Function( bool isConnected)?  connectivityChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MonitorConnectivityStarted() when monitorStarted != null:
return monitorStarted();case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isConnected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  monitorStarted,required TResult Function( bool isConnected)  connectivityChanged,}) {final _that = this;
switch (_that) {
case MonitorConnectivityStarted():
return monitorStarted();case ConnectivityChanged():
return connectivityChanged(_that.isConnected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  monitorStarted,TResult? Function( bool isConnected)?  connectivityChanged,}) {final _that = this;
switch (_that) {
case MonitorConnectivityStarted() when monitorStarted != null:
return monitorStarted();case ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isConnected);case _:
  return null;

}
}

}

/// @nodoc


class MonitorConnectivityStarted implements ConnectivityEvent {
  const MonitorConnectivityStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonitorConnectivityStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityEvent.monitorStarted()';
}


}




/// @nodoc


class ConnectivityChanged implements ConnectivityEvent {
  const ConnectivityChanged(this.isConnected);
  

 final  bool isConnected;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectivityChangedCopyWith<ConnectivityChanged> get copyWith => _$ConnectivityChangedCopyWithImpl<ConnectivityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityChanged&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected);

@override
String toString() {
  return 'ConnectivityEvent.connectivityChanged(isConnected: $isConnected)';
}


}

/// @nodoc
abstract mixin class $ConnectivityChangedCopyWith<$Res> implements $ConnectivityEventCopyWith<$Res> {
  factory $ConnectivityChangedCopyWith(ConnectivityChanged value, $Res Function(ConnectivityChanged) _then) = _$ConnectivityChangedCopyWithImpl;
@useResult
$Res call({
 bool isConnected
});




}
/// @nodoc
class _$ConnectivityChangedCopyWithImpl<$Res>
    implements $ConnectivityChangedCopyWith<$Res> {
  _$ConnectivityChangedCopyWithImpl(this._self, this._then);

  final ConnectivityChanged _self;
  final $Res Function(ConnectivityChanged) _then;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isConnected = null,}) {
  return _then(ConnectivityChanged(
null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
