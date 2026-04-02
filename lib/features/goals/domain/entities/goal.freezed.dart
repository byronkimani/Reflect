// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Goal {

 String get id; String get title; String? get description; String? get categoryId; String? get kpiDescription; String? get startValue; String? get targetValue; TaskPriority? get priority; TaskPriority? get urgency; String? get why; DateTime? get startDate; DateTime? get targetDate; CheckInFrequency? get checkInFrequency; bool? get isMeasurable; GoalTimeHorizon get timeHorizon; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.kpiDescription, kpiDescription) || other.kpiDescription == kpiDescription)&&(identical(other.startValue, startValue) || other.startValue == startValue)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.why, why) || other.why == why)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.checkInFrequency, checkInFrequency) || other.checkInFrequency == checkInFrequency)&&(identical(other.isMeasurable, isMeasurable) || other.isMeasurable == isMeasurable)&&(identical(other.timeHorizon, timeHorizon) || other.timeHorizon == timeHorizon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,categoryId,kpiDescription,startValue,targetValue,priority,urgency,why,startDate,targetDate,checkInFrequency,isMeasurable,timeHorizon,createdAt,updatedAt);

@override
String toString() {
  return 'Goal(id: $id, title: $title, description: $description, categoryId: $categoryId, kpiDescription: $kpiDescription, startValue: $startValue, targetValue: $targetValue, priority: $priority, urgency: $urgency, why: $why, startDate: $startDate, targetDate: $targetDate, checkInFrequency: $checkInFrequency, isMeasurable: $isMeasurable, timeHorizon: $timeHorizon, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? categoryId, String? kpiDescription, String? startValue, String? targetValue, TaskPriority? priority, TaskPriority? urgency, String? why, DateTime? startDate, DateTime? targetDate, CheckInFrequency? checkInFrequency, bool? isMeasurable, GoalTimeHorizon timeHorizon, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? categoryId = freezed,Object? kpiDescription = freezed,Object? startValue = freezed,Object? targetValue = freezed,Object? priority = freezed,Object? urgency = freezed,Object? why = freezed,Object? startDate = freezed,Object? targetDate = freezed,Object? checkInFrequency = freezed,Object? isMeasurable = freezed,Object? timeHorizon = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,kpiDescription: freezed == kpiDescription ? _self.kpiDescription : kpiDescription // ignore: cast_nullable_to_non_nullable
as String?,startValue: freezed == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as String?,targetValue: freezed == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,urgency: freezed == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as TaskPriority?,why: freezed == why ? _self.why : why // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInFrequency: freezed == checkInFrequency ? _self.checkInFrequency : checkInFrequency // ignore: cast_nullable_to_non_nullable
as CheckInFrequency?,isMeasurable: freezed == isMeasurable ? _self.isMeasurable : isMeasurable // ignore: cast_nullable_to_non_nullable
as bool?,timeHorizon: null == timeHorizon ? _self.timeHorizon : timeHorizon // ignore: cast_nullable_to_non_nullable
as GoalTimeHorizon,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? categoryId,  String? kpiDescription,  String? startValue,  String? targetValue,  TaskPriority? priority,  TaskPriority? urgency,  String? why,  DateTime? startDate,  DateTime? targetDate,  CheckInFrequency? checkInFrequency,  bool? isMeasurable,  GoalTimeHorizon timeHorizon,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.kpiDescription,_that.startValue,_that.targetValue,_that.priority,_that.urgency,_that.why,_that.startDate,_that.targetDate,_that.checkInFrequency,_that.isMeasurable,_that.timeHorizon,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? categoryId,  String? kpiDescription,  String? startValue,  String? targetValue,  TaskPriority? priority,  TaskPriority? urgency,  String? why,  DateTime? startDate,  DateTime? targetDate,  CheckInFrequency? checkInFrequency,  bool? isMeasurable,  GoalTimeHorizon timeHorizon,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.kpiDescription,_that.startValue,_that.targetValue,_that.priority,_that.urgency,_that.why,_that.startDate,_that.targetDate,_that.checkInFrequency,_that.isMeasurable,_that.timeHorizon,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? categoryId,  String? kpiDescription,  String? startValue,  String? targetValue,  TaskPriority? priority,  TaskPriority? urgency,  String? why,  DateTime? startDate,  DateTime? targetDate,  CheckInFrequency? checkInFrequency,  bool? isMeasurable,  GoalTimeHorizon timeHorizon,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.kpiDescription,_that.startValue,_that.targetValue,_that.priority,_that.urgency,_that.why,_that.startDate,_that.targetDate,_that.checkInFrequency,_that.isMeasurable,_that.timeHorizon,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Goal extends Goal {
  const _Goal({required this.id, required this.title, this.description, this.categoryId, this.kpiDescription, this.startValue, this.targetValue, this.priority, this.urgency, this.why, this.startDate, this.targetDate, this.checkInFrequency, this.isMeasurable, required this.timeHorizon, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? categoryId;
@override final  String? kpiDescription;
@override final  String? startValue;
@override final  String? targetValue;
@override final  TaskPriority? priority;
@override final  TaskPriority? urgency;
@override final  String? why;
@override final  DateTime? startDate;
@override final  DateTime? targetDate;
@override final  CheckInFrequency? checkInFrequency;
@override final  bool? isMeasurable;
@override final  GoalTimeHorizon timeHorizon;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.kpiDescription, kpiDescription) || other.kpiDescription == kpiDescription)&&(identical(other.startValue, startValue) || other.startValue == startValue)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.why, why) || other.why == why)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.checkInFrequency, checkInFrequency) || other.checkInFrequency == checkInFrequency)&&(identical(other.isMeasurable, isMeasurable) || other.isMeasurable == isMeasurable)&&(identical(other.timeHorizon, timeHorizon) || other.timeHorizon == timeHorizon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,categoryId,kpiDescription,startValue,targetValue,priority,urgency,why,startDate,targetDate,checkInFrequency,isMeasurable,timeHorizon,createdAt,updatedAt);

