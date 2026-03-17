// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Initial _$InitialFromJson(Map<String, dynamic> json) =>
    _Initial($type: json['runtimeType'] as String?);

Map<String, dynamic> _$InitialToJson(_Initial instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};

_Loading _$LoadingFromJson(Map<String, dynamic> json) =>
    _Loading($type: json['runtimeType'] as String?);

Map<String, dynamic> _$LoadingToJson(_Loading instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};

_Loaded _$LoadedFromJson(Map<String, dynamic> json) => _Loaded(
  (json['posts'] as List<dynamic>)
      .map((e) => Post.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$LoadedToJson(_Loaded instance) => <String, dynamic>{
  'posts': instance.posts,
  'runtimeType': instance.$type,
};

_Error _$ErrorFromJson(Map<String, dynamic> json) =>
    _Error(json['message'] as String, $type: json['runtimeType'] as String?);

Map<String, dynamic> _$ErrorToJson(_Error instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};
