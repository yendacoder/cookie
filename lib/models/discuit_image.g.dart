// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuit_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscuitImage _$DiscuitImageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DiscuitImage', json, ($checkedConvert) {
      final val = _DiscuitImage(
        id: $checkedConvert('id', (v) => v as String),
        format: $checkedConvert('format', (v) => v as String),
        mimetype: $checkedConvert('mimetype', (v) => v as String),
        width: $checkedConvert('width', (v) => (v as num).toInt()),
        height: $checkedConvert('height', (v) => (v as num).toInt()),
        size: $checkedConvert('size', (v) => (v as num).toInt()),
        averageColor: $checkedConvert('averageColor', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String),
        copies: $checkedConvert(
          'copies',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => ImageCopy.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
        altText: $checkedConvert('altText', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DiscuitImageToJson(_DiscuitImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'format': instance.format,
      'mimetype': instance.mimetype,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'averageColor': instance.averageColor,
      'url': instance.url,
      'copies': instance.copies,
      'altText': instance.altText,
    };

_ImageCopy _$ImageCopyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ImageCopy', json, ($checkedConvert) {
      final val = _ImageCopy(
        name: $checkedConvert('name', (v) => v as String?),
        width: $checkedConvert('width', (v) => (v as num).toInt()),
        height: $checkedConvert('height', (v) => (v as num).toInt()),
        boxWidth: $checkedConvert('boxWidth', (v) => (v as num).toInt()),
        boxHeight: $checkedConvert('boxHeight', (v) => (v as num).toInt()),
        objectFit: $checkedConvert('objectFit', (v) => v as String),
        format: $checkedConvert('format', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ImageCopyToJson(_ImageCopy instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'boxWidth': instance.boxWidth,
      'boxHeight': instance.boxHeight,
      'objectFit': instance.objectFit,
      'format': instance.format,
      'url': instance.url,
    };
