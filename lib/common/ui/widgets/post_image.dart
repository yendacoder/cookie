import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/link.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
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
    if (link == null) return false;
    try {
      final path = Uri.parse(link!.url).path.toLowerCase();
      return path.endsWith('.png') ||
          path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.webp');
    } catch (e) {
      return false;
    }
  }

  Widget _buildHostedImage(BuildContext context, api_img.Image img) {
    final videoId = YoutubePlayer.convertUrlToId(link!.url);
    final image = _initSizedImage(
        context, AppConfigProvider.of(context).getFullImageUrl(img.url), false);

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

  void _cacheImageRatio(Completer<double> completer) async {
    final ratio = await completer.future;
    link?.calculatedLinkImageRatio = ratio;
  }

  /// Image dimensions provided by API are incorrect
  /// We will cache the proportions of the actual image received
  /// so that when scrolling up, the list doesn't flicker
  Widget _initSizedImage(BuildContext context, String url, bool withFallback) {
    Image imageWidget = Image(
      fit: BoxFit.contain,
      image: CachedNetworkImageProvider(url),
      errorBuilder: (_, url, ___) {
        log('Failed to load image from $url');
        if (withFallback) {
          return _buildHostedImage(context, link!.image!);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
    if (link!.calculatedLinkImageRatio != null) {
      return AspectRatio(
        aspectRatio: link!.calculatedLinkImageRatio!,
        child: imageWidget,
      );
    }
    Completer<double> completer = Completer();
    imageWidget.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          completer.complete(myImage.width.toDouble() / myImage.height);
        },
      ),
    );
    _cacheImageRatio(completer);
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
              ? _initSizedImage(context, link!.url, true)
              : _buildHostedImage(context, img!)),
    );
  }
}
