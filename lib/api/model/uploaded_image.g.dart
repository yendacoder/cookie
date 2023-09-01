// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedImage _$UploadedImageFromJson(Map<String, dynamic> json) =>
    UploadedImage(
      json['id'] as String,
      json['type'] as String,
      json['width'] as int,
      json['maxWidth'] as int,
      json['height'] as int,
      json['maxHeight'] as int,
      json['size'] as int,
      Color.fromJson(json['averageColor'] as Map<String, dynamic>),
      json['url'] as String,
      (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      json['createdAt'] as String,
      json['deleted'] as bool,
    );

Map<String, dynamic> _$UploadedImageToJson(UploadedImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'width': instance.width,
      'maxWidth': instance.maxWidth,
      'height': instance.height,
      'maxHeight': instance.maxHeight,
      'size': instance.size,
      'averageColor': instance.averageColor,
      'url': instance.url,
      'urls': instance.urls,
      'createdAt': instance.createdAt,
      'deleted': instance.deleted,
    };
