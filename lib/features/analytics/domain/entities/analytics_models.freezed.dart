// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyCompletionPoint {

 DateTime get date; double get completionRate;
/// Create a copy of DailyCompletionPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyCompletionPointCopyWith<DailyCompletionPoint> get copyWith => _$DailyCompletionPointCopyWithImpl<DailyCompletionPoint>(this as DailyCompletionPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCompletionPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate));
}


@override
int get hashCode => Object.hash(runtimeType,date,completionRate);

@override
String toString() {
  return 'DailyCompletionPoint(date: $date, completionRate: $completionRate)';
}


}

/// @nodoc
abstract mixin class $DailyCompletionPointCopyWith<$Res>  {
  factory $DailyCompletionPointCopyWith(DailyCompletionPoint value, $Res Function(DailyCompletionPoint) _then) = _$DailyCompletionPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double completionRate
});




}
/// @nodoc
class _$DailyCompletionPointCopyWithImpl<$Res>
    implements $DailyCompletionPointCopyWith<$Res> {
  _$DailyCompletionPointCopyWithImpl(this._self, this._then);

  final DailyCompletionPoint _self;
  final $Res Function(DailyCompletionPoint) _then;

/// Create a copy of DailyCompletionPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? completionRate = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyCompletionPoint].
extension DailyCompletionPointPatterns on DailyCompletionPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyCompletionPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyCompletionPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyCompletionPoint value)  $default,){
final _that = this;
switch (_that) {
case _DailyCompletionPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyCompletionPoint value)?  $default,){
final _that = this;
switch (_that) {
case _DailyCompletionPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double completionRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyCompletionPoint() when $default != null:
return $default(_that.date,_that.completionRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double completionRate)  $default,) {final _that = this;
switch (_that) {
case _DailyCompletionPoint():
return $default(_that.date,_that.completionRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double completionRate)?  $default,) {final _that = this;
switch (_that) {
case _DailyCompletionPoint() when $default != null:
return $default(_that.date,_that.completionRate);case _:
  return null;

}
}

}

/// @nodoc


class _DailyCompletionPoint implements DailyCompletionPoint {
  const _DailyCompletionPoint({required this.date, required this.completionRate});
  

@override final  DateTime date;
@override final  double completionRate;

/// Create a copy of DailyCompletionPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyCompletionPointCopyWith<_DailyCompletionPoint> get copyWith => __$DailyCompletionPointCopyWithImpl<_DailyCompletionPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyCompletionPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate));
}


@override
int get hashCode => Object.hash(runtimeType,date,completionRate);

@override
String toString() {
  return 'DailyCompletionPoint(date: $date, completionRate: $completionRate)';
}


}

/// @nodoc
abstract mixin class _$DailyCompletionPointCopyWith<$Res> implements $DailyCompletionPointCopyWith<$Res> {
  factory _$DailyCompletionPointCopyWith(_DailyCompletionPoint value, $Res Function(_DailyCompletionPoint) _then) = __$DailyCompletionPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double completionRate
});




}
/// @nodoc
class __$DailyCompletionPointCopyWithImpl<$Res>
    implements _$DailyCompletionPointCopyWith<$Res> {
  __$DailyCompletionPointCopyWithImpl(this._self, this._then);

  final _DailyCompletionPoint _self;
  final $Res Function(_DailyCompletionPoint) _then;

/// Create a copy of DailyCompletionPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? completionRate = null,}) {
  return _then(_DailyCompletionPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$StreakData {

 int get currentStreak; int get bestStreak;
/// Create a copy of StreakData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreakDataCopyWith<StreakData> get copyWith => _$StreakDataCopyWithImpl<StreakData>(this as StreakData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreakData&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak));
}


@override
int get hashCode => Object.hash(runtimeType,currentStreak,bestStreak);

@override
String toString() {
  return 'StreakData(currentStreak: $currentStreak, bestStreak: $bestStreak)';
}


}

/// @nodoc
abstract mixin class $StreakDataCopyWith<$Res>  {
  factory $StreakDataCopyWith(StreakData value, $Res Function(StreakData) _then) = _$StreakDataCopyWithImpl;
@useResult
$Res call({
 int currentStreak, int bestStreak
});




}
/// @nodoc
class _$StreakDataCopyWithImpl<$Res>
    implements $StreakDataCopyWith<$Res> {
  _$StreakDataCopyWithImpl(this._self, this._then);

  final StreakData _self;
  final $Res Function(StreakData) _then;

/// Create a copy of StreakData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStreak = null,Object? bestStreak = null,}) {
  return _then(_self.copyWith(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StreakData].
extension StreakDataPatterns on StreakData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreakData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreakData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreakData value)  $default,){
final _that = this;
switch (_that) {
case _StreakData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreakData value)?  $default,){
final _that = this;
switch (_that) {
case _StreakData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStreak,  int bestStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreakData() when $default != null:
return $default(_that.currentStreak,_that.bestStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStreak,  int bestStreak)  $default,) {final _that = this;
switch (_that) {
case _StreakData():
return $default(_that.currentStreak,_that.bestStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStreak,  int bestStreak)?  $default,) {final _that = this;
switch (_that) {
case _StreakData() when $default != null:
return $default(_that.currentStreak,_that.bestStreak);case _:
  return null;

}
}

}

/// @nodoc


class _StreakData implements StreakData {
  const _StreakData({required this.currentStreak, required this.bestStreak});
  

@override final  int currentStreak;
@override final  int bestStreak;

/// Create a copy of StreakData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreakDataCopyWith<_StreakData> get copyWith => __$StreakDataCopyWithImpl<_StreakData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreakData&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak));
}


@override
int get hashCode => Object.hash(runtimeType,currentStreak,bestStreak);

@override
String toString() {
  return 'StreakData(currentStreak: $currentStreak, bestStreak: $bestStreak)';
}


}

/// @nodoc
abstract mixin class _$StreakDataCopyWith<$Res> implements $StreakDataCopyWith<$Res> {
  factory _$StreakDataCopyWith(_StreakData value, $Res Function(_StreakData) _then) = __$StreakDataCopyWithImpl;
@override @useResult
$Res call({
 int currentStreak, int bestStreak
});




}
/// @nodoc
class __$StreakDataCopyWithImpl<$Res>
    implements _$StreakDataCopyWith<$Res> {
  __$StreakDataCopyWithImpl(this._self, this._then);

  final _StreakData _self;
  final $Res Function(_StreakData) _then;

/// Create a copy of StreakData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStreak = null,Object? bestStreak = null,}) {
  return _then(_StreakData(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GoalHitPoint {

 String get periodLabel; double get hitRate;
/// Create a copy of GoalHitPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalHitPointCopyWith<GoalHitPoint> get copyWith => _$GoalHitPointCopyWithImpl<GoalHitPoint>(this as GoalHitPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalHitPoint&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel)&&(identical(other.hitRate, hitRate) || other.hitRate == hitRate));
}


@override
int get hashCode => Object.hash(runtimeType,periodLabel,hitRate);

@override
String toString() {
  return 'GoalHitPoint(periodLabel: $periodLabel, hitRate: $hitRate)';
}


}

/// @nodoc
abstract mixin class $GoalHitPointCopyWith<$Res>  {
  factory $GoalHitPointCopyWith(GoalHitPoint value, $Res Function(GoalHitPoint) _then) = _$GoalHitPointCopyWithImpl;
@useResult
$Res call({
 String periodLabel, double hitRate
});




}
/// @nodoc
class _$GoalHitPointCopyWithImpl<$Res>
    implements $GoalHitPointCopyWith<$Res> {
  _$GoalHitPointCopyWithImpl(this._self, this._then);

  final GoalHitPoint _self;
  final $Res Function(GoalHitPoint) _then;

/// Create a copy of GoalHitPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? periodLabel = null,Object? hitRate = null,}) {
  return _then(_self.copyWith(
periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,hitRate: null == hitRate ? _self.hitRate : hitRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalHitPoint].
extension GoalHitPointPatterns on GoalHitPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalHitPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalHitPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalHitPoint value)  $default,){
final _that = this;
switch (_that) {
case _GoalHitPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalHitPoint value)?  $default,){
final _that = this;
switch (_that) {
case _GoalHitPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String periodLabel,  double hitRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalHitPoint() when $default != null:
return $default(_that.periodLabel,_that.hitRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String periodLabel,  double hitRate)  $default,) {final _that = this;
switch (_that) {
case _GoalHitPoint():
return $default(_that.periodLabel,_that.hitRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String periodLabel,  double hitRate)?  $default,) {final _that = this;
switch (_that) {
case _GoalHitPoint() when $default != null:
return $default(_that.periodLabel,_that.hitRate);case _:
  return null;

}
}

}

/// @nodoc


class _GoalHitPoint implements GoalHitPoint {
  const _GoalHitPoint({required this.periodLabel, required this.hitRate});
  

@override final  String periodLabel;
@override final  double hitRate;

/// Create a copy of GoalHitPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalHitPointCopyWith<_GoalHitPoint> get copyWith => __$GoalHitPointCopyWithImpl<_GoalHitPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalHitPoint&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel)&&(identical(other.hitRate, hitRate) || other.hitRate == hitRate));
}


@override
int get hashCode => Object.hash(runtimeType,periodLabel,hitRate);

@override
String toString() {
  return 'GoalHitPoint(periodLabel: $periodLabel, hitRate: $hitRate)';
}


}

/// @nodoc
abstract mixin class _$GoalHitPointCopyWith<$Res> implements $GoalHitPointCopyWith<$Res> {
  factory _$GoalHitPointCopyWith(_GoalHitPoint value, $Res Function(_GoalHitPoint) _then) = __$GoalHitPointCopyWithImpl;
@override @useResult
$Res call({
 String periodLabel, double hitRate
});




}
/// @nodoc
class __$GoalHitPointCopyWithImpl<$Res>
    implements _$GoalHitPointCopyWith<$Res> {
  __$GoalHitPointCopyWithImpl(this._self, this._then);

  final _GoalHitPoint _self;
  final $Res Function(_GoalHitPoint) _then;

/// Create a copy of GoalHitPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? periodLabel = null,Object? hitRate = null,}) {
  return _then(_GoalHitPoint(
periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,hitRate: null == hitRate ? _self.hitRate : hitRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$BreakdownItem {

 String get label; int get count; String get hexColor;
/// Create a copy of BreakdownItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BreakdownItemCopyWith<BreakdownItem> get copyWith => _$BreakdownItemCopyWithImpl<BreakdownItem>(this as BreakdownItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreakdownItem&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.hexColor, hexColor) || other.hexColor == hexColor));
}


@override
int get hashCode => Object.hash(runtimeType,label,count,hexColor);

@override
String toString() {
  return 'BreakdownItem(label: $label, count: $count, hexColor: $hexColor)';
}


}

/// @nodoc
abstract mixin class $BreakdownItemCopyWith<$Res>  {
  factory $BreakdownItemCopyWith(BreakdownItem value, $Res Function(BreakdownItem) _then) = _$BreakdownItemCopyWithImpl;
@useResult
$Res call({
 String label, int count, String hexColor
});




}
/// @nodoc
class _$BreakdownItemCopyWithImpl<$Res>
    implements $BreakdownItemCopyWith<$Res> {
  _$BreakdownItemCopyWithImpl(this._self, this._then);

  final BreakdownItem _self;
  final $Res Function(BreakdownItem) _then;

/// Create a copy of BreakdownItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,Object? hexColor = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hexColor: null == hexColor ? _self.hexColor : hexColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BreakdownItem].
extension BreakdownItemPatterns on BreakdownItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BreakdownItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BreakdownItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BreakdownItem value)  $default,){
final _that = this;
switch (_that) {
case _BreakdownItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BreakdownItem value)?  $default,){
final _that = this;
switch (_that) {
case _BreakdownItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int count,  String hexColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BreakdownItem() when $default != null:
return $default(_that.label,_that.count,_that.hexColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int count,  String hexColor)  $default,) {final _that = this;
switch (_that) {
case _BreakdownItem():
return $default(_that.label,_that.count,_that.hexColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int count,  String hexColor)?  $default,) {final _that = this;
switch (_that) {
case _BreakdownItem() when $default != null:
return $default(_that.label,_that.count,_that.hexColor);case _:
  return null;

}
}

}

/// @nodoc


class _BreakdownItem implements BreakdownItem {
  const _BreakdownItem({required this.label, required this.count, required this.hexColor});
  

@override final  String label;
@override final  int count;
@override final  String hexColor;

/// Create a copy of BreakdownItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BreakdownItemCopyWith<_BreakdownItem> get copyWith => __$BreakdownItemCopyWithImpl<_BreakdownItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BreakdownItem&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.hexColor, hexColor) || other.hexColor == hexColor));
}


@override
int get hashCode => Object.hash(runtimeType,label,count,hexColor);

@override
String toString() {
  return 'BreakdownItem(label: $label, count: $count, hexColor: $hexColor)';
}


}

/// @nodoc
abstract mixin class _$BreakdownItemCopyWith<$Res> implements $BreakdownItemCopyWith<$Res> {
  factory _$BreakdownItemCopyWith(_BreakdownItem value, $Res Function(_BreakdownItem) _then) = __$BreakdownItemCopyWithImpl;
@override @useResult
$Res call({
 String label, int count, String hexColor
});




}
/// @nodoc
class __$BreakdownItemCopyWithImpl<$Res>
    implements _$BreakdownItemCopyWith<$Res> {
  __$BreakdownItemCopyWithImpl(this._self, this._then);

  final _BreakdownItem _self;
  final $Res Function(_BreakdownItem) _then;

/// Create a copy of BreakdownItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,Object? hexColor = null,}) {
  return _then(_BreakdownItem(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hexColor: null == hexColor ? _self.hexColor : hexColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DayRatingPoint {

 DateTime get date; int get rating;
/// Create a copy of DayRatingPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayRatingPointCopyWith<DayRatingPoint> get copyWith => _$DayRatingPointCopyWithImpl<DayRatingPoint>(this as DayRatingPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayRatingPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,date,rating);

@override
String toString() {
  return 'DayRatingPoint(date: $date, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $DayRatingPointCopyWith<$Res>  {
  factory $DayRatingPointCopyWith(DayRatingPoint value, $Res Function(DayRatingPoint) _then) = _$DayRatingPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, int rating
});




}
/// @nodoc
class _$DayRatingPointCopyWithImpl<$Res>
    implements $DayRatingPointCopyWith<$Res> {
  _$DayRatingPointCopyWithImpl(this._self, this._then);

  final DayRatingPoint _self;
  final $Res Function(DayRatingPoint) _then;

/// Create a copy of DayRatingPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? rating = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DayRatingPoint].
extension DayRatingPointPatterns on DayRatingPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayRatingPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayRatingPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayRatingPoint value)  $default,){
final _that = this;
switch (_that) {
case _DayRatingPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayRatingPoint value)?  $default,){
final _that = this;
switch (_that) {
case _DayRatingPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayRatingPoint() when $default != null:
return $default(_that.date,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int rating)  $default,) {final _that = this;
switch (_that) {
case _DayRatingPoint():
return $default(_that.date,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int rating)?  $default,) {final _that = this;
switch (_that) {
case _DayRatingPoint() when $default != null:
return $default(_that.date,_that.rating);case _:
  return null;

}
}

}

/// @nodoc


class _DayRatingPoint implements DayRatingPoint {
  const _DayRatingPoint({required this.date, required this.rating});
  

@override final  DateTime date;
@override final  int rating;

/// Create a copy of DayRatingPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayRatingPointCopyWith<_DayRatingPoint> get copyWith => __$DayRatingPointCopyWithImpl<_DayRatingPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayRatingPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,date,rating);

@override
String toString() {
  return 'DayRatingPoint(date: $date, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$DayRatingPointCopyWith<$Res> implements $DayRatingPointCopyWith<$Res> {
  factory _$DayRatingPointCopyWith(_DayRatingPoint value, $Res Function(_DayRatingPoint) _then) = __$DayRatingPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int rating
});




}
/// @nodoc
class __$DayRatingPointCopyWithImpl<$Res>
    implements _$DayRatingPointCopyWith<$Res> {
  __$DayRatingPointCopyWithImpl(this._self, this._then);

  final _DayRatingPoint _self;
  final $Res Function(_DayRatingPoint) _then;

/// Create a copy of DayRatingPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? rating = null,}) {
  return _then(_DayRatingPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
