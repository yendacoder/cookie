import 'package:flutter/material.dart' show Color;
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
    String? altText,
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

extension DiscuitImageExt on DiscuitImage {
  /// Full-resolution URL, prepending the Discuit host for server-relative paths.
  String get fullUrl => _resolveUrl(url);

  /// Parses the server's `"rgb(r, g, b)"` average-color string into a Color.
  /// Returns null when the field is absent or unparseable.
  Color? get averageColorValue {
    final s = averageColor;
    if (s == null) return null;
    final m = RegExp(
      r'rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)',
    ).firstMatch(s);
    if (m == null) return null;
    return Color.fromRGBO(
      int.parse(m.group(1)!),
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
      1.0,
    );
  }

  /// Returns the URL of the smallest copy whose pixel width is at least
  /// [targetWidth] × [devicePixelRatio], i.e. the tightest fit that still
  /// renders sharply at the given display size.
  ///
  /// Falls back to [fullUrl] when no copy is large enough or [copies] is empty.
  String bestUrl(double targetWidth, double devicePixelRatio) {
    if (copies.isEmpty) return fullUrl;

    final physicalTarget = (targetWidth * devicePixelRatio).ceil();

    // Candidates: copies at least as wide as the physical pixel target.
    // Sort ascending so we pick the smallest sufficient copy.
    final candidates = copies
        .where((c) => c.width >= physicalTarget)
        .toList()
      ..sort((a, b) => a.width.compareTo(b.width));

    if (candidates.isNotEmpty) return _resolveUrl(candidates.first.url);

    // All copies are too small — use the original full-resolution image.
    return fullUrl;
  }
}

String _resolveUrl(String url) =>
    url.startsWith('http') ? url : 'https://discuit.org$url';
