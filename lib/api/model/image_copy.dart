import 'package:json_annotation/json_annotation.dart';

part 'image_copy.g.dart';

@JsonSerializable()
class ImageCopy {
  const ImageCopy(
      this.width,
      this.height,
      this.url,
      this.objectFit,
      );

  final int width;
  final int height;
  final String url;
  final String objectFit;

  factory ImageCopy.fromJson(Map<String, dynamic> json) => _$ImageCopyFromJson(json);
}