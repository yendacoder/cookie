import 'package:cookie/api/model/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {
  Link(
      this.url,
      this.hostname,
      this.image,
      );

  final String url;
  final String? hostname;
  final Image? image;

  double? calculatedLinkImageRatio;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}