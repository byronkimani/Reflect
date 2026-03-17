// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyReviewState {

 int get dayRating; String get wentWell; String get couldBeBetter; String get gratitude1; String get gratitude2; String get gratitude3; double get taskCompletionRate; bool get isSubmitting; bool get isSuccess; String? get error;
/// Create a copy of DailyReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReviewStateCopyWith<DailyReviewState> get copyWith => _$DailyReviewStateCopyWithImpl<DailyReviewState>(this as DailyReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReviewState&&(identical(other.dayRating, dayRating) || other.dayRating == dayRating)&&(identical(other.wentWell, wentWell) || other.wentWell == wentWell)&&(identical(other.couldBeBetter, couldBeBetter) || other.couldBeBetter == couldBeBetter)&&(identical(other.gratitude1, gratitude1) || other.gratitude1 == gratitude1)&&(identical(other.gratitude2, gratitude2) || other.gratitude2 == gratitude2)&&(identical(other.gratitude3, gratitude3) || other.gratitude3 == gratitude3)&&(identical(other.taskCompletionRate, taskCompletionRate) || other.taskCompletionRate == taskCompletionRate)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,dayRating,wentWell,couldBeBetter,gratitude1,gratitude2,gratitude3,taskCompletionRate,isSubmitting,isSuccess,error);

@override
String toString() {
  return 'DailyReviewState(dayRating: $dayRating, wentWell: $wentWell, couldBeBetter: $couldBeBetter, gratitude1: $gratitude1, gratitude2: $gratitude2, gratitude3: $gratitude3, taskCompletionRate: $taskCompletionRate, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class $DailyReviewStateCopyWith<$Res>  {
  factory $DailyReviewStateCopyWith(DailyReviewState value, $Res Function(DailyReviewState) _then) = _$DailyReviewStateCopyWithImpl;
@useResult
$Res call({
 int dayRating, String wentWell, String couldBeBetter, String gratitude1, String gratitude2, String gratitude3, double taskCompletionRate, bool isSubmitting, bool isSuccess, String? error
});




}
/// @nodoc
class _$DailyReviewStateCopyWithImpl<$Res>
    implements $DailyReviewStateCopyWith<$Res> {
  _$DailyReviewStateCopyWithImpl(this._self, this._then);

  final DailyReviewState _self;
  final $Res Function(DailyReviewState) _then;

/// Create a copy of DailyReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayRating = null,Object? wentWell = null,Object? couldBeBetter = null,Object? gratitude1 = null,Object? gratitude2 = null,Object? gratitude3 = null,Object? taskCompletionRate = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
dayRating: null == dayRating ? _self.dayRating : dayRating // ignore: cast_nullable_to_non_nullable
as int,wentWell: null == wentWell ? _self.wentWell : wentWell // ignore: cast_nullable_to_non_nullable
as String,couldBeBetter: null == couldBeBetter ? _self.couldBeBetter : couldBeBetter // ignore: cast_nullable_to_non_nullable
as String,gratitude1: null == gratitude1 ? _self.gratitude1 : gratitude1 // ignore: cast_nullable_to_non_nullable
as String,gratitude2: null == gratitude2 ? _self.gratitude2 : gratitude2 // ignore: cast_nullable_to_non_nullable
as String,gratitude3: null == gratitude3 ? _self.gratitude3 : gratitude3 // ignore: cast_nullable_to_non_nullable
as String,taskCompletionRate: null == taskCompletionRate ? _self.taskCompletionRate : taskCompletionRate // ignore: cast_nullable_to_non_nullable
as double,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReviewState].
extension DailyReviewStatePatterns on DailyReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReviewState value)  $default,){
final _that = this;
switch (_that) {
case _DailyReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayRating,  String wentWell,  String couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  bool isSubmitting,  bool isSuccess,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReviewState() when $default != null:
return $default(_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.isSubmitting,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayRating,  String wentWell,  String couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  bool isSubmitting,  bool isSuccess,  String? error)  $default,) {final _that = this;
switch (_that) {
case _DailyReviewState():
return $default(_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.isSubmitting,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayRating,  String wentWell,  String couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  bool isSubmitting,  bool isSuccess,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _DailyReviewState() when $default != null:
return $default(_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.isSubmitting,_that.isSuccess,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DailyReviewState extends DailyReviewState {
  const _DailyReviewState({this.dayRating = 0, this.wentWell = '', this.couldBeBetter = '', this.gratitude1 = '', this.gratitude2 = '', this.gratitude3 = '', this.taskCompletionRate = 0.0, this.isSubmitting = false, this.isSuccess = false, this.error}): super._();
  

@override@JsonKey() final  int dayRating;
@override@JsonKey() final  String wentWell;
@override@JsonKey() final  String couldBeBetter;
@override@JsonKey() final  String gratitude1;
@override@JsonKey() final  String gratitude2;
@override@JsonKey() final  String gratitude3;
@override@JsonKey() final  double taskCompletionRate;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;

/// Create a copy of DailyReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReviewStateCopyWith<_DailyReviewState> get copyWith => __$DailyReviewStateCopyWithImpl<_DailyReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReviewState&&(identical(other.dayRating, dayRating) || other.dayRating == dayRating)&&(identical(other.wentWell, wentWell) || other.wentWell == wentWell)&&(identical(other.couldBeBetter, couldBeBetter) || other.couldBeBetter == couldBeBetter)&&(identical(other.gratitude1, gratitude1) || other.gratitude1 == gratitude1)&&(identical(other.gratitude2, gratitude2) || other.gratitude2 == gratitude2)&&(identical(other.gratitude3, gratitude3) || other.gratitude3 == gratitude3)&&(identical(other.taskCompletionRate, taskCompletionRate) || other.taskCompletionRate == taskCompletionRate)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,dayRating,wentWell,couldBeBetter,gratitude1,gratitude2,gratitude3,taskCompletionRate,isSubmitting,isSuccess,error);

@override
String toString() {
  return 'DailyReviewState(dayRating: $dayRating, wentWell: $wentWell, couldBeBetter: $couldBeBetter, gratitude1: $gratitude1, gratitude2: $gratitude2, gratitude3: $gratitude3, taskCompletionRate: $taskCompletionRate, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DailyReviewStateCopyWith<$Res> implements $DailyReviewStateCopyWith<$Res> {
  factory _$DailyReviewStateCopyWith(_DailyReviewState value, $Res Function(_DailyReviewState) _then) = __$DailyReviewStateCopyWithImpl;
@override @useResult
$Res call({
 int dayRating, String wentWell, String couldBeBetter, String gratitude1, String gratitude2, String gratitude3, double taskCompletionRate, bool isSubmitting, bool isSuccess, String? error
});




}
/// @nodoc
class __$DailyReviewStateCopyWithImpl<$Res>
    implements _$DailyReviewStateCopyWith<$Res> {
  __$DailyReviewStateCopyWithImpl(this._self, this._then);

  final _DailyReviewState _self;
  final $Res Function(_DailyReviewState) _then;

/// Create a copy of DailyReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayRating = null,Object? wentWell = null,Object? couldBeBetter = null,Object? gratitude1 = null,Object? gratitude2 = null,Object? gratitude3 = null,Object? taskCompletionRate = null,Object? isSubmitting = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_DailyReviewState(
dayRating: null == dayRating ? _self.dayRating : dayRating // ignore: cast_nullable_to_non_nullable
as int,wentWell: null == wentWell ? _self.wentWell : wentWell // ignore: cast_nullable_to_non_nullable
as String,couldBeBetter: null == couldBeBetter ? _self.couldBeBetter : couldBeBetter // ignore: cast_nullable_to_non_nullable
as String,gratitude1: null == gratitude1 ? _self.gratitude1 : gratitude1 // ignore: cast_nullable_to_non_nullable
as String,gratitude2: null == gratitude2 ? _self.gratitude2 : gratitude2 // ignore: cast_nullable_to_non_nullable
as String,gratitude3: null == gratitude3 ? _self.gratitude3 : gratitude3 // ignore: cast_nullable_to_non_nullable
as String,taskCompletionRate: null == taskCompletionRate ? _self.taskCompletionRate : taskCompletionRate // ignore: cast_nullable_to_non_nullable
as double,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
