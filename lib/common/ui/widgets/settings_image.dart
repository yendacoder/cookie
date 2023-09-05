import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/settings/app_config.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Image widget that respects global settings
class SettingsImage extends StatelessWidget {
  const SettingsImage(
      {super.key, this.fit, this.isRelativeUrl = true, required this.url});

  final bool isRelativeUrl;
  final String url;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = isRelativeUrl
        ? AppConfigProvider.of(context).getFullImageUrl(url)
        : url;
    final cached = !Provider.of<InitialController>(context, listen: false)
        .disableImageCache;
    return ExtendedImage.network(
      imageUrl,
      fit: fit,
      cache: cached,
    );
  }
}
