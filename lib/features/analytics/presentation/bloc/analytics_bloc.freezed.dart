// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalyticsEvent {

 DateRange get range;
/// Create a copy of AnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsEventCopyWith<AnalyticsEvent> get copyWith => _$AnalyticsEventCopyWithImpl<AnalyticsEvent>(this as AnalyticsEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsEvent&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,range);

@override
String toString() {
  return 'AnalyticsEvent(range: $range)';
}


}

/// @nodoc
abstract mixin class $AnalyticsEventCopyWith<$Res>  {
  factory $AnalyticsEventCopyWith(AnalyticsEvent value, $Res Function(AnalyticsEvent) _then) = _$AnalyticsEventCopyWithImpl;
@useResult
$Res call({
 DateRange range
});




}
/// @nodoc
class _$AnalyticsEventCopyWithImpl<$Res>
    implements $AnalyticsEventCopyWith<$Res> {
  _$AnalyticsEventCopyWithImpl(this._self, this._then);

  final AnalyticsEvent _self;
  final $Res Function(AnalyticsEvent) _then;

/// Create a copy of AnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,}) {
  return _then(_self.copyWith(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as DateRange,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyticsEvent].
extension AnalyticsEventPatterns on AnalyticsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadAnalytics value)?  load,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadAnalytics() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadAnalytics value)  load,}){
final _that = this;
switch (_that) {
case LoadAnalytics():
return load(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadAnalytics value)?  load,}){
final _that = this;
switch (_that) {
case LoadAnalytics() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateRange range)?  load,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadAnalytics() when load != null:
return load(_that.range);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateRange range)  load,}) {final _that = this;
switch (_that) {
case LoadAnalytics():
return load(_that.range);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateRange range)?  load,}) {final _that = this;
switch (_that) {
case LoadAnalytics() when load != null:
return load(_that.range);case _:
  return null;

}
}

}

/// @nodoc


class LoadAnalytics implements AnalyticsEvent {
  const LoadAnalytics(this.range);
  

@override final  DateRange range;

/// Create a copy of AnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadAnalyticsCopyWith<LoadAnalytics> get copyWith => _$LoadAnalyticsCopyWithImpl<LoadAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadAnalytics&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,range);

@override
String toString() {
  return 'AnalyticsEvent.load(range: $range)';
}


}

/// @nodoc
abstract mixin class $LoadAnalyticsCopyWith<$Res> implements $AnalyticsEventCopyWith<$Res> {
  factory $LoadAnalyticsCopyWith(LoadAnalytics value, $Res Function(LoadAnalytics) _then) = _$LoadAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 DateRange range
});




}
/// @nodoc
class _$LoadAnalyticsCopyWithImpl<$Res>
    implements $LoadAnalyticsCopyWith<$Res> {
  _$LoadAnalyticsCopyWithImpl(this._self, this._then);

  final LoadAnalytics _self;
  final $Res Function(LoadAnalytics) _then;

/// Create a copy of AnalyticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,}) {
  return _then(LoadAnalytics(
null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as DateRange,
  ));
}


}

/// @nodoc
mixin _$AnalyticsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnalyticsState()';
}


}

/// @nodoc
class $AnalyticsStateCopyWith<$Res>  {
$AnalyticsStateCopyWith(AnalyticsState _, $Res Function(AnalyticsState) __);
}


/// Adds pattern-matching-related methods to [AnalyticsState].
extension AnalyticsStatePatterns on AnalyticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DateRange activeRange,  List<DailyCompletionPoint> dailyCompletion,  StreakData streaks,  List<BreakdownItem> tagBreakdown,  List<BreakdownItem> priorityBreakdown,  List<DayRatingPoint> ratingTrend)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.activeRange,_that.dailyCompletion,_that.streaks,_that.tagBreakdown,_that.priorityBreakdown,_that.ratingTrend);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DateRange activeRange,  List<DailyCompletionPoint> dailyCompletion,  StreakData streaks,  List<BreakdownItem> tagBreakdown,  List<BreakdownItem> priorityBreakdown,  List<DayRatingPoint> ratingTrend)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.activeRange,_that.dailyCompletion,_that.streaks,_that.tagBreakdown,_that.priorityBreakdown,_that.ratingTrend);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DateRange activeRange,  List<DailyCompletionPoint> dailyCompletion,  StreakData streaks,  List<BreakdownItem> tagBreakdown,  List<BreakdownItem> priorityBreakdown,  List<DayRatingPoint> ratingTrend)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.activeRange,_that.dailyCompletion,_that.streaks,_that.tagBreakdown,_that.priorityBreakdown,_that.ratingTrend);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AnalyticsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnalyticsState.initial()';
}


}




