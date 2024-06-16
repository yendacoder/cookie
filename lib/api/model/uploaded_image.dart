import 'package:json_annotation/json_annotation.dart';

import 'color.dart';

part 'uploaded_image.g.dart';

@JsonSerializable()
class UploadedImage {
  UploadedImage(
    this.id,
    this.type,
    this.width,
    this.maxWidth,
    this.height,
    this.maxHeight,
    this.size,
    this.averageColor,
    this.url,
    this.urls,
    // this.copies,
    this.createdAt,
    this.deleted,
  );

  final String id;
  final String type;
  final int width;
  final int maxWidth;
  final int height;
  final int maxHeight;
  final int size;
  final Color averageColor;
  final String url;
  final List<String> urls;
  // Image copy object is different, let's skip it for now
  // final List<ImageCopy> copies;
  final DateTime createdAt;
  final bool deleted;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double? calculatedLinkImageRatio;

  factory UploadedImage.fromJson(Map<String, dynamic> json) =>
      _$UploadedImageFromJson(json);
}
