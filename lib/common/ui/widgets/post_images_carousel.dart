import 'package:cookie/common/ui/widgets/common/page_indicator.dart';
import 'package:cookie/common/ui/widgets/post_image.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cookie/api/model/image.dart' as api_img;

class PostImagesCarousel extends StatefulWidget {
  const PostImagesCarousel(
      {super.key,
      required this.images,
      this.aspectRatio,
      this.previewOnTap = false});

  final List<api_img.Image> images;
  final double? aspectRatio;
  final bool previewOnTap;

  @override
  State<PostImagesCarousel> createState() => _PostImagesCarouselState();
}

class _PostImagesCarouselState extends State<PostImagesCarousel> {
  late final PageController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = PageController(initialPage: widget.images.length * 10000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.length == 1) {
      return PostImage(
        image: widget.images.first,
        aspectRatio: widget.aspectRatio,
        previewOnTap: widget.previewOnTap,
      );
    }
    final aspectRatio = widget.aspectRatio ??
        widget.images.map((image) => image.width / image.height).fold(
            double.maxFinite, (prev, current) => math.min(prev!, current));
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultCornerRadius),
            child: AspectRatio(
                aspectRatio: aspectRatio!,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (_) => setState(() {}),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return PostImage(
                      image: widget.images[itemIndex % widget.images.length],
                      aspectRatio: widget.aspectRatio,
                      previewOnTap: widget.previewOnTap,
                      borderRadius: null,
                    );
                  },
                ))),
        Positioned(
          bottom: 12.0,
          left: 0.0,
          right: 0.0,
          child: PageIndicator(
            pagesCount: widget.images.length,
            currentPage: _controller.hasClients
                ? (_controller.page?.round() ?? 0) % widget.images.length
                : 0,
            pageController: _controller,
          ),
        ),
      ],
    );
  }
}
