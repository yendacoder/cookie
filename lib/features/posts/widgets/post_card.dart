import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/utils/relative_time.dart';
import '../../../models/discuit_image.dart';
import '../../../models/post.dart';
import '../../voting/providers/voting_provider.dart';
import '../screens/image_viewer_screen.dart';
import 'post_image_carousel.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, required this.onTap});

  final Post post;
  final VoidCallback onTap;

  static String heroTag(String postId) => 'post-image-$postId';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tappable area — navigates to post detail.
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PostHeader(post: post),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                _PostContent(post: post),
              ],
            ),
          ),
        ),
        // Footer sits outside InkWell — no gesture conflict with vote taps.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: _PostFooter(post: post),
        ),
      ],
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _PostHeader extends StatelessWidget {
  const _PostHeader({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      children: [
        _Avatar(
          imageUrl: post.author?.proPic?.fullUrl,
          fallback: post.username,
          radius: 10,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            post.username,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: muted),
            overflow: .ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          post.communityName,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: muted),
          overflow: .ellipsis,
        ),
        const SizedBox(width: 6),
        _Avatar(
          imageUrl: post.communityProPic?.fullUrl,
          fallback: post.communityName,
          radius: 10,
        ),
      ],
    );
  }
}

// ── Content ───────────────────────────────────────────────────────────────────

class _PostContent extends StatelessWidget {
  const _PostContent({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return switch (post.type) {
      'image' => _ImageContent(post: post),
      'link' => _LinkContent(post: post),
      'text' when (post.body ?? '').isNotEmpty => _TextContent(
        body: post.body!,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _ImageContent extends StatelessWidget {
  const _ImageContent({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final images = post.images.isNotEmpty
        ? post.images
        : (post.image != null ? [post.image!] : null);
    if (images == null) return const SizedBox.shrink();

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PostImageCarousel(
          images: images,
          fit: BoxFit.contain,
          onTap: (index) => context.push(
            '/image-viewer',
            extra: ImageViewerArgs(images: images, initialIndex: index),
          ),
        ),
      ),
    );

    // Hero only for single-image posts — a multi-image carousel may be on a
    // different page in the card vs the detail, causing a visual mismatch.
    if (images.length == 1) {
      content = Hero(tag: PostCard.heroTag(post.id), child: content);
    }

    return Padding(padding: const EdgeInsets.only(top: 8), child: content);
  }
}

class _LinkContent extends StatelessWidget {
  const _LinkContent({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final link = post.link;
    if (link == null) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.link_rounded,
                    size: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      link.hostname,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: .ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (link.image != null) ...[
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox.square(
                dimension: 72,
                child: CachedNetworkImage(
                  imageUrl: link.image!.fullUrl,
                  fit: .cover,
                  placeholder: (_, _) => _ImagePlaceholder(color: link.image?.averageColorValue),
                  errorWidget: (_, _, _) => _ImagePlaceholder(color: link.image?.averageColorValue),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TextContent extends StatelessWidget {
  const _TextContent({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        body,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        maxLines: 3,
        overflow: .ellipsis,
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _PostFooter extends ConsumerWidget {
  const _PostFooter({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vs = ref.watch(postVotesProvider)[post.id];
    final userVoted = vs?.userVoted ?? post.userVoted;
    final userVotedUp = vs?.userVotedUp ?? post.userVotedUp;
    final upvotes = vs?.upvotes ?? post.upvotes;
    final downvotes = vs?.downvotes ?? post.downvotes;

    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.onSurfaceVariant;
    final base = Theme.of(context).textTheme.labelSmall?.copyWith(color: muted);

    final votedUp = userVoted == true && userVotedUp == true;
    final votedDown = userVoted == true && userVotedUp == false;
    final showUpSpinner = vs?.isLoading == true && vs?.pendingVoteUp == true;
    final showDownSpinner = vs?.isLoading == true && vs?.pendingVoteUp == false;

    final score = upvotes - downvotes;
    final scoreColor = votedUp
        ? colorScheme.primary
        : votedDown
            ? colorScheme.error
            : muted;

    return Row(
      children: [
        _VoteButton(
          icon: Icons.arrow_upward_rounded,
          size: 14,
          isActive: votedUp,
          activeColor: colorScheme.primary,
          showSpinner: showUpSpinner,
          muted: muted,
          onTap: () => ref.read(postVotesProvider.notifier).vote(post, true),
        ),
        const SizedBox(width: 4),
        Text('$score', style: base?.copyWith(color: scoreColor)),
        const SizedBox(width: 4),
        _VoteButton(
          icon: Icons.arrow_downward_rounded,
          size: 14,
          isActive: votedDown,
          activeColor: colorScheme.error,
          showSpinner: showDownSpinner,
          muted: muted,
          onTap: () => ref.read(postVotesProvider.notifier).vote(post, false),
        ),
        const SizedBox(width: 12),
        Icon(Icons.mode_comment_outlined, size: 14, color: muted),
        const SizedBox(width: 2),
        Text('${post.noComments}', style: base),
        const Spacer(),
        Text(post.createdAt.toRelativeString(context.l10n), style: base),
      ],
    );
  }
}

class _VoteButton extends StatelessWidget {
  const _VoteButton({
    required this.icon,
    required this.size,
    required this.isActive,
    required this.activeColor,
    required this.showSpinner,
    required this.muted,
    required this.onTap,
  });

  final IconData icon;
  final double size;
  final bool isActive;
  final Color activeColor;
  final bool showSpinner;
  final Color muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: showSpinner ? null : onTap,
      child: showSpinner
          ? SizedBox.square(
              dimension: size,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: muted),
            )
          : Icon(icon, size: size, color: isActive ? activeColor : muted),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.fallback, required this.radius, this.imageUrl});

  final String? imageUrl;
  final String fallback;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initial = fallback.isNotEmpty ? fallback[0].toUpperCase() : '?';
    final size = radius * 2;

    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      child: imageUrl != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: .cover,
                placeholder: (_, _) => const SizedBox.shrink(),
                errorWidget: (_, _, _) => _Initials(
                  initial: initial,
                  radius: radius,
                  colorScheme: colorScheme,
                ),
              ),
            )
          : _Initials(
              initial: initial,
              radius: radius,
              colorScheme: colorScheme,
            ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({
    required this.initial,
    required this.radius,
    required this.colorScheme,
  });

  final String initial;
  final double radius;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      initial,
      style: TextStyle(
        fontSize: radius * 0.9,
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color ?? Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}
