// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyReview {

 String get id; DateTime get reviewDate; int get dayRating; String? get wentWell; String? get couldBeBetter; String get gratitude1; String get gratitude2; String get gratitude3; double get taskCompletionRate; DateTime get createdAt;
/// Create a copy of DailyReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReviewCopyWith<DailyReview> get copyWith => _$DailyReviewCopyWithImpl<DailyReview>(this as DailyReview, _$identity);

  /// Serializes this DailyReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.dayRating, dayRating) || other.dayRating == dayRating)&&(identical(other.wentWell, wentWell) || other.wentWell == wentWell)&&(identical(other.couldBeBetter, couldBeBetter) || other.couldBeBetter == couldBeBetter)&&(identical(other.gratitude1, gratitude1) || other.gratitude1 == gratitude1)&&(identical(other.gratitude2, gratitude2) || other.gratitude2 == gratitude2)&&(identical(other.gratitude3, gratitude3) || other.gratitude3 == gratitude3)&&(identical(other.taskCompletionRate, taskCompletionRate) || other.taskCompletionRate == taskCompletionRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reviewDate,dayRating,wentWell,couldBeBetter,gratitude1,gratitude2,gratitude3,taskCompletionRate,createdAt);

@override
String toString() {
  return 'DailyReview(id: $id, reviewDate: $reviewDate, dayRating: $dayRating, wentWell: $wentWell, couldBeBetter: $couldBeBetter, gratitude1: $gratitude1, gratitude2: $gratitude2, gratitude3: $gratitude3, taskCompletionRate: $taskCompletionRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DailyReviewCopyWith<$Res>  {
  factory $DailyReviewCopyWith(DailyReview value, $Res Function(DailyReview) _then) = _$DailyReviewCopyWithImpl;
@useResult
$Res call({
 String id, DateTime reviewDate, int dayRating, String? wentWell, String? couldBeBetter, String gratitude1, String gratitude2, String gratitude3, double taskCompletionRate, DateTime createdAt
});




}
/// @nodoc
class _$DailyReviewCopyWithImpl<$Res>
    implements $DailyReviewCopyWith<$Res> {
  _$DailyReviewCopyWithImpl(this._self, this._then);

  final DailyReview _self;
  final $Res Function(DailyReview) _then;

/// Create a copy of DailyReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reviewDate = null,Object? dayRating = null,Object? wentWell = freezed,Object? couldBeBetter = freezed,Object? gratitude1 = null,Object? gratitude2 = null,Object? gratitude3 = null,Object? taskCompletionRate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reviewDate: null == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayRating: null == dayRating ? _self.dayRating : dayRating // ignore: cast_nullable_to_non_nullable
as int,wentWell: freezed == wentWell ? _self.wentWell : wentWell // ignore: cast_nullable_to_non_nullable
as String?,couldBeBetter: freezed == couldBeBetter ? _self.couldBeBetter : couldBeBetter // ignore: cast_nullable_to_non_nullable
as String?,gratitude1: null == gratitude1 ? _self.gratitude1 : gratitude1 // ignore: cast_nullable_to_non_nullable
as String,gratitude2: null == gratitude2 ? _self.gratitude2 : gratitude2 // ignore: cast_nullable_to_non_nullable
as String,gratitude3: null == gratitude3 ? _self.gratitude3 : gratitude3 // ignore: cast_nullable_to_non_nullable
as String,taskCompletionRate: null == taskCompletionRate ? _self.taskCompletionRate : taskCompletionRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReview].
extension DailyReviewPatterns on DailyReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReview value)  $default,){
final _that = this;
switch (_that) {
case _DailyReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReview value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime reviewDate,  int dayRating,  String? wentWell,  String? couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReview() when $default != null:
return $default(_that.id,_that.reviewDate,_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime reviewDate,  int dayRating,  String? wentWell,  String? couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _DailyReview():
return $default(_that.id,_that.reviewDate,_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime reviewDate,  int dayRating,  String? wentWell,  String? couldBeBetter,  String gratitude1,  String gratitude2,  String gratitude3,  double taskCompletionRate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyReview() when $default != null:
return $default(_that.id,_that.reviewDate,_that.dayRating,_that.wentWell,_that.couldBeBetter,_that.gratitude1,_that.gratitude2,_that.gratitude3,_that.taskCompletionRate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyReview implements DailyReview {
  const _DailyReview({required this.id, required this.reviewDate, required this.dayRating, this.wentWell, this.couldBeBetter, required this.gratitude1, required this.gratitude2, required this.gratitude3, this.taskCompletionRate = 0.0, required this.createdAt});
  factory _DailyReview.fromJson(Map<String, dynamic> json) => _$DailyReviewFromJson(json);

@override final  String id;
@override final  DateTime reviewDate;
@override final  int dayRating;
@override final  String? wentWell;
@override final  String? couldBeBetter;
@override final  String gratitude1;
@override final  String gratitude2;
@override final  String gratitude3;
@override@JsonKey() final  double taskCompletionRate;
@override final  DateTime createdAt;

/// Create a copy of DailyReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReviewCopyWith<_DailyReview> get copyWith => __$DailyReviewCopyWithImpl<_DailyReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.dayRating, dayRating) || other.dayRating == dayRating)&&(identical(other.wentWell, wentWell) || other.wentWell == wentWell)&&(identical(other.couldBeBetter, couldBeBetter) || other.couldBeBetter == couldBeBetter)&&(identical(other.gratitude1, gratitude1) || other.gratitude1 == gratitude1)&&(identical(other.gratitude2, gratitude2) || other.gratitude2 == gratitude2)&&(identical(other.gratitude3, gratitude3) || other.gratitude3 == gratitude3)&&(identical(other.taskCompletionRate, taskCompletionRate) || other.taskCompletionRate == taskCompletionRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reviewDate,dayRating,wentWell,couldBeBetter,gratitude1,gratitude2,gratitude3,taskCompletionRate,createdAt);

@override
String toString() {
  return 'DailyReview(id: $id, reviewDate: $reviewDate, dayRating: $dayRating, wentWell: $wentWell, couldBeBetter: $couldBeBetter, gratitude1: $gratitude1, gratitude2: $gratitude2, gratitude3: $gratitude3, taskCompletionRate: $taskCompletionRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DailyReviewCopyWith<$Res> implements $DailyReviewCopyWith<$Res> {
  factory _$DailyReviewCopyWith(_DailyReview value, $Res Function(_DailyReview) _then) = __$DailyReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime reviewDate, int dayRating, String? wentWell, String? couldBeBetter, String gratitude1, String gratitude2, String gratitude3, double taskCompletionRate, DateTime createdAt
});




}
/// @nodoc
class __$DailyReviewCopyWithImpl<$Res>
    implements _$DailyReviewCopyWith<$Res> {
  __$DailyReviewCopyWithImpl(this._self, this._then);

  final _DailyReview _self;
  final $Res Function(_DailyReview) _then;

/// Create a copy of DailyReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reviewDate = null,Object? dayRating = null,Object? wentWell = freezed,Object? couldBeBetter = freezed,Object? gratitude1 = null,Object? gratitude2 = null,Object? gratitude3 = null,Object? taskCompletionRate = null,Object? createdAt = null,}) {
  return _then(_DailyReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reviewDate: null == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime,dayRating: null == dayRating ? _self.dayRating : dayRating // ignore: cast_nullable_to_non_nullable
as int,wentWell: freezed == wentWell ? _self.wentWell : wentWell // ignore: cast_nullable_to_non_nullable
as String?,couldBeBetter: freezed == couldBeBetter ? _self.couldBeBetter : couldBeBetter // ignore: cast_nullable_to_non_nullable
as String?,gratitude1: null == gratitude1 ? _self.gratitude1 : gratitude1 // ignore: cast_nullable_to_non_nullable
as String,gratitude2: null == gratitude2 ? _self.gratitude2 : gratitude2 // ignore: cast_nullable_to_non_nullable
as String,gratitude3: null == gratitude3 ? _self.gratitude3 : gratitude3 // ignore: cast_nullable_to_non_nullable
as String,taskCompletionRate: null == taskCompletionRate ? _self.taskCompletionRate : taskCompletionRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$WeeklyPlan {

 String get id; DateTime get weekStartDate; String? get theme; String? get intentions; DateTime get createdAt; List<WeeklyGoal> get goals; WeeklyReview? get review;
/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyPlanCopyWith<WeeklyPlan> get copyWith => _$WeeklyPlanCopyWithImpl<WeeklyPlan>(this as WeeklyPlan, _$identity);

  /// Serializes this WeeklyPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.intentions, intentions) || other.intentions == intentions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,theme,intentions,createdAt,const DeepCollectionEquality().hash(goals),review);

@override
String toString() {
  return 'WeeklyPlan(id: $id, weekStartDate: $weekStartDate, theme: $theme, intentions: $intentions, createdAt: $createdAt, goals: $goals, review: $review)';
}


}

/// @nodoc
abstract mixin class $WeeklyPlanCopyWith<$Res>  {
  factory $WeeklyPlanCopyWith(WeeklyPlan value, $Res Function(WeeklyPlan) _then) = _$WeeklyPlanCopyWithImpl;
@useResult
$Res call({
 String id, DateTime weekStartDate, String? theme, String? intentions, DateTime createdAt, List<WeeklyGoal> goals, WeeklyReview? review
});


$WeeklyReviewCopyWith<$Res>? get review;

}
/// @nodoc
class _$WeeklyPlanCopyWithImpl<$Res>
    implements $WeeklyPlanCopyWith<$Res> {
  _$WeeklyPlanCopyWithImpl(this._self, this._then);

  final WeeklyPlan _self;
  final $Res Function(WeeklyPlan) _then;

/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekStartDate = null,Object? theme = freezed,Object? intentions = freezed,Object? createdAt = null,Object? goals = null,Object? review = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,intentions: freezed == intentions ? _self.intentions : intentions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<WeeklyGoal>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as WeeklyReview?,
  ));
}
/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeeklyReviewCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $WeeklyReviewCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeeklyPlan].
extension WeeklyPlanPatterns on WeeklyPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyPlan value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyPlan value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  String? theme,  String? intentions,  DateTime createdAt,  List<WeeklyGoal> goals,  WeeklyReview? review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyPlan() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.theme,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  String? theme,  String? intentions,  DateTime createdAt,  List<WeeklyGoal> goals,  WeeklyReview? review)  $default,) {final _that = this;
switch (_that) {
case _WeeklyPlan():
return $default(_that.id,_that.weekStartDate,_that.theme,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime weekStartDate,  String? theme,  String? intentions,  DateTime createdAt,  List<WeeklyGoal> goals,  WeeklyReview? review)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyPlan() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.theme,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyPlan implements WeeklyPlan {
  const _WeeklyPlan({required this.id, required this.weekStartDate, this.theme, this.intentions, required this.createdAt, final  List<WeeklyGoal> goals = const [], this.review}): _goals = goals;
  factory _WeeklyPlan.fromJson(Map<String, dynamic> json) => _$WeeklyPlanFromJson(json);

@override final  String id;
@override final  DateTime weekStartDate;
@override final  String? theme;
@override final  String? intentions;
@override final  DateTime createdAt;
 final  List<WeeklyGoal> _goals;
@override@JsonKey() List<WeeklyGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  WeeklyReview? review;

/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyPlanCopyWith<_WeeklyPlan> get copyWith => __$WeeklyPlanCopyWithImpl<_WeeklyPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.intentions, intentions) || other.intentions == intentions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,theme,intentions,createdAt,const DeepCollectionEquality().hash(_goals),review);

@override
String toString() {
  return 'WeeklyPlan(id: $id, weekStartDate: $weekStartDate, theme: $theme, intentions: $intentions, createdAt: $createdAt, goals: $goals, review: $review)';
}


}

/// @nodoc
abstract mixin class _$WeeklyPlanCopyWith<$Res> implements $WeeklyPlanCopyWith<$Res> {
  factory _$WeeklyPlanCopyWith(_WeeklyPlan value, $Res Function(_WeeklyPlan) _then) = __$WeeklyPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime weekStartDate, String? theme, String? intentions, DateTime createdAt, List<WeeklyGoal> goals, WeeklyReview? review
});


