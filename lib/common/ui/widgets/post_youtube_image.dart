import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostYoutubeImage extends StatefulWidget {
  const PostYoutubeImage({super.key, required this.post, this.aspectRatio});

  final Post post;
  final double? aspectRatio;

  @override
  State<PostYoutubeImage> createState() => _PostYoutubeImageState();
}

class _PostYoutubeImageState extends State<PostYoutubeImage> {
  String get _url => widget.post.link!.url;

  double? get _nativeAspectRatio {
    if (widget.post.youtubeMeta == null) {
      return null;
    }
    try {
      final double? width =
          widget.post.youtubeMeta!['thumbnail_width'] as double?;
      final double? height =
          widget.post.youtubeMeta!['thumbnail_height'] as double?;
      if (width == null || height == null) {
        return null;
      }
      return width / height;
    } catch (e) {
      return null;
    }
  }

  String? get _thumbnailUrl {
    if (widget.post.youtubeMeta == null) {
      return null;
    }
    return widget.post.youtubeMeta!['thumbnail_url'] as String?;
  }

  String? get _author {
    if (widget.post.youtubeMeta == null) {
      return null;
    }
    return widget.post.youtubeMeta!['author_name'] as String?;
  }

  @override
  void initState() {
    super.initState();
    if (widget.post.youtubeMeta == null) {
      _loadYoutubeMeta();
    }
  }

  void _loadYoutubeMeta() async {
    final videoId = YoutubePlayer.convertUrlToId(_url);
    if (videoId == null) {
      return;
    }
    final url =
        'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$videoId&format=json';
    try {
      final data = await http.get(Uri.parse(url));
      if (data.statusCode == 200) {
        setState(() {
          widget.post.youtubeMeta = json.decode(data.body);
        });
      }
    } catch (e) {
      // do nothing
    }
  }

  Widget _buildImage(BuildContext context) {
    if (_thumbnailUrl == null) {
      return const SizedBox.shrink();
    }
    final initial = Provider.of<InitialController>(context, listen: false);

    final cached = !initial.disableImageCache;
    Image imageWidget = Image(
      fit: BoxFit.contain,
      image: ExtendedNetworkImageProvider(_thumbnailUrl!, cache: cached),
    );
    final nativeAspectRatio = _nativeAspectRatio;
    if (widget.aspectRatio != null || nativeAspectRatio != null) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio ?? nativeAspectRatio!,
        child: imageWidget,
      );
    }
    return imageWidget;
  }

  /// External images, like fetched from og tags
  Widget _buildContent(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(_url);
    final link = widget.post.link;

    return TappableItem(
      onTap: () {
        if (videoId != null) {
          context.router.push(YoutubeRoute(videoId: videoId, url: _url));
        }
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          _buildImage(context),
          Positioned(
            right: 8.0,
            top: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(4.0),
                  child: IconText(
                    icon: Icons.ondemand_video,
                    text: link!.hostname!,
                    iconPadding: 4.0,
                  ),
                ),
                if (_author != null)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(4.0)),
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(top: 4.0),
                    child: IconText(
                      icon: Icons.person,
                      text: _author,
                      iconPadding: 4.0,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultCornerRadius),
      child: Container(
          color: Theme.of(context).colorScheme.surface,
          width: double.infinity,
          child: _buildContent(context)),
    );
  }
}
