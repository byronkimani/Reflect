// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurrence_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecurrenceRule {

 String get id; RecurrenceFrequency get frequency; int get intervalVal; List<int>? get daysOfWeek; int? get dayOfMonth; RecurrenceEndType get endType; DateTime? get endDate; int? get endCount; int get occurrenceCount;
/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurrenceRuleCopyWith<RecurrenceRule> get copyWith => _$RecurrenceRuleCopyWithImpl<RecurrenceRule>(this as RecurrenceRule, _$identity);

  /// Serializes this RecurrenceRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurrenceRule&&(identical(other.id, id) || other.id == id)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.intervalVal, intervalVal) || other.intervalVal == intervalVal)&&const DeepCollectionEquality().equals(other.daysOfWeek, daysOfWeek)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.endType, endType) || other.endType == endType)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.endCount, endCount) || other.endCount == endCount)&&(identical(other.occurrenceCount, occurrenceCount) || other.occurrenceCount == occurrenceCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,frequency,intervalVal,const DeepCollectionEquality().hash(daysOfWeek),dayOfMonth,endType,endDate,endCount,occurrenceCount);

@override
String toString() {
  return 'RecurrenceRule(id: $id, frequency: $frequency, intervalVal: $intervalVal, daysOfWeek: $daysOfWeek, dayOfMonth: $dayOfMonth, endType: $endType, endDate: $endDate, endCount: $endCount, occurrenceCount: $occurrenceCount)';
}


}

/// @nodoc
abstract mixin class $RecurrenceRuleCopyWith<$Res>  {
  factory $RecurrenceRuleCopyWith(RecurrenceRule value, $Res Function(RecurrenceRule) _then) = _$RecurrenceRuleCopyWithImpl;
@useResult
$Res call({
 String id, RecurrenceFrequency frequency, int intervalVal, List<int>? daysOfWeek, int? dayOfMonth, RecurrenceEndType endType, DateTime? endDate, int? endCount, int occurrenceCount
});




}
/// @nodoc
class _$RecurrenceRuleCopyWithImpl<$Res>
    implements $RecurrenceRuleCopyWith<$Res> {
  _$RecurrenceRuleCopyWithImpl(this._self, this._then);

  final RecurrenceRule _self;
  final $Res Function(RecurrenceRule) _then;

/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? frequency = null,Object? intervalVal = null,Object? daysOfWeek = freezed,Object? dayOfMonth = freezed,Object? endType = null,Object? endDate = freezed,Object? endCount = freezed,Object? occurrenceCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,intervalVal: null == intervalVal ? _self.intervalVal : intervalVal // ignore: cast_nullable_to_non_nullable
as int,daysOfWeek: freezed == daysOfWeek ? _self.daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>?,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,endType: null == endType ? _self.endType : endType // ignore: cast_nullable_to_non_nullable
as RecurrenceEndType,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endCount: freezed == endCount ? _self.endCount : endCount // ignore: cast_nullable_to_non_nullable
as int?,occurrenceCount: null == occurrenceCount ? _self.occurrenceCount : occurrenceCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurrenceRule].
extension RecurrenceRulePatterns on RecurrenceRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurrenceRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurrenceRule value)  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurrenceRule value)?  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  RecurrenceFrequency frequency,  int intervalVal,  List<int>? daysOfWeek,  int? dayOfMonth,  RecurrenceEndType endType,  DateTime? endDate,  int? endCount,  int occurrenceCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
return $default(_that.id,_that.frequency,_that.intervalVal,_that.daysOfWeek,_that.dayOfMonth,_that.endType,_that.endDate,_that.endCount,_that.occurrenceCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  RecurrenceFrequency frequency,  int intervalVal,  List<int>? daysOfWeek,  int? dayOfMonth,  RecurrenceEndType endType,  DateTime? endDate,  int? endCount,  int occurrenceCount)  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRule():
return $default(_that.id,_that.frequency,_that.intervalVal,_that.daysOfWeek,_that.dayOfMonth,_that.endType,_that.endDate,_that.endCount,_that.occurrenceCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  RecurrenceFrequency frequency,  int intervalVal,  List<int>? daysOfWeek,  int? dayOfMonth,  RecurrenceEndType endType,  DateTime? endDate,  int? endCount,  int occurrenceCount)?  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRule() when $default != null:
return $default(_that.id,_that.frequency,_that.intervalVal,_that.daysOfWeek,_that.dayOfMonth,_that.endType,_that.endDate,_that.endCount,_that.occurrenceCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurrenceRule implements RecurrenceRule {
  const _RecurrenceRule({required this.id, required this.frequency, this.intervalVal = 1, final  List<int>? daysOfWeek, this.dayOfMonth, this.endType = RecurrenceEndType.NEVER, this.endDate, this.endCount, this.occurrenceCount = 0}): _daysOfWeek = daysOfWeek;
  factory _RecurrenceRule.fromJson(Map<String, dynamic> json) => _$RecurrenceRuleFromJson(json);

@override final  String id;
@override final  RecurrenceFrequency frequency;
@override@JsonKey() final  int intervalVal;
 final  List<int>? _daysOfWeek;
@override List<int>? get daysOfWeek {
  final value = _daysOfWeek;
  if (value == null) return null;
  if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? dayOfMonth;
@override@JsonKey() final  RecurrenceEndType endType;
@override final  DateTime? endDate;
@override final  int? endCount;
@override@JsonKey() final  int occurrenceCount;

/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurrenceRuleCopyWith<_RecurrenceRule> get copyWith => __$RecurrenceRuleCopyWithImpl<_RecurrenceRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurrenceRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurrenceRule&&(identical(other.id, id) || other.id == id)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.intervalVal, intervalVal) || other.intervalVal == intervalVal)&&const DeepCollectionEquality().equals(other._daysOfWeek, _daysOfWeek)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.endType, endType) || other.endType == endType)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.endCount, endCount) || other.endCount == endCount)&&(identical(other.occurrenceCount, occurrenceCount) || other.occurrenceCount == occurrenceCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,frequency,intervalVal,const DeepCollectionEquality().hash(_daysOfWeek),dayOfMonth,endType,endDate,endCount,occurrenceCount);

