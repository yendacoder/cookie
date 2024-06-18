import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:cookie/api/model/comment.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class CommentGif extends StatefulWidget {
  const CommentGif({super.key, required this.comment});

  final Comment comment;

  @override
  State<CommentGif> createState() => _CommentGifState();
}

class _CommentGifState extends State<CommentGif> {
  final _controller = GifController(autoPlay: false);
  bool _isFailed = false;
  Uint8List? _gifData;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchOgImage();
  }

  /// Loads binary content of the image.
  /// Sometimes the link may look like an image url, but
  /// it has an html page behind it instead.
  /// If [mayParseHtml] is true, the method will try to get the
  /// real image url from the og:image tag and call itself
  /// again to get the actual image.
  /// If og:image tag is found, the gifUri in comment will be updated
  /// to avoid the same loop again.
  void _fetchOgImage({bool mayParseHtml = true}) async {
    try {
      final uri = widget.comment.gifUri!;
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('text/html') == true) {
          if (mayParseHtml) {
            var document = parse(response.body);
            final metas = document.querySelectorAll('meta');
            for (final meta in metas) {
              if (meta.attributes['property'] == 'og:image') {
                widget.comment.gifUri = Uri.parse(meta.attributes['content']!);
                _fetchOgImage(mayParseHtml: false);
                return;
              }
            }
          }
          // no image candidate found
          if (mounted) {
            setState(() {
              _isFailed = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _gifData = response.bodyBytes;
            });
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFailed = true;
        });
      }
    }
  }

  Widget _buildPlaceholder(BuildContext context, IconData icon) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 8.0),
      child: TappableItem(
        onTap: () =>
            _controller.isPlaying ? _controller.stop() : _controller.play(),
        child: SizedBox(
          height: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultCornerRadius),
            child: _gifData == null
                ? _buildPlaceholder(
                    context, _isFailed ? Icons.error : Icons.hourglass_bottom)
                : GifView.memory(
                    _gifData!,
                    controller: _controller,
                    onError: (e) {
                      return _buildPlaceholder(context, Icons.error);
                    },
                    progress:
                        _buildPlaceholder(context, Icons.hourglass_bottom),
                  ),
          ),
        ),
      ),
    );
  }
}
