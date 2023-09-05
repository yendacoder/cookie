import 'package:auto_route/auto_route.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/settings_image.dart';
import 'package:cookie/common/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

@RoutePage()
class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: FlatAppBar(),
        body: SizedBox.expand(
          child: Hero(
            tag: url,
            child: InteractiveViewer(
              child: SettingsImage(
                url: url,
                isRelativeUrl: !isAbsoluteUrl(url),
              ),
            ),
          ),
        ));
  }
}
