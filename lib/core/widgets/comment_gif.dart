import 'dart:typed_data';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class CommentGif extends StatefulWidget {
  const CommentGif({super.key, required this.gifUri});

  final Uri gifUri;

  @override
  State<CommentGif> createState() => _CommentGifState();
}

class _CommentGifState extends State<CommentGif> {
  final _controller = GifController();
  bool _isFailed = false;
  late Uri _gifUri;
  Uint8List? _gifData;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _gifUri = widget.gifUri;
    _fetchOgImage();
    super.initState();
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
      final response = await http.get(_gifUri);
      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('text/html') == true) {
          if (mayParseHtml) {
            var document = parse(response.body);
            final metas = document.querySelectorAll('meta');
            for (final meta in metas) {
              if (meta.attributes['property'] == 'og:image') {
                _gifUri = Uri.parse(meta.attributes['content']!);
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
        decoration: BoxDecoration(color: Theme.of(context).disabledColor),
        child: Center(child: Icon(icon)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () =>
            _controller.isPlaying ? _controller.stop() : _controller.play(),
        child: SizedBox(
          height: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: _gifData == null
                ? _buildPlaceholder(
                    context,
                    _isFailed ? Icons.error : Icons.hourglass_bottom,
                  )
                : GifView.memory(
                    _gifData!,
                    autoPlay: false,
                    controller: _controller,
                    errorBuilder: (_, _, _) =>
                        _buildPlaceholder(context, Icons.error),
                    progressBuilder: (_) =>
                        _buildPlaceholder(context, Icons.hourglass_bottom),
                  ),
          ),
        ),
      ),
    );
  }
}
