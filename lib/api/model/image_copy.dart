import 'package:json_annotation/json_annotation.dart';

part 'image_copy.g.dart';

@JsonSerializable()
class ImageCopy {
  const ImageCopy(
      this.copyId,
      this.width,
      this.height,
      this.size,
      this.url,
      this.objectFit,
      );

  final String copyId;
  final int width;
  final int height;
  final int size;
  final String url;
  final String objectFit;

  factory ImageCopy.fromJson(Map<String, dynamic> json) => _$ImageCopyFromJson(json);
}