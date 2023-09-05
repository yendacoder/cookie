import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/link.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/util/string_util.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/app_config.dart';
import 'package:cookie/settings/consts.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:cookie/api/model/image.dart' as api_img;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostImage extends StatelessWidget {
  const PostImage(
      {super.key,
      this.image,
      this.link,
      this.aspectRatio,
      this.previewOnTap = false})
      : assert(image != null || link != null,
            'Either image or link must be provided');

  final api_img.Image? image;
  final Link? link;
  final double? aspectRatio;
  final bool previewOnTap;

  bool get _canTryInline {
    if (image != null) return true;
    if (link == null) return false;
    try {
      return isImageUrl(Uri.parse(link!.url).path);
    } catch (e) {
      return false;
    }
  }

  /// External images, like fetched from og tags
  Widget _buildLinkImage(BuildContext context, {bool withTapHandler = true}) {
    final videoId = YoutubePlayer.convertUrlToId(link!.url);
    final image = _buildHostedImage(context, link!.image!, false);

    return TappableItem(
      onTap: withTapHandler
          ? () {
              if (videoId != null) {
                context.router
                    .push(YoutubeRoute(videoId: videoId, url: link!.url));
              } else if (link?.hostname != null) {
                launchUrlString(link!.url,
                    mode: LaunchMode.externalApplication);
              }
            }
          : null,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          image,
          if (link?.hostname != null)
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(4.0),
                  child: IconText(
                    icon: Icons.open_in_new,
                    text: link!.hostname!,
                    iconPadding: 4.0,
                  )),
            ),
        ],
      ),
    );
  }

  void _cacheImageRatio(
      api_img.Image image, Completer<double> completer) async {
    final ratio = await completer.future;
    image.calculatedLinkImageRatio = ratio;
  }

  /// Method for displaying full hosted images.
  /// Image dimensions provided by API are incorrect
  /// We will cache the proportions of the actual image received
  /// so that when scrolling up, the list doesn't flicker
  Widget _buildHostedImage(
      BuildContext context, api_img.Image image, bool tryFallback) {
    final url = isAbsoluteUrl(image.url)
        ? image.url
        : AppConfigProvider.of(context).getFullImageUrl(image.url);
    final cached = !Provider.of<InitialController>(context, listen: false)
        .disableImageCache;
    Image imageWidget = Image(
      fit: BoxFit.contain,
      image: ExtendedNetworkImageProvider(url, cache: cached),
      errorBuilder: (_, url, ___) {
        log('Failed to load image from $url');
        if (tryFallback && link != null) {
          return _buildLinkImage(context, withTapHandler: false);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
    if (aspectRatio != null || image.calculatedLinkImageRatio != null) {
      return AspectRatio(
        aspectRatio: aspectRatio ?? image.calculatedLinkImageRatio!,
        child: imageWidget,
      );
    }
    Completer<double> completer = Completer();
    imageWidget.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var imageData = image.image;
          if (!completer.isCompleted) {
            completer.complete(imageData.width.toDouble() / imageData.height);
          }
        },
      ),
    );
    _cacheImageRatio(image, completer);
    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    final img = image ?? link!.image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultCornerRadius),
      child: Container(
          color:
              img?.getAverageColor() ?? Theme.of(context).colorScheme.surface,
          width: double.infinity,
          child: _canTryInline
              ? previewOnTap
                  ? TappableItem(
                      child: Hero(
                          tag: img!.url,
                          child: _buildHostedImage(context, img, true)),
                      onTap: () {
                        context.router.push(ImagePreviewRoute(url: img.url));
                      },
                    )
                  : _buildHostedImage(context, img!, true)
              : _buildLinkImage(context)),
    );
  }
}
