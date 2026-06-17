import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/theme/app_theme.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/avatar.dart';
import 'package:cookie/core/widgets/markdown_text.dart';
import 'package:cookie/core/widgets/youtube_content.dart';
import 'package:cookie/features/voting/providers/voting_provider.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../screens/image_viewer_screen.dart';
import 'post_card.dart';
import 'post_image_carousel.dart';

// ── Post body ─────────────────────────────────────────────────────────────────

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({
    super.key,
    required this.post,
    required this.heroTagScope,
  });

  final Post post;
  final HeroTagScope heroTagScope;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _PostMeta(post: post),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectableText(
            post.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _PostDetailContent(post: post, heroTagScope: heroTagScope),
        ),
        _PostDetailFooter(post: post),
        const AdaptiveDivider(),
      ],
    );
  }
}

class _PostMeta extends StatelessWidget {
  const _PostMeta({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final style = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: muted);

    return AdaptiveInkWell(
      onTap: () => context.push('/u/${post.username}'),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Avatar(
            imageUrl: post.author?.proPic?.fullUrl,
            fallback: post.username,
            radius: 10,
          ),
          SizedBox(width: 6),
          Text(post.username, style: style),
          Text('  ·  ', style: style),
          Text(post.createdAt.toRelativeString(context.l10n), style: style),
          Spacer(),
          if (post.isPinned) ...[
            SizedBox(width: 12),
            Icon(
              Icons.push_pin,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          if (post.locked) ...[
            SizedBox(width: 12),
            Icon(
              Icons.lock,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Type-specific content ─────────────────────────────────────────────────────

class _PostDetailContent extends StatelessWidget {
  const _PostDetailContent({required this.post, required this.heroTagScope});

  final Post post;
  final HeroTagScope heroTagScope;

  @override
  Widget build(BuildContext context) {
    return switch (post.type) {
      'image' => _DetailImage(post: post, heroTagScope: heroTagScope),
      'link' => _DetailLink(post: post),
      'text' when (post.body ?? '').isNotEmpty => _DetailText(body: post.body!),
      _ => const SizedBox.shrink(),
    };
  }
}

class _DetailImage extends StatefulWidget {
  const _DetailImage({required this.post, required this.heroTagScope});

  final Post post;
  final HeroTagScope heroTagScope;

  static double _containerRatio(List<DiscuitImage> images) => images
      .map((img) => img.width / img.height)
      .reduce((a, b) => a < b ? a : b);

  @override
  State<_DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<_DetailImage> {
  @override
  Widget build(BuildContext context) {
    final images = widget.post.images.isNotEmpty
        ? widget.post.images
        : (widget.post.image != null ? [widget.post.image!] : null);
    if (images == null) return const SizedBox.shrink();

    Widget carousel = AspectRatio(
      aspectRatio: _DetailImage._containerRatio(images),
      child: PostImageCarousel(
        images: images,
        fit: BoxFit.contain,
        onTap: (index) => context.push(
          '/image-viewer',
          extra: ImageViewerArgs(images: images, initialIndex: index),
        ),
      ),
    );

    if (images.length == 1) {
      carousel = Hero(
        tag: PostCard.heroTag(widget.post.id, widget.heroTagScope),
        child: carousel,
      );
    }
    return carousel;
  }
}

class _DetailLink extends StatelessWidget {
  const _DetailLink({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final link = post.link;
    if (link == null) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final youtubeId = YoutubePlayerController.convertUrlToId(link.url);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveInkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => launchUrl(
            Uri.parse(link.url),
            mode: LaunchMode.externalApplication,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.link_rounded, size: 14, color: colorScheme.primary),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    link.url,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colorScheme.primary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (youtubeId != null)
          YoutubeContent(fullUrl: link.url, videoId: youtubeId)
        else if (link.image != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AdaptiveInkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => launchUrl(
                Uri.parse(link.url),
                mode: LaunchMode.externalApplication,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: link.image!.fullUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, _) =>
                        Container(color: colorScheme.surfaceContainerHighest),
                    errorWidget: (_, _, _) =>
                        Container(color: colorScheme.surfaceContainerHighest),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DetailText extends StatelessWidget {
  const _DetailText({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    return MarkdownText(body, selectable: true);
  }
}

// ── Post footer (votes + comments count) ─────────────────────────────────────

class _PostDetailFooter extends ConsumerWidget {
  const _PostDetailFooter({required this.post});

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
    final style = Theme.of(
      context,
    ).textTheme.labelMedium?.copyWith(color: muted);

    final votedUp = userVoted == true && userVotedUp == true;
    final votedDown = userVoted == true && userVotedUp == false;
    final showUpSpinner = vs?.isLoading == true && vs?.pendingVoteUp == true;
    final showDownSpinner = vs?.isLoading == true && vs?.pendingVoteUp == false;

    final score = upvotes - downvotes;
    final scoreColor = votedUp
        ? AppTheme.kUpvoteColor
        : votedDown
        ? AppTheme.kDownvoteColor
        : muted;

    final total = upvotes + downvotes;
    final pct = total > 0 ? (upvotes / total * 100).round() : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 0),
      child: Row(
        children: [
          _DetailVoteButton(
            icon: Icons.arrow_upward_rounded,
            isActive: votedUp,
            activeColor: AppTheme.kUpvoteColor,
            showSpinner: showUpSpinner,
            muted: muted,
            onTap: () => ref.read(postVotesProvider.notifier).vote(post, true),
          ),
          Text('$score', style: style?.copyWith(color: scoreColor)),
          _DetailVoteButton(
            icon: Icons.arrow_downward_rounded,
            isActive: votedDown,
            activeColor: AppTheme.kDownvoteColor,
            showSpinner: showDownSpinner,
            muted: muted,
            onTap: () => ref.read(postVotesProvider.notifier).vote(post, false),
          ),
          if (pct != null) ...[
            const SizedBox(width: 6),
            Text('$pct%', style: style),
            const SizedBox(width: 6),
          ],
          const SizedBox(width: 10),
          Icon(Icons.mode_comment_outlined, size: 16, color: muted),
          const SizedBox(width: 6),
          Text(context.l10n.commentsLabel(post.noComments), style: style),
          const Spacer(),
          AdaptiveInkWell(
            onTap: () => SharePlus.instance.share(
              ShareParams(uri: post.postWebUrl, subject: post.title),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(context.shareIcon, size: 14, color: muted),
                  const SizedBox(width: 6),
                  Text(context.l10n.share, style: style),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailVoteButton extends StatelessWidget {
  const _DetailVoteButton({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.showSpinner,
    required this.muted,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final bool showSpinner;
  final Color muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AdaptiveInkWell(
      onTap: showSpinner ? null : onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: EdgeInsetsGeometry.all(6),
        child: showSpinner
            ? SizedBox.square(
                dimension: 16,
                child: AdaptiveProgressIndicator(
                  strokeWidth: 1.5,
                  color: muted,
                ),
              )
            : Icon(icon, size: 16, color: isActive ? activeColor : muted),
      ),
    );
  }
}
