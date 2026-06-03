import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cookie/models/discuit_image.dart';

class PostImageCarousel extends StatefulWidget {
  const PostImageCarousel({
    super.key,
    required this.images,
    this.fit = BoxFit.cover,
    this.onTap,
    this.onPageChanged,
  });

  final List<DiscuitImage> images;
  final BoxFit fit;

  /// Called with the visible page index when the user taps the image area.
  /// The inner GestureDetector intercepts the tap before any outer InkWell.
  final void Function(int currentIndex)? onTap;

  /// Called whenever the visible page changes (0-based index into [images]).
  final ValueChanged<int>? onPageChanged;

  @override
  State<PostImageCarousel> createState() => _PostImageCarouselState();
}

class _PostImageCarouselState extends State<PostImageCarousel> {
  late final PageController _controller;
  int _page = 0;

  // Start at a large offset so left-swipe from the first image wraps to the
  // last. The modulo in itemBuilder maps every index to an actual image.
  static int _initialPage(int count) => count > 1 ? count * 100 : 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: _initialPage(widget.images.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.images.length;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: widget.onTap != null ? () => widget.onTap!(_page) : null,
          child: PageView.builder(
            controller: _controller,
            // null = infinite scroll; 1 = no swiping for a single image.
            itemCount: count > 1 ? null : 1,
            onPageChanged: (i) {
              final page = i % count;
              setState(() => _page = page);
              widget.onPageChanged?.call(page);
            },
            itemBuilder: (context, i) {
              final image = widget.images[i % count];
              final bg =
                  image.averageColorValue ??
                  Theme.of(context).colorScheme.surfaceContainerHighest;
              return LayoutBuilder(
                builder: (context, constraints) {
                  final url = image.bestUrl(
                    constraints.maxWidth,
                    MediaQuery.devicePixelRatioOf(context),
                  );
                  return ColoredBox(
                    color: bg,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: widget.fit,
                      // ColoredBox already provides the background while loading.
                      placeholder: (_, _) => const SizedBox.expand(),
                      errorWidget: (_, _, _) => const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (count > 1) ...[
          // Gradient scrim so the indicator is legible on any image.
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x66000000)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            child: _PageIndicator(current: _page, count: count),
          ),
        ],
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: i == current ? 16 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: i == current
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
