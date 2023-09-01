import 'dart:developer';
import 'dart:ui';

import 'package:cookie/api/model/image_copy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  Image(
      this.mimetype,
      this.width,
      this.height,
      this.size,
      this.averageColor,
      this.url,
      this.copies,
      );

  final String mimetype;
  final int width;
  final int height;
  final int size;
  final String averageColor;
  final String url;
  final List<ImageCopy> copies;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double? calculatedLinkImageRatio;

  Color? getAverageColor() {
    try {
      final rgb = averageColor.substring(4, averageColor.length - 1).split(', ');
      return Color.fromARGB(255, int.parse(rgb[0]), int.parse(rgb[1]), int.parse(rgb[2]));
    } catch (e) {
      log('cannot parse color "$averageColor": $e');
      return null;
    }
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}