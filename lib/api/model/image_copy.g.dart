// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_copy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageCopy _$ImageCopyFromJson(Map<String, dynamic> json) => ImageCopy(
      json['copyId'] as String,
      json['width'] as int,
      json['height'] as int,
      json['size'] as int,
      json['url'] as String,
      json['objectFit'] as String,
    );

Map<String, dynamic> _$ImageCopyToJson(ImageCopy instance) => <String, dynamic>{
      'copyId': instance.copyId,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'url': instance.url,
      'objectFit': instance.objectFit,
    };
