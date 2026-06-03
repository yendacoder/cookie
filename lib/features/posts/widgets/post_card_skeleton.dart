import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:flutter/material.dart';

/// Wraps [child] in a repeating fade so all skeleton elements inside pulse
/// in sync from a single animation controller.
class SkeletonPulse extends StatefulWidget {
  const SkeletonPulse({super.key, required this.child});

  final Widget child;

  @override
  State<SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<SkeletonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      lowerBound: 0.4,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _controller, child: widget.child);
}

// ── Internal helper ───────────────────────────────────────────────────────────

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height, this.width, this.radius = 4.0});

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(width: width ?? double.infinity, height: height),
    );
  }
}

// ── Post card skeleton ────────────────────────────────────────────────────────

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key, this.showCommunity = true});

  final bool showCommunity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  _SkeletonBox(height: 20, width: 20, radius: 10),
                  const SizedBox(width: 6),
                  _SkeletonBox(height: 10, width: 80),
                  const Spacer(),
                  if (showCommunity) ...[
                    _SkeletonBox(height: 10, width: 60),
                    const SizedBox(width: 6),
                    _SkeletonBox(height: 20, width: 20, radius: 10),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              // Title — two lines
              _SkeletonBox(height: 14),
              const SizedBox(height: 5),
              _SkeletonBox(height: 14, width: 220),
              const SizedBox(height: 8),
              // Image area placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _SkeletonBox(height: double.infinity),
                ),
              ),
            ],
          ),
        ),
        // Footer row
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              _SkeletonBox(height: 14, width: 14),
              const SizedBox(width: 4),
              _SkeletonBox(height: 10, width: 24),
              const SizedBox(width: 4),
              _SkeletonBox(height: 14, width: 14),
              const SizedBox(width: 12),
              _SkeletonBox(height: 14, width: 14),
              const SizedBox(width: 4),
              _SkeletonBox(height: 10, width: 40),
              const Spacer(),
              _SkeletonBox(height: 10, width: 56),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Comment card skeleton ─────────────────────────────────────────────────────

class CommentCardSkeleton extends StatelessWidget {
  const CommentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SkeletonBox(height: 10, width: 64),
              const SizedBox(width: 6),
              _SkeletonBox(height: 10, width: 40),
            ],
          ),
          const SizedBox(height: 6),
          _SkeletonBox(height: 12),
          const SizedBox(height: 4),
          _SkeletonBox(height: 12, width: 180),
          const SizedBox(height: 8),
          Row(
            children: [
              _SkeletonBox(height: 12, width: 12),
              const SizedBox(width: 4),
              _SkeletonBox(height: 10, width: 20),
              const SizedBox(width: 4),
              _SkeletonBox(height: 12, width: 12),
            ],
          ),
        ],
      ),
    );
  }
}

// ── List wrappers ─────────────────────────────────────────────────────────────

/// Pulsing list of [PostCardSkeleton] items. Suitable as a body or inside
/// a [SliverToBoxAdapter].
class PostFeedSkeleton extends StatelessWidget {
  const PostFeedSkeleton({
    super.key,
    this.showCommunity = true,
    this.count = 5,
  });

  final bool showCommunity;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SkeletonPulse(
        child: Column(
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) const SizedBox(height: 32),
              PostCardSkeleton(showCommunity: showCommunity),
            ],
          ],
        ),
      ),
    );
  }
}

/// Pulsing list of [CommentCardSkeleton] items.
class CommentListSkeleton extends StatelessWidget {
  const CommentListSkeleton({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonPulse(
      child: Column(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const AdaptiveDivider(height: 1),
            CommentCardSkeleton(),
          ],
        ],
      ),
    );
  }
}
