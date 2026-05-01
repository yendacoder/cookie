import 'package:freezed_annotation/freezed_annotation.dart';

part 'discuit_image.freezed.dart';
part 'discuit_image.g.dart';

@freezed
abstract class DiscuitImage with _$DiscuitImage {
  const factory DiscuitImage({
    required String id,
    required String format,
    required String mimetype,
    required int width,
    required int height,
    required int size,
    String? averageColor,
    required String url,
    @Default([]) List<ImageCopy> copies,
  }) = _DiscuitImage;

  factory DiscuitImage.fromJson(Map<String, dynamic> json) =>
      _$DiscuitImageFromJson(json);
}

@freezed
abstract class ImageCopy with _$ImageCopy {
  const factory ImageCopy({
    String? name,
    required int width,
    required int height,
    required int boxWidth,
    required int boxHeight,
    required String objectFit,
    required String format,
    required String url,
  }) = _ImageCopy;

  factory ImageCopy.fromJson(Map<String, dynamic> json) =>
      _$ImageCopyFromJson(json);
}