@override
String toString() {
  return 'RecurrenceRule(id: $id, frequency: $frequency, intervalVal: $intervalVal, daysOfWeek: $daysOfWeek, dayOfMonth: $dayOfMonth, endType: $endType, endDate: $endDate, endCount: $endCount, occurrenceCount: $occurrenceCount)';
}


}

/// @nodoc
abstract mixin class _$RecurrenceRuleCopyWith<$Res> implements $RecurrenceRuleCopyWith<$Res> {
  factory _$RecurrenceRuleCopyWith(_RecurrenceRule value, $Res Function(_RecurrenceRule) _then) = __$RecurrenceRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, RecurrenceFrequency frequency, int intervalVal, List<int>? daysOfWeek, int? dayOfMonth, RecurrenceEndType endType, DateTime? endDate, int? endCount, int occurrenceCount
});




}
/// @nodoc
class __$RecurrenceRuleCopyWithImpl<$Res>
    implements _$RecurrenceRuleCopyWith<$Res> {
  __$RecurrenceRuleCopyWithImpl(this._self, this._then);

  final _RecurrenceRule _self;
  final $Res Function(_RecurrenceRule) _then;

/// Create a copy of RecurrenceRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? frequency = null,Object? intervalVal = null,Object? daysOfWeek = freezed,Object? dayOfMonth = freezed,Object? endType = null,Object? endDate = freezed,Object? endCount = freezed,Object? occurrenceCount = null,}) {
  return _then(_RecurrenceRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,intervalVal: null == intervalVal ? _self.intervalVal : intervalVal // ignore: cast_nullable_to_non_nullable
as int,daysOfWeek: freezed == daysOfWeek ? _self._daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>?,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,endType: null == endType ? _self.endType : endType // ignore: cast_nullable_to_non_nullable
as RecurrenceEndType,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endCount: freezed == endCount ? _self.endCount : endCount // ignore: cast_nullable_to_non_nullable
as int?,occurrenceCount: null == occurrenceCount ? _self.occurrenceCount : occurrenceCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
