import 'package:json_annotation/json_annotation.dart';

part 'uploaded_image.g.dart';

@JsonSerializable()
class UploadedImage {
  UploadedImage(
    this.id,
    this.width,
    this.height,
    this.size,
    this.url,
  );

  final String id;
  final int width;
  final int height;
  final int size;
  final String url;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double? calculatedLinkImageRatio;

  factory UploadedImage.fromJson(Map<String, dynamic> json) =>
      _$UploadedImageFromJson(json);
}