@override
String toString() {
  return 'Goal(id: $id, title: $title, description: $description, categoryId: $categoryId, kpiDescription: $kpiDescription, startValue: $startValue, targetValue: $targetValue, priority: $priority, urgency: $urgency, why: $why, startDate: $startDate, targetDate: $targetDate, checkInFrequency: $checkInFrequency, isMeasurable: $isMeasurable, timeHorizon: $timeHorizon, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? categoryId, String? kpiDescription, String? startValue, String? targetValue, TaskPriority? priority, TaskPriority? urgency, String? why, DateTime? startDate, DateTime? targetDate, CheckInFrequency? checkInFrequency, bool? isMeasurable, GoalTimeHorizon timeHorizon, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? categoryId = freezed,Object? kpiDescription = freezed,Object? startValue = freezed,Object? targetValue = freezed,Object? priority = freezed,Object? urgency = freezed,Object? why = freezed,Object? startDate = freezed,Object? targetDate = freezed,Object? checkInFrequency = freezed,Object? isMeasurable = freezed,Object? timeHorizon = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,kpiDescription: freezed == kpiDescription ? _self.kpiDescription : kpiDescription // ignore: cast_nullable_to_non_nullable
as String?,startValue: freezed == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as String?,targetValue: freezed == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,urgency: freezed == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as TaskPriority?,why: freezed == why ? _self.why : why // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInFrequency: freezed == checkInFrequency ? _self.checkInFrequency : checkInFrequency // ignore: cast_nullable_to_non_nullable
as CheckInFrequency?,isMeasurable: freezed == isMeasurable ? _self.isMeasurable : isMeasurable // ignore: cast_nullable_to_non_nullable
as bool?,timeHorizon: null == timeHorizon ? _self.timeHorizon : timeHorizon // ignore: cast_nullable_to_non_nullable
as GoalTimeHorizon,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
