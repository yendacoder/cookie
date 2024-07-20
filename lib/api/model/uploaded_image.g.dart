// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedImage _$UploadedImageFromJson(Map<String, dynamic> json) =>
    UploadedImage(
      json['id'] as String,
      json['width'] as int,
      json['height'] as int,
      json['size'] as int,
      json['url'] as String,
    );

Map<String, dynamic> _$UploadedImageToJson(UploadedImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'url': instance.url,
    };
