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

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}