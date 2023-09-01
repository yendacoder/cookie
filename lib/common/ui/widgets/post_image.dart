import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/link.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/util/string_util.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/app_config.dart';
import 'package:cookie/settings/consts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cookie/api/model/image.dart' as api_img;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key, this.image, this.link})
      : assert(image != null || link != null,
            'Either image or link must be provided');

  final api_img.Image? image;
  final Link? link;

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
  Widget _buildLinkImage(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(link!.url);
    final image = _initSizedImage(context, link!.image!, false);

    return TappableItem(
      onTap: () {
        if (videoId != null) {
          context.router.push(YoutubeRoute(videoId: videoId, url: link!.url));
        } else if (link?.hostname != null) {
          launchUrlString(link!.url, mode: LaunchMode.externalApplication);
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          image,
          if (link?.hostname != null)
            Padding(
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
  Widget _initSizedImage(
      BuildContext context, api_img.Image image, bool tryFallback) {
    final url = isAbsoluteUrl(image.url)
        ? image.url
        : AppConfigProvider.of(context).getFullImageUrl(image.url);
    Image imageWidget = Image(
      fit: BoxFit.contain,
      image: CachedNetworkImageProvider(url),
      errorBuilder: (_, url, ___) {
        log('Failed to load image from $url');
        if (tryFallback && link != null) {
          return _buildLinkImage(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
    if (image.calculatedLinkImageRatio != null) {
      return AspectRatio(
        aspectRatio: image.calculatedLinkImageRatio!,
        child: imageWidget,
      );
    }
    Completer<double> completer = Completer();
    imageWidget.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var actualImage = image.image;
          completer.complete(actualImage.width.toDouble() / actualImage.height);
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
      child: SizedBox(
          width: double.infinity,
          child: _canTryInline
              ? _initSizedImage(context, img!, true)
              : _buildLinkImage(context)),
    );
  }
}
