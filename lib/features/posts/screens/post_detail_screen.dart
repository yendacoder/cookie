import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../voting/providers/voting_provider.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/error_view.dart';
import '../../../models/comment.dart';
import '../../../models/discuit_image.dart';
import '../../../models/post.dart';
import 'package:go_router/go_router.dart';

import '../providers/post_detail_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/post_image_carousel.dart';
import 'image_viewer_screen.dart';

class PostDetailScreen extends ConsumerWidget {
  const PostDetailScreen({
    super.key,
    required this.communityName,
    required this.postId,
    this.initialPost,
  });

  final String communityName;
  final String postId;

  /// Pre-loaded post passed from the feed. When present, post content is shown
  /// immediately (enabling the hero transition) while the full detail — which
  /// includes comments — loads in the background.
  final Post? initialPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(postDetailProvider(postId));

    // Prefer the fully-loaded post; fall back to the initial post while loading.
    final post = detailState.value ?? initialPost;

    if (post == null) {
      // Deep-link / notification path: no initial data available.
      return Scaffold(
        appBar: AppBar(),
        body: detailState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(postDetailProvider(postId)),
          ),
          data: (_) => const SizedBox.shrink(), // unreachable — post != null
        ),
      );
    }

    return Scaffold(
      appBar: _PostAppBar(post: post),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _PostDetailBody(post: post),
          ),
          _CommentsSectionSliver(
            post: post,
            detailState: detailState,
            onRetry: () => ref.invalidate(postDetailProvider(postId)),
          ),
          // Bottom padding for system nav bar.
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _PostAppBar({required this.post});

  final Post post;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          if (post.communityProPic != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(post.communityProPic!.fullUrl),
              ),
            ),
          Flexible(
            child: Text(
              post.communityName,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Post body ─────────────────────────────────────────────────────────────────

class _PostDetailBody extends StatelessWidget {
  const _PostDetailBody({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostMeta(post: post),
          const SizedBox(height: 12),
          SelectableText(
            post.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _PostDetailContent(post: post),
          const SizedBox(height: 16),
          _PostDetailFooter(post: post),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }
}

class _PostMeta extends StatelessWidget {
  const _PostMeta({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(color: muted);

    return Row(
      children: [
        if (post.author?.proPic != null)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(post.author!.proPic!.fullUrl),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: CircleAvatar(
              radius: 12,
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                post.username[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        Text(post.username, style: style),
        Text('  ·  ', style: style),
        Text(post.createdAt.toRelativeString(context.l10n), style: style),
      ],
    );
  }
}

// ── Type-specific content ─────────────────────────────────────────────────────

class _PostDetailContent extends StatelessWidget {
  const _PostDetailContent({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return switch (post.type) {
      'image' => _DetailImage(post: post),
      'link' => _DetailLink(post: post),
      'text' when (post.body ?? '').isNotEmpty => _DetailText(body: post.body!),
      _ => const SizedBox.shrink(),
    };
  }
}

class _DetailImage extends StatelessWidget {
  const _DetailImage({required this.post});

  final Post post;

  /// Returns the aspect ratio (width / height) that accommodates all images
  /// without cropping any of them.
  ///
  /// We pick the most portrait (smallest ratio) image so the container is
  /// tall enough for every image in the set; landscape images will show with
  /// the average-color background filling the remaining space on the sides.
  static double _containerRatio(List<DiscuitImage> images) => images
      .map((img) => img.width / img.height)
      .reduce((a, b) => a < b ? a : b);

  @override
  Widget build(BuildContext context) {
    final images = post.images.isNotEmpty
        ? post.images
        : (post.image != null ? [post.image!] : null);
    if (images == null) return const SizedBox.shrink();

    Widget content = AspectRatio(
      aspectRatio: _containerRatio(images),
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
      content = Hero(tag: PostCard.heroTag(post.id), child: content);
    }

    return content;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (link.image != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: link.image!.fullUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => Container(
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  errorWidget: (_, _, _) => Container(
                    color: colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ),
          ),
        Container(
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
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
    return SelectableText(
      body,
      style: Theme.of(context).textTheme.bodyMedium,
    );
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
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(color: muted);

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

    final total = upvotes + downvotes;
    final pct = total > 0 ? (upvotes / total * 100).round() : null;

    return Row(
      children: [
        _DetailVoteButton(
          icon: Icons.arrow_upward_rounded,
          isActive: votedUp,
          activeColor: colorScheme.primary,
          showSpinner: showUpSpinner,
          muted: muted,
          onTap: () => ref.read(postVotesProvider.notifier).vote(post, true),
        ),
        const SizedBox(width: 6),
        Text('$score', style: style?.copyWith(color: scoreColor)),
        const SizedBox(width: 6),
        _DetailVoteButton(
          icon: Icons.arrow_downward_rounded,
          isActive: votedDown,
          activeColor: colorScheme.error,
          showSpinner: showDownSpinner,
          muted: muted,
          onTap: () => ref.read(postVotesProvider.notifier).vote(post, false),
        ),
        if (pct != null) ...[
          const SizedBox(width: 12),
          Text('$pct%', style: style),
        ],
        const SizedBox(width: 16),
        Icon(Icons.mode_comment_outlined, size: 16, color: muted),
        const SizedBox(width: 4),
        Text(context.l10n.commentsLabel(post.noComments), style: style),
      ],
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: showSpinner ? null : onTap,
      child: showSpinner
          ? SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: muted),
            )
          : Icon(icon, size: 16, color: isActive ? activeColor : muted),
    );
  }
}

// ── Comments ──────────────────────────────────────────────────────────────────

class _CommentsSectionSliver extends StatelessWidget {
  const _CommentsSectionSliver({
    required this.post,
    required this.detailState,
    required this.onRetry,
  });

  final Post post;
  final AsyncValue<Post> detailState;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final rawComments = detailState.value?.comments;
    final comments =
        rawComments != null ? _orderComments(rawComments) : null;
    final isLoading = detailState.isLoading;
    final hasError = detailState.hasError;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              context.l10n.postDetailComments,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        if (isLoading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
          )
        else if (hasError)
          SliverToBoxAdapter(
            child: ErrorView(error: detailState.error!, onRetry: onRetry),
          )
        else if (comments == null || comments.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  context.l10n.postDetailNoComments,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ),
          )
        else
          SliverList.separated(
            itemCount: comments.length +
                (detailState.value?.commentsNext != null ? 1 : 0),
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == comments.length) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: OutlinedButton(
                      onPressed: onRetry,
                      child:
                          Text(context.l10n.postDetailLoadMoreComments),
                    ),
                  ),
                );
              }
              return _CommentCard(comment: comments[index]);
            },
          ),
      ],
    );
  }
}

