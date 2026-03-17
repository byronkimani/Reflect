// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDTO {

 int get id; String get title;// Example: If API returns 'post_content', we map it here to 'body'
// @JsonKey(name: 'post_content') required String body,
 String get body; bool get isRead;
/// Create a copy of PostDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDTOCopyWith<PostDTO> get copyWith => _$PostDTOCopyWithImpl<PostDTO>(this as PostDTO, _$identity);

  /// Serializes this PostDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,isRead);

@override
String toString() {
  return 'PostDTO(id: $id, title: $title, body: $body, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class $PostDTOCopyWith<$Res>  {
  factory $PostDTOCopyWith(PostDTO value, $Res Function(PostDTO) _then) = _$PostDTOCopyWithImpl;
@useResult
$Res call({
 int id, String title, String body, bool isRead
});




}
/// @nodoc
class _$PostDTOCopyWithImpl<$Res>
    implements $PostDTOCopyWith<$Res> {
  _$PostDTOCopyWithImpl(this._self, this._then);

  final PostDTO _self;
  final $Res Function(PostDTO) _then;

/// Create a copy of PostDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? isRead = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostDTO].
extension PostDTOPatterns on PostDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDTO value)  $default,){
final _that = this;
switch (_that) {
case _PostDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDTO value)?  $default,){
final _that = this;
switch (_that) {
case _PostDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String body,  bool isRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDTO() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.isRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String body,  bool isRead)  $default,) {final _that = this;
switch (_that) {
case _PostDTO():
return $default(_that.id,_that.title,_that.body,_that.isRead);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String body,  bool isRead)?  $default,) {final _that = this;
switch (_that) {
case _PostDTO() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.isRead);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDTO extends PostDTO {
  const _PostDTO({required this.id, required this.title, required this.body, this.isRead = false}): super._();
  factory _PostDTO.fromJson(Map<String, dynamic> json) => _$PostDTOFromJson(json);

@override final  int id;
@override final  String title;
// Example: If API returns 'post_content', we map it here to 'body'
// @JsonKey(name: 'post_content') required String body,
@override final  String body;
@override@JsonKey() final  bool isRead;

/// Create a copy of PostDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDTOCopyWith<_PostDTO> get copyWith => __$PostDTOCopyWithImpl<_PostDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,isRead);

@override
String toString() {
  return 'PostDTO(id: $id, title: $title, body: $body, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class _$PostDTOCopyWith<$Res> implements $PostDTOCopyWith<$Res> {
  factory _$PostDTOCopyWith(_PostDTO value, $Res Function(_PostDTO) _then) = __$PostDTOCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String body, bool isRead
});




}
/// @nodoc
class __$PostDTOCopyWithImpl<$Res>
    implements _$PostDTOCopyWith<$Res> {
  __$PostDTOCopyWithImpl(this._self, this._then);

  final _PostDTO _self;
  final $Res Function(_PostDTO) _then;

/// Create a copy of PostDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? isRead = null,}) {
  return _then(_PostDTO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