/// @nodoc


class _Loading implements AnalyticsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnalyticsState.loading()';
}


}




/// @nodoc


class _Loaded implements AnalyticsState {
  const _Loaded({required this.activeRange, required final  List<DailyCompletionPoint> dailyCompletion, required this.streaks, required final  List<BreakdownItem> tagBreakdown, required final  List<BreakdownItem> priorityBreakdown, required final  List<DayRatingPoint> ratingTrend}): _dailyCompletion = dailyCompletion,_tagBreakdown = tagBreakdown,_priorityBreakdown = priorityBreakdown,_ratingTrend = ratingTrend;
  

 final  DateRange activeRange;
 final  List<DailyCompletionPoint> _dailyCompletion;
 List<DailyCompletionPoint> get dailyCompletion {
  if (_dailyCompletion is EqualUnmodifiableListView) return _dailyCompletion;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyCompletion);
}

 final  StreakData streaks;
 final  List<BreakdownItem> _tagBreakdown;
 List<BreakdownItem> get tagBreakdown {
  if (_tagBreakdown is EqualUnmodifiableListView) return _tagBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagBreakdown);
}

 final  List<BreakdownItem> _priorityBreakdown;
 List<BreakdownItem> get priorityBreakdown {
  if (_priorityBreakdown is EqualUnmodifiableListView) return _priorityBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_priorityBreakdown);
}

 final  List<DayRatingPoint> _ratingTrend;
 List<DayRatingPoint> get ratingTrend {
  if (_ratingTrend is EqualUnmodifiableListView) return _ratingTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ratingTrend);
}


/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.activeRange, activeRange) || other.activeRange == activeRange)&&const DeepCollectionEquality().equals(other._dailyCompletion, _dailyCompletion)&&(identical(other.streaks, streaks) || other.streaks == streaks)&&const DeepCollectionEquality().equals(other._tagBreakdown, _tagBreakdown)&&const DeepCollectionEquality().equals(other._priorityBreakdown, _priorityBreakdown)&&const DeepCollectionEquality().equals(other._ratingTrend, _ratingTrend));
}


@override
int get hashCode => Object.hash(runtimeType,activeRange,const DeepCollectionEquality().hash(_dailyCompletion),streaks,const DeepCollectionEquality().hash(_tagBreakdown),const DeepCollectionEquality().hash(_priorityBreakdown),const DeepCollectionEquality().hash(_ratingTrend));

@override
String toString() {
  return 'AnalyticsState.loaded(activeRange: $activeRange, dailyCompletion: $dailyCompletion, streaks: $streaks, tagBreakdown: $tagBreakdown, priorityBreakdown: $priorityBreakdown, ratingTrend: $ratingTrend)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AnalyticsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 DateRange activeRange, List<DailyCompletionPoint> dailyCompletion, StreakData streaks, List<BreakdownItem> tagBreakdown, List<BreakdownItem> priorityBreakdown, List<DayRatingPoint> ratingTrend
});


$StreakDataCopyWith<$Res> get streaks;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activeRange = null,Object? dailyCompletion = null,Object? streaks = null,Object? tagBreakdown = null,Object? priorityBreakdown = null,Object? ratingTrend = null,}) {
  return _then(_Loaded(
activeRange: null == activeRange ? _self.activeRange : activeRange // ignore: cast_nullable_to_non_nullable
as DateRange,dailyCompletion: null == dailyCompletion ? _self._dailyCompletion : dailyCompletion // ignore: cast_nullable_to_non_nullable
as List<DailyCompletionPoint>,streaks: null == streaks ? _self.streaks : streaks // ignore: cast_nullable_to_non_nullable
as StreakData,tagBreakdown: null == tagBreakdown ? _self._tagBreakdown : tagBreakdown // ignore: cast_nullable_to_non_nullable
as List<BreakdownItem>,priorityBreakdown: null == priorityBreakdown ? _self._priorityBreakdown : priorityBreakdown // ignore: cast_nullable_to_non_nullable
as List<BreakdownItem>,ratingTrend: null == ratingTrend ? _self._ratingTrend : ratingTrend // ignore: cast_nullable_to_non_nullable
as List<DayRatingPoint>,
  ));
}

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StreakDataCopyWith<$Res> get streaks {
  
  return $StreakDataCopyWith<$Res>(_self.streaks, (value) {
    return _then(_self.copyWith(streaks: value));
  });
}
}

/// @nodoc


class _Error implements AnalyticsState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AnalyticsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AnalyticsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AnalyticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
