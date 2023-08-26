// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      json['mimetype'] as String,
      json['width'] as int,
      json['height'] as int,
      json['size'] as int,
      json['averageColor'] as String,
      json['url'] as String,
      (json['copies'] as List<dynamic>)
          .map((e) => ImageCopy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'mimetype': instance.mimetype,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'averageColor': instance.averageColor,
      'url': instance.url,
      'copies': instance.copies,
    };