@override $WeeklyReviewCopyWith<$Res>? get review;

}
/// @nodoc
class __$WeeklyPlanCopyWithImpl<$Res>
    implements _$WeeklyPlanCopyWith<$Res> {
  __$WeeklyPlanCopyWithImpl(this._self, this._then);

  final _WeeklyPlan _self;
  final $Res Function(_WeeklyPlan) _then;

/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekStartDate = null,Object? theme = freezed,Object? intentions = freezed,Object? createdAt = null,Object? goals = null,Object? review = freezed,}) {
  return _then(_WeeklyPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,intentions: freezed == intentions ? _self.intentions : intentions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<WeeklyGoal>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as WeeklyReview?,
  ));
}

/// Create a copy of WeeklyPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeeklyReviewCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $WeeklyReviewCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// @nodoc
mixin _$WeeklyReview {

 String get id; DateTime get weekStartDate; bool? get themeAchieved; String? get reflectionNotes; int get weekRating; double get goalHitRate; DateTime get createdAt;
/// Create a copy of WeeklyReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyReviewCopyWith<WeeklyReview> get copyWith => _$WeeklyReviewCopyWithImpl<WeeklyReview>(this as WeeklyReview, _$identity);

  /// Serializes this WeeklyReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.themeAchieved, themeAchieved) || other.themeAchieved == themeAchieved)&&(identical(other.reflectionNotes, reflectionNotes) || other.reflectionNotes == reflectionNotes)&&(identical(other.weekRating, weekRating) || other.weekRating == weekRating)&&(identical(other.goalHitRate, goalHitRate) || other.goalHitRate == goalHitRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,themeAchieved,reflectionNotes,weekRating,goalHitRate,createdAt);

@override
String toString() {
  return 'WeeklyReview(id: $id, weekStartDate: $weekStartDate, themeAchieved: $themeAchieved, reflectionNotes: $reflectionNotes, weekRating: $weekRating, goalHitRate: $goalHitRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WeeklyReviewCopyWith<$Res>  {
  factory $WeeklyReviewCopyWith(WeeklyReview value, $Res Function(WeeklyReview) _then) = _$WeeklyReviewCopyWithImpl;
@useResult
$Res call({
 String id, DateTime weekStartDate, bool? themeAchieved, String? reflectionNotes, int weekRating, double goalHitRate, DateTime createdAt
});




}
/// @nodoc
class _$WeeklyReviewCopyWithImpl<$Res>
    implements $WeeklyReviewCopyWith<$Res> {
  _$WeeklyReviewCopyWithImpl(this._self, this._then);

  final WeeklyReview _self;
  final $Res Function(WeeklyReview) _then;

/// Create a copy of WeeklyReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekStartDate = null,Object? themeAchieved = freezed,Object? reflectionNotes = freezed,Object? weekRating = null,Object? goalHitRate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,themeAchieved: freezed == themeAchieved ? _self.themeAchieved : themeAchieved // ignore: cast_nullable_to_non_nullable
as bool?,reflectionNotes: freezed == reflectionNotes ? _self.reflectionNotes : reflectionNotes // ignore: cast_nullable_to_non_nullable
as String?,weekRating: null == weekRating ? _self.weekRating : weekRating // ignore: cast_nullable_to_non_nullable
as int,goalHitRate: null == goalHitRate ? _self.goalHitRate : goalHitRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyReview].
extension WeeklyReviewPatterns on WeeklyReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyReview value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyReview value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  bool? themeAchieved,  String? reflectionNotes,  int weekRating,  double goalHitRate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyReview() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.themeAchieved,_that.reflectionNotes,_that.weekRating,_that.goalHitRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  bool? themeAchieved,  String? reflectionNotes,  int weekRating,  double goalHitRate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WeeklyReview():
return $default(_that.id,_that.weekStartDate,_that.themeAchieved,_that.reflectionNotes,_that.weekRating,_that.goalHitRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime weekStartDate,  bool? themeAchieved,  String? reflectionNotes,  int weekRating,  double goalHitRate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyReview() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.themeAchieved,_that.reflectionNotes,_that.weekRating,_that.goalHitRate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyReview implements WeeklyReview {
  const _WeeklyReview({required this.id, required this.weekStartDate, this.themeAchieved, this.reflectionNotes, required this.weekRating, this.goalHitRate = 0.0, required this.createdAt});
  factory _WeeklyReview.fromJson(Map<String, dynamic> json) => _$WeeklyReviewFromJson(json);

@override final  String id;
@override final  DateTime weekStartDate;
@override final  bool? themeAchieved;
@override final  String? reflectionNotes;
@override final  int weekRating;
@override@JsonKey() final  double goalHitRate;
@override final  DateTime createdAt;

/// Create a copy of WeeklyReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyReviewCopyWith<_WeeklyReview> get copyWith => __$WeeklyReviewCopyWithImpl<_WeeklyReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.themeAchieved, themeAchieved) || other.themeAchieved == themeAchieved)&&(identical(other.reflectionNotes, reflectionNotes) || other.reflectionNotes == reflectionNotes)&&(identical(other.weekRating, weekRating) || other.weekRating == weekRating)&&(identical(other.goalHitRate, goalHitRate) || other.goalHitRate == goalHitRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,themeAchieved,reflectionNotes,weekRating,goalHitRate,createdAt);

@override
String toString() {
  return 'WeeklyReview(id: $id, weekStartDate: $weekStartDate, themeAchieved: $themeAchieved, reflectionNotes: $reflectionNotes, weekRating: $weekRating, goalHitRate: $goalHitRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WeeklyReviewCopyWith<$Res> implements $WeeklyReviewCopyWith<$Res> {
  factory _$WeeklyReviewCopyWith(_WeeklyReview value, $Res Function(_WeeklyReview) _then) = __$WeeklyReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime weekStartDate, bool? themeAchieved, String? reflectionNotes, int weekRating, double goalHitRate, DateTime createdAt
});




}
/// @nodoc
class __$WeeklyReviewCopyWithImpl<$Res>
    implements _$WeeklyReviewCopyWith<$Res> {
  __$WeeklyReviewCopyWithImpl(this._self, this._then);

  final _WeeklyReview _self;
  final $Res Function(_WeeklyReview) _then;

/// Create a copy of WeeklyReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekStartDate = null,Object? themeAchieved = freezed,Object? reflectionNotes = freezed,Object? weekRating = null,Object? goalHitRate = null,Object? createdAt = null,}) {
  return _then(_WeeklyReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,themeAchieved: freezed == themeAchieved ? _self.themeAchieved : themeAchieved // ignore: cast_nullable_to_non_nullable
as bool?,reflectionNotes: freezed == reflectionNotes ? _self.reflectionNotes : reflectionNotes // ignore: cast_nullable_to_non_nullable
as String?,weekRating: null == weekRating ? _self.weekRating : weekRating // ignore: cast_nullable_to_non_nullable
as int,goalHitRate: null == goalHitRate ? _self.goalHitRate : goalHitRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$WeeklyGoal {

 String get id; DateTime get weekStartDate; String get title; bool get isAchieved; int get sortOrder;
/// Create a copy of WeeklyGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyGoalCopyWith<WeeklyGoal> get copyWith => _$WeeklyGoalCopyWithImpl<WeeklyGoal>(this as WeeklyGoal, _$identity);

  /// Serializes this WeeklyGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.isAchieved, isAchieved) || other.isAchieved == isAchieved)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,title,isAchieved,sortOrder);

@override
String toString() {
  return 'WeeklyGoal(id: $id, weekStartDate: $weekStartDate, title: $title, isAchieved: $isAchieved, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $WeeklyGoalCopyWith<$Res>  {
  factory $WeeklyGoalCopyWith(WeeklyGoal value, $Res Function(WeeklyGoal) _then) = _$WeeklyGoalCopyWithImpl;
@useResult
$Res call({
 String id, DateTime weekStartDate, String title, bool isAchieved, int sortOrder
});




}
/// @nodoc
class _$WeeklyGoalCopyWithImpl<$Res>
    implements $WeeklyGoalCopyWith<$Res> {
  _$WeeklyGoalCopyWithImpl(this._self, this._then);

  final WeeklyGoal _self;
  final $Res Function(WeeklyGoal) _then;

/// Create a copy of WeeklyGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekStartDate = null,Object? title = null,Object? isAchieved = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyGoal].
extension WeeklyGoalPatterns on WeeklyGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyGoal value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyGoal value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  String title,  bool isAchieved,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyGoal() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.title,_that.isAchieved,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime weekStartDate,  String title,  bool isAchieved,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _WeeklyGoal():
return $default(_that.id,_that.weekStartDate,_that.title,_that.isAchieved,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime weekStartDate,  String title,  bool isAchieved,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyGoal() when $default != null:
return $default(_that.id,_that.weekStartDate,_that.title,_that.isAchieved,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyGoal implements WeeklyGoal {
  const _WeeklyGoal({required this.id, required this.weekStartDate, required this.title, this.isAchieved = false, this.sortOrder = 0});
  factory _WeeklyGoal.fromJson(Map<String, dynamic> json) => _$WeeklyGoalFromJson(json);

@override final  String id;
@override final  DateTime weekStartDate;
@override final  String title;
@override@JsonKey() final  bool isAchieved;
@override@JsonKey() final  int sortOrder;

/// Create a copy of WeeklyGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyGoalCopyWith<_WeeklyGoal> get copyWith => __$WeeklyGoalCopyWithImpl<_WeeklyGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.isAchieved, isAchieved) || other.isAchieved == isAchieved)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekStartDate,title,isAchieved,sortOrder);

@override
String toString() {
  return 'WeeklyGoal(id: $id, weekStartDate: $weekStartDate, title: $title, isAchieved: $isAchieved, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$WeeklyGoalCopyWith<$Res> implements $WeeklyGoalCopyWith<$Res> {
  factory _$WeeklyGoalCopyWith(_WeeklyGoal value, $Res Function(_WeeklyGoal) _then) = __$WeeklyGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime weekStartDate, String title, bool isAchieved, int sortOrder
});




}
/// @nodoc
class __$WeeklyGoalCopyWithImpl<$Res>
    implements _$WeeklyGoalCopyWith<$Res> {
  __$WeeklyGoalCopyWithImpl(this._self, this._then);

  final _WeeklyGoal _self;
  final $Res Function(_WeeklyGoal) _then;

/// Create a copy of WeeklyGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekStartDate = null,Object? title = null,Object? isAchieved = null,Object? sortOrder = null,}) {
  return _then(_WeeklyGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MonthlyPlan {

 String get id; String get monthYear; String? get intentions; DateTime get createdAt; List<MonthlyGoal> get goals; MonthlyReview? get review;
/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyPlanCopyWith<MonthlyPlan> get copyWith => _$MonthlyPlanCopyWithImpl<MonthlyPlan>(this as MonthlyPlan, _$identity);

  /// Serializes this MonthlyPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.intentions, intentions) || other.intentions == intentions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,intentions,createdAt,const DeepCollectionEquality().hash(goals),review);

@override
String toString() {
  return 'MonthlyPlan(id: $id, monthYear: $monthYear, intentions: $intentions, createdAt: $createdAt, goals: $goals, review: $review)';
}


}

/// @nodoc
abstract mixin class $MonthlyPlanCopyWith<$Res>  {
  factory $MonthlyPlanCopyWith(MonthlyPlan value, $Res Function(MonthlyPlan) _then) = _$MonthlyPlanCopyWithImpl;
@useResult
$Res call({
 String id, String monthYear, String? intentions, DateTime createdAt, List<MonthlyGoal> goals, MonthlyReview? review
});


$MonthlyReviewCopyWith<$Res>? get review;

}
/// @nodoc
class _$MonthlyPlanCopyWithImpl<$Res>
    implements $MonthlyPlanCopyWith<$Res> {
  _$MonthlyPlanCopyWithImpl(this._self, this._then);

  final MonthlyPlan _self;
  final $Res Function(MonthlyPlan) _then;

/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? monthYear = null,Object? intentions = freezed,Object? createdAt = null,Object? goals = null,Object? review = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,intentions: freezed == intentions ? _self.intentions : intentions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<MonthlyGoal>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as MonthlyReview?,
  ));
}
/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyReviewCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $MonthlyReviewCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthlyPlan].
extension MonthlyPlanPatterns on MonthlyPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyPlan value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String monthYear,  String? intentions,  DateTime createdAt,  List<MonthlyGoal> goals,  MonthlyReview? review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyPlan() when $default != null:
return $default(_that.id,_that.monthYear,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String monthYear,  String? intentions,  DateTime createdAt,  List<MonthlyGoal> goals,  MonthlyReview? review)  $default,) {final _that = this;
switch (_that) {
case _MonthlyPlan():
return $default(_that.id,_that.monthYear,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String monthYear,  String? intentions,  DateTime createdAt,  List<MonthlyGoal> goals,  MonthlyReview? review)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyPlan() when $default != null:
return $default(_that.id,_that.monthYear,_that.intentions,_that.createdAt,_that.goals,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyPlan implements MonthlyPlan {
  const _MonthlyPlan({required this.id, required this.monthYear, this.intentions, required this.createdAt, final  List<MonthlyGoal> goals = const [], this.review}): _goals = goals;
  factory _MonthlyPlan.fromJson(Map<String, dynamic> json) => _$MonthlyPlanFromJson(json);

@override final  String id;
@override final  String monthYear;
@override final  String? intentions;
@override final  DateTime createdAt;
 final  List<MonthlyGoal> _goals;
@override@JsonKey() List<MonthlyGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  MonthlyReview? review;

/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyPlanCopyWith<_MonthlyPlan> get copyWith => __$MonthlyPlanCopyWithImpl<_MonthlyPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.intentions, intentions) || other.intentions == intentions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,intentions,createdAt,const DeepCollectionEquality().hash(_goals),review);

@override
String toString() {
  return 'MonthlyPlan(id: $id, monthYear: $monthYear, intentions: $intentions, createdAt: $createdAt, goals: $goals, review: $review)';
}


}

/// @nodoc
abstract mixin class _$MonthlyPlanCopyWith<$Res> implements $MonthlyPlanCopyWith<$Res> {
  factory _$MonthlyPlanCopyWith(_MonthlyPlan value, $Res Function(_MonthlyPlan) _then) = __$MonthlyPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String monthYear, String? intentions, DateTime createdAt, List<MonthlyGoal> goals, MonthlyReview? review
});


@override $MonthlyReviewCopyWith<$Res>? get review;

}
/// @nodoc
class __$MonthlyPlanCopyWithImpl<$Res>
    implements _$MonthlyPlanCopyWith<$Res> {
  __$MonthlyPlanCopyWithImpl(this._self, this._then);

  final _MonthlyPlan _self;
  final $Res Function(_MonthlyPlan) _then;

/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? monthYear = null,Object? intentions = freezed,Object? createdAt = null,Object? goals = null,Object? review = freezed,}) {
  return _then(_MonthlyPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,intentions: freezed == intentions ? _self.intentions : intentions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<MonthlyGoal>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as MonthlyReview?,
  ));
}

/// Create a copy of MonthlyPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyReviewCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $MonthlyReviewCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// @nodoc
mixin _$MonthlyReview {

 String get id; String get monthYear; int get overallRating; String? get win1; String? get win2; String? get win3; String? get challenge1; String? get challenge2; String? get challenge3; String? get gratitudeSummary; String? get intentionsNextMonth; double get goalCompletionRate; DateTime get createdAt;
/// Create a copy of MonthlyReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyReviewCopyWith<MonthlyReview> get copyWith => _$MonthlyReviewCopyWithImpl<MonthlyReview>(this as MonthlyReview, _$identity);

  /// Serializes this MonthlyReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.win1, win1) || other.win1 == win1)&&(identical(other.win2, win2) || other.win2 == win2)&&(identical(other.win3, win3) || other.win3 == win3)&&(identical(other.challenge1, challenge1) || other.challenge1 == challenge1)&&(identical(other.challenge2, challenge2) || other.challenge2 == challenge2)&&(identical(other.challenge3, challenge3) || other.challenge3 == challenge3)&&(identical(other.gratitudeSummary, gratitudeSummary) || other.gratitudeSummary == gratitudeSummary)&&(identical(other.intentionsNextMonth, intentionsNextMonth) || other.intentionsNextMonth == intentionsNextMonth)&&(identical(other.goalCompletionRate, goalCompletionRate) || other.goalCompletionRate == goalCompletionRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,overallRating,win1,win2,win3,challenge1,challenge2,challenge3,gratitudeSummary,intentionsNextMonth,goalCompletionRate,createdAt);

@override
String toString() {
  return 'MonthlyReview(id: $id, monthYear: $monthYear, overallRating: $overallRating, win1: $win1, win2: $win2, win3: $win3, challenge1: $challenge1, challenge2: $challenge2, challenge3: $challenge3, gratitudeSummary: $gratitudeSummary, intentionsNextMonth: $intentionsNextMonth, goalCompletionRate: $goalCompletionRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MonthlyReviewCopyWith<$Res>  {
  factory $MonthlyReviewCopyWith(MonthlyReview value, $Res Function(MonthlyReview) _then) = _$MonthlyReviewCopyWithImpl;
@useResult
$Res call({
 String id, String monthYear, int overallRating, String? win1, String? win2, String? win3, String? challenge1, String? challenge2, String? challenge3, String? gratitudeSummary, String? intentionsNextMonth, double goalCompletionRate, DateTime createdAt
});




}
/// @nodoc
class _$MonthlyReviewCopyWithImpl<$Res>
    implements $MonthlyReviewCopyWith<$Res> {
  _$MonthlyReviewCopyWithImpl(this._self, this._then);

  final MonthlyReview _self;
  final $Res Function(MonthlyReview) _then;

/// Create a copy of MonthlyReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? monthYear = null,Object? overallRating = null,Object? win1 = freezed,Object? win2 = freezed,Object? win3 = freezed,Object? challenge1 = freezed,Object? challenge2 = freezed,Object? challenge3 = freezed,Object? gratitudeSummary = freezed,Object? intentionsNextMonth = freezed,Object? goalCompletionRate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as int,win1: freezed == win1 ? _self.win1 : win1 // ignore: cast_nullable_to_non_nullable
as String?,win2: freezed == win2 ? _self.win2 : win2 // ignore: cast_nullable_to_non_nullable
as String?,win3: freezed == win3 ? _self.win3 : win3 // ignore: cast_nullable_to_non_nullable
as String?,challenge1: freezed == challenge1 ? _self.challenge1 : challenge1 // ignore: cast_nullable_to_non_nullable
as String?,challenge2: freezed == challenge2 ? _self.challenge2 : challenge2 // ignore: cast_nullable_to_non_nullable
as String?,challenge3: freezed == challenge3 ? _self.challenge3 : challenge3 // ignore: cast_nullable_to_non_nullable
as String?,gratitudeSummary: freezed == gratitudeSummary ? _self.gratitudeSummary : gratitudeSummary // ignore: cast_nullable_to_non_nullable
as String?,intentionsNextMonth: freezed == intentionsNextMonth ? _self.intentionsNextMonth : intentionsNextMonth // ignore: cast_nullable_to_non_nullable
as String?,goalCompletionRate: null == goalCompletionRate ? _self.goalCompletionRate : goalCompletionRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyReview].
extension MonthlyReviewPatterns on MonthlyReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyReview value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyReview value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String monthYear,  int overallRating,  String? win1,  String? win2,  String? win3,  String? challenge1,  String? challenge2,  String? challenge3,  String? gratitudeSummary,  String? intentionsNextMonth,  double goalCompletionRate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyReview() when $default != null:
return $default(_that.id,_that.monthYear,_that.overallRating,_that.win1,_that.win2,_that.win3,_that.challenge1,_that.challenge2,_that.challenge3,_that.gratitudeSummary,_that.intentionsNextMonth,_that.goalCompletionRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String monthYear,  int overallRating,  String? win1,  String? win2,  String? win3,  String? challenge1,  String? challenge2,  String? challenge3,  String? gratitudeSummary,  String? intentionsNextMonth,  double goalCompletionRate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MonthlyReview():
return $default(_that.id,_that.monthYear,_that.overallRating,_that.win1,_that.win2,_that.win3,_that.challenge1,_that.challenge2,_that.challenge3,_that.gratitudeSummary,_that.intentionsNextMonth,_that.goalCompletionRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String monthYear,  int overallRating,  String? win1,  String? win2,  String? win3,  String? challenge1,  String? challenge2,  String? challenge3,  String? gratitudeSummary,  String? intentionsNextMonth,  double goalCompletionRate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyReview() when $default != null:
return $default(_that.id,_that.monthYear,_that.overallRating,_that.win1,_that.win2,_that.win3,_that.challenge1,_that.challenge2,_that.challenge3,_that.gratitudeSummary,_that.intentionsNextMonth,_that.goalCompletionRate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyReview implements MonthlyReview {
  const _MonthlyReview({required this.id, required this.monthYear, required this.overallRating, this.win1, this.win2, this.win3, this.challenge1, this.challenge2, this.challenge3, this.gratitudeSummary, this.intentionsNextMonth, this.goalCompletionRate = 0.0, required this.createdAt});
  factory _MonthlyReview.fromJson(Map<String, dynamic> json) => _$MonthlyReviewFromJson(json);

@override final  String id;
@override final  String monthYear;
@override final  int overallRating;
@override final  String? win1;
@override final  String? win2;
@override final  String? win3;
@override final  String? challenge1;
@override final  String? challenge2;
@override final  String? challenge3;
@override final  String? gratitudeSummary;
@override final  String? intentionsNextMonth;
@override@JsonKey() final  double goalCompletionRate;
@override final  DateTime createdAt;

/// Create a copy of MonthlyReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyReviewCopyWith<_MonthlyReview> get copyWith => __$MonthlyReviewCopyWithImpl<_MonthlyReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.win1, win1) || other.win1 == win1)&&(identical(other.win2, win2) || other.win2 == win2)&&(identical(other.win3, win3) || other.win3 == win3)&&(identical(other.challenge1, challenge1) || other.challenge1 == challenge1)&&(identical(other.challenge2, challenge2) || other.challenge2 == challenge2)&&(identical(other.challenge3, challenge3) || other.challenge3 == challenge3)&&(identical(other.gratitudeSummary, gratitudeSummary) || other.gratitudeSummary == gratitudeSummary)&&(identical(other.intentionsNextMonth, intentionsNextMonth) || other.intentionsNextMonth == intentionsNextMonth)&&(identical(other.goalCompletionRate, goalCompletionRate) || other.goalCompletionRate == goalCompletionRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,overallRating,win1,win2,win3,challenge1,challenge2,challenge3,gratitudeSummary,intentionsNextMonth,goalCompletionRate,createdAt);

@override
String toString() {
  return 'MonthlyReview(id: $id, monthYear: $monthYear, overallRating: $overallRating, win1: $win1, win2: $win2, win3: $win3, challenge1: $challenge1, challenge2: $challenge2, challenge3: $challenge3, gratitudeSummary: $gratitudeSummary, intentionsNextMonth: $intentionsNextMonth, goalCompletionRate: $goalCompletionRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MonthlyReviewCopyWith<$Res> implements $MonthlyReviewCopyWith<$Res> {
  factory _$MonthlyReviewCopyWith(_MonthlyReview value, $Res Function(_MonthlyReview) _then) = __$MonthlyReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String monthYear, int overallRating, String? win1, String? win2, String? win3, String? challenge1, String? challenge2, String? challenge3, String? gratitudeSummary, String? intentionsNextMonth, double goalCompletionRate, DateTime createdAt
});




}
/// @nodoc
class __$MonthlyReviewCopyWithImpl<$Res>
    implements _$MonthlyReviewCopyWith<$Res> {
  __$MonthlyReviewCopyWithImpl(this._self, this._then);

  final _MonthlyReview _self;
  final $Res Function(_MonthlyReview) _then;

/// Create a copy of MonthlyReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? monthYear = null,Object? overallRating = null,Object? win1 = freezed,Object? win2 = freezed,Object? win3 = freezed,Object? challenge1 = freezed,Object? challenge2 = freezed,Object? challenge3 = freezed,Object? gratitudeSummary = freezed,Object? intentionsNextMonth = freezed,Object? goalCompletionRate = null,Object? createdAt = null,}) {
  return _then(_MonthlyReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as int,win1: freezed == win1 ? _self.win1 : win1 // ignore: cast_nullable_to_non_nullable
as String?,win2: freezed == win2 ? _self.win2 : win2 // ignore: cast_nullable_to_non_nullable
as String?,win3: freezed == win3 ? _self.win3 : win3 // ignore: cast_nullable_to_non_nullable
as String?,challenge1: freezed == challenge1 ? _self.challenge1 : challenge1 // ignore: cast_nullable_to_non_nullable
as String?,challenge2: freezed == challenge2 ? _self.challenge2 : challenge2 // ignore: cast_nullable_to_non_nullable
as String?,challenge3: freezed == challenge3 ? _self.challenge3 : challenge3 // ignore: cast_nullable_to_non_nullable
as String?,gratitudeSummary: freezed == gratitudeSummary ? _self.gratitudeSummary : gratitudeSummary // ignore: cast_nullable_to_non_nullable
as String?,intentionsNextMonth: freezed == intentionsNextMonth ? _self.intentionsNextMonth : intentionsNextMonth // ignore: cast_nullable_to_non_nullable
as String?,goalCompletionRate: null == goalCompletionRate ? _self.goalCompletionRate : goalCompletionRate // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MonthlyGoal {

 String get id; String get monthYear; String get title; bool get isAchieved; int get sortOrder;
/// Create a copy of MonthlyGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyGoalCopyWith<MonthlyGoal> get copyWith => _$MonthlyGoalCopyWithImpl<MonthlyGoal>(this as MonthlyGoal, _$identity);

  /// Serializes this MonthlyGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.title, title) || other.title == title)&&(identical(other.isAchieved, isAchieved) || other.isAchieved == isAchieved)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,title,isAchieved,sortOrder);

@override
String toString() {
  return 'MonthlyGoal(id: $id, monthYear: $monthYear, title: $title, isAchieved: $isAchieved, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $MonthlyGoalCopyWith<$Res>  {
  factory $MonthlyGoalCopyWith(MonthlyGoal value, $Res Function(MonthlyGoal) _then) = _$MonthlyGoalCopyWithImpl;
@useResult
$Res call({
 String id, String monthYear, String title, bool isAchieved, int sortOrder
});




}
/// @nodoc
class _$MonthlyGoalCopyWithImpl<$Res>
    implements $MonthlyGoalCopyWith<$Res> {
  _$MonthlyGoalCopyWithImpl(this._self, this._then);

  final MonthlyGoal _self;
  final $Res Function(MonthlyGoal) _then;

/// Create a copy of MonthlyGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? monthYear = null,Object? title = null,Object? isAchieved = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyGoal].
extension MonthlyGoalPatterns on MonthlyGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyGoal value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyGoal value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String monthYear,  String title,  bool isAchieved,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyGoal() when $default != null:
return $default(_that.id,_that.monthYear,_that.title,_that.isAchieved,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String monthYear,  String title,  bool isAchieved,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _MonthlyGoal():
return $default(_that.id,_that.monthYear,_that.title,_that.isAchieved,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String monthYear,  String title,  bool isAchieved,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyGoal() when $default != null:
return $default(_that.id,_that.monthYear,_that.title,_that.isAchieved,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyGoal implements MonthlyGoal {
  const _MonthlyGoal({required this.id, required this.monthYear, required this.title, this.isAchieved = false, this.sortOrder = 0});
  factory _MonthlyGoal.fromJson(Map<String, dynamic> json) => _$MonthlyGoalFromJson(json);

@override final  String id;
@override final  String monthYear;
@override final  String title;
@override@JsonKey() final  bool isAchieved;
@override@JsonKey() final  int sortOrder;

/// Create a copy of MonthlyGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyGoalCopyWith<_MonthlyGoal> get copyWith => __$MonthlyGoalCopyWithImpl<_MonthlyGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.monthYear, monthYear) || other.monthYear == monthYear)&&(identical(other.title, title) || other.title == title)&&(identical(other.isAchieved, isAchieved) || other.isAchieved == isAchieved)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,monthYear,title,isAchieved,sortOrder);

@override
String toString() {
  return 'MonthlyGoal(id: $id, monthYear: $monthYear, title: $title, isAchieved: $isAchieved, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$MonthlyGoalCopyWith<$Res> implements $MonthlyGoalCopyWith<$Res> {
  factory _$MonthlyGoalCopyWith(_MonthlyGoal value, $Res Function(_MonthlyGoal) _then) = __$MonthlyGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String monthYear, String title, bool isAchieved, int sortOrder
});




}
/// @nodoc
class __$MonthlyGoalCopyWithImpl<$Res>
    implements _$MonthlyGoalCopyWith<$Res> {
  __$MonthlyGoalCopyWithImpl(this._self, this._then);

  final _MonthlyGoal _self;
  final $Res Function(_MonthlyGoal) _then;

/// Create a copy of MonthlyGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? monthYear = null,Object? title = null,Object? isAchieved = null,Object? sortOrder = null,}) {
  return _then(_MonthlyGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,monthYear: null == monthYear ? _self.monthYear : monthYear // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