// ── Comment card ──────────────────────────────────────────────────────────────

// A set of rotating colours for the depth guide lines.
const _depthLineColors = [
  Color(0xFF4A90D9), // blue
  Color(0xFF50C878), // green
  Color(0xFFE67E22), // orange
  Color(0xFF9B59B6), // purple
  Color(0xFFE74C3C), // red
];

class _CommentCard extends ConsumerWidget {
  const _CommentCard({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depth = comment.depth.clamp(0, 6);
    final indent = depth * 12.0;
    final lineColor = _depthLineColors[depth % _depthLineColors.length];
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.onSurfaceVariant;
    final labelStyle =
        Theme.of(context).textTheme.labelSmall?.copyWith(color: muted);
    final isDeleted = comment.deleted || comment.body.isEmpty;

    final vs = ref.watch(commentVotesProvider)[comment.id];
    final userVoted = vs?.userVoted ?? comment.userVoted;
    final userVotedUp = vs?.userVotedUp ?? comment.userVotedUp;
    final upvotes = vs?.upvotes ?? comment.upvotes;
    final downvotes = vs?.downvotes ?? comment.downvotes;
    final votedUp = userVoted == true && userVotedUp == true;
    final votedDown = userVoted == true && userVotedUp == false;
    final showUpSpinner = vs?.isLoading == true && vs?.pendingVoteUp == true;
    final showDownSpinner = vs?.isLoading == true && vs?.pendingVoteUp == false;

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (depth > 0)
              Container(
                width: 2,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.username,
                          style: labelStyle?.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          comment.createdAt.toRelativeString(context.l10n),
                          style: labelStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    isDeleted
                        ? Text(
                            context.l10n.postDetailCommentDeleted,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: muted,
                                  fontStyle: FontStyle.italic,
                                ),
                          )
                        : SelectableText(
                            comment.body,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _CommentVoteButton(
                          icon: Icons.arrow_upward_rounded,
                          isActive: votedUp,
                          activeColor: colorScheme.primary,
                          showSpinner: showUpSpinner,
                          muted: muted,
                          onTap: () => ref
                              .read(commentVotesProvider.notifier)
                              .vote(comment, true),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${upvotes - downvotes}',
                          style: labelStyle?.copyWith(
                            color: votedUp
                                ? colorScheme.primary
                                : votedDown
                                    ? colorScheme.error
                                    : muted,
                          ),
                        ),
                        const SizedBox(width: 4),
                        _CommentVoteButton(
                          icon: Icons.arrow_downward_rounded,
                          isActive: votedDown,
                          activeColor: colorScheme.error,
                          showSpinner: showDownSpinner,
                          muted: muted,
                          onTap: () => ref
                              .read(commentVotesProvider.notifier)
                              .vote(comment, false),
                        ),
                        if (comment.noReplies > 0) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.subdirectory_arrow_right_rounded,
                              size: 12, color: muted),
                          const SizedBox(width: 2),
                          Text('${comment.noReplies}', style: labelStyle),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentVoteButton extends StatelessWidget {
  const _CommentVoteButton({
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: showSpinner ? null : onTap,
      child: showSpinner
          ? SizedBox.square(
              dimension: 12,
              child: CircularProgressIndicator(strokeWidth: 1.5, color: muted),
            )
          : Icon(icon, size: 12, color: isActive ? activeColor : muted),
    );
  }
}

// ── Comment ordering ──────────────────────────────────────────────────────────

/// Reorders a flat list of comments so that every reply follows its parent,
/// regardless of the order returned by the API.
///
/// The API does not guarantee ordering, and child comments can arrive before
/// their parents. The algorithm:
/// 1. Determine the maximum depth in the batch.
/// 2. For each depth level in ascending order, take all comments at that depth
///    and insert each one after the last comment that shares the same immediate
///    ancestor — identified either by having that ancestor's id directly, or by
///    having the same last ancestor id themselves.
List<Comment> _orderComments(List<Comment> comments) {
  if (comments.isEmpty) return comments;

  final result = <Comment>[];

  final maxDepth = comments.fold<int>(
    0,
    (prev, c) => c.depth > prev ? c.depth : prev,
  );

  for (var depth = 0; depth <= maxDepth; depth++) {
    final levelComments = comments.where((c) => c.depth == depth).toList();

    if (depth == 0) {
      result.addAll(levelComments);
    } else {
      for (final comment in levelComments) {
        // ancestors is non-null for depth > 0; last entry is the direct parent.
        final ancestor = comment.ancestors?.last;
        if (ancestor == null) {
          result.add(comment);
          continue;
        }

        // Insert right after the last comment that is either the parent itself
        // or a sibling that shares the same immediate ancestor.
        final insertAfter = result.lastIndexWhere(
          (c) => c.id == ancestor || c.ancestors?.last == ancestor,
        );
        result.insert(insertAfter + 1, comment);
      }
    }
  }

  return result;
}
