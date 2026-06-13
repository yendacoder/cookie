import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/theme/app_theme.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/avatar.dart';
import 'package:cookie/core/widgets/comment_gif.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/core/widgets/markdown_text.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/voting/providers/voting_provider.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'comment_menu.dart';
import 'post_card_skeleton.dart';

// ── Comments ──────────────────────────────────────────────────────────────────

class CommentsSectionSliver extends StatelessWidget {
  const CommentsSectionSliver({
    super.key,
    required this.post,
    required this.detailState,
    required this.onRetry,
    this.onReplyTap,
  });

  final Post post;
  final AsyncValue<Post> detailState;
  final VoidCallback onRetry;
  final ValueChanged<Comment>? onReplyTap;

  @override
  Widget build(BuildContext context) {
    final rawComments = detailState.value?.comments;
    final comments = rawComments != null ? _orderComments(rawComments) : null;
    final isLoading = detailState.isLoading;
    final hasError = detailState.hasError;
    final isMod = post.community?.userMod == true;

    return SliverMainAxisGroup(
      slivers: [
        if (isLoading)
          const SliverToBoxAdapter(child: CommentListSkeleton())
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          )
        else
          SliverList.separated(
            itemCount:
                comments.length +
                (detailState.value?.commentsNext != null ? 1 : 0),
            separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
            itemBuilder: (context, index) {
              if (index == comments.length) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: AdaptiveOutlinedButton(
                      onPressed: onRetry,
                      child: Text(context.l10n.postDetailLoadMoreComments),
                    ),
                  ),
                );
              }
              final comment = comments[index];
              return _CommentCard(
                comment: comment,
                isOp: comment.author?.id == post.author?.id,
                isMod: isMod,
                postPublicId: post.publicId,
                lastPostVisit: post.lastVisitAt,
                onReply: onReplyTap != null ? () => onReplyTap!(comment) : null,
              );
            },
          ),
      ],
    );
  }
}

// ── Comment card ──────────────────────────────────────────────────────────────

const _depthLineColors = [
  Color(0xFF4A90D9),
  Color(0xFF50C878),
  Color(0xFFE67E22),
  Color(0xFF9B59B6),
  Color(0xFFE74C3C),
];

class _CommentCard extends ConsumerStatefulWidget {
  const _CommentCard({
    required this.comment,
    required this.isOp,
    required this.isMod,
    required this.postPublicId,
    required this.lastPostVisit,
    this.onReply,
  });

  final Comment comment;
  final bool isOp;
  final bool isMod;
  final String postPublicId;
  final DateTime? lastPostVisit;
  final VoidCallback? onReply;

  @override
  ConsumerState<_CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends ConsumerState<_CommentCard> {
  late bool _revealed = widget.comment.isAuthorMuted != true;

  Widget _buildCommentContent(BuildContext context) {
    final mutedColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final padding = const EdgeInsets.fromLTRB(8, 12, 8, 6);
    if (widget.comment.isAuthorMuted == true && !_revealed) {
      return AdaptiveInkWell(
        onTap: () => setState(() => _revealed = true),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: padding,
          child: Text(
            context.l10n.commentMutedHiddenText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: mutedColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    if (widget.comment.deleted) {
      return Padding(
        padding: padding,
        child: Text(
          context.l10n.postDetailCommentDeleted,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: mutedColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    final gifUri = _extractGifUri(widget.comment.body);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          MarkdownText(
            widget.comment.body,
            baseStyle: Theme.of(context).textTheme.bodySmall,
          ),
          if (gifUri != null) CommentGif(gifUri: gifUri),
        ],
      ),
    );
  }

  Widget _buildCommentFooter(BuildContext context, TextStyle? labelStyle) {
    final comment = widget.comment;
    final isDeleted = comment.deleted;
    final postPublicId = widget.postPublicId;
    final onReply = widget.onReply;
    final vs = ref.watch(commentVotesProvider)[comment.id];
    final userVoted = vs?.userVoted ?? comment.userVoted;
    final userVotedUp = vs?.userVotedUp ?? comment.userVotedUp;
    final upvotes = vs?.upvotes ?? comment.upvotes;
    final downvotes = vs?.downvotes ?? comment.downvotes;
    final votedUp = userVoted == true && userVotedUp == true;
    final votedDown = userVoted == true && userVotedUp == false;
    final showUpSpinner = vs?.isLoading == true && vs?.pendingVoteUp == true;
    final showDownSpinner = vs?.isLoading == true && vs?.pendingVoteUp == false;

    final mutedColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      children: [
        SizedBox(width: 2),
        _CommentVoteButton(
          icon: Icons.arrow_upward_rounded,
          isActive: votedUp,
          activeColor: AppTheme.kUpvoteColor,
          showSpinner: showUpSpinner,
          muted: mutedColor,
          onTap: () =>
              ref.read(commentVotesProvider.notifier).vote(comment, true),
        ),
        Text(
          '${upvotes - downvotes}',
          style: labelStyle?.copyWith(
            color: votedUp
                ? AppTheme.kUpvoteColor
                : votedDown
                ? AppTheme.kDownvoteColor
                : mutedColor,
          ),
        ),
        _CommentVoteButton(
          icon: Icons.arrow_downward_rounded,
          isActive: votedDown,
          activeColor: AppTheme.kDownvoteColor,
          showSpinner: showDownSpinner,
          muted: mutedColor,
          onTap: () =>
              ref.read(commentVotesProvider.notifier).vote(comment, false),
        ),
        if (comment.noReplies > 0) ...[
          const SizedBox(width: 2),
          Icon(
            Icons.subdirectory_arrow_right_rounded,
            size: 12,
            color: mutedColor,
          ),
          const SizedBox(width: 2),
          Text('${comment.noReplies}', style: labelStyle),
          const SizedBox(width: 6),
        ],
        if (onReply != null && !isDeleted) ...[
          const SizedBox(width: 6),
          AdaptiveInkWell(
            onTap: onReply,
            child: Text(context.l10n.commentReplyButton, style: labelStyle),
          ),
        ],
        if (!isDeleted) ...[
          const SizedBox(width: 12),
          CommentMenuButton(
            comment: comment,
            postPublicId: postPublicId,
            muted: mutedColor,
            isMod: widget.isMod,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;
    final isOp = widget.isOp;

    final lastPostVisit = widget.lastPostVisit;
    final depth = comment.depth.clamp(0, 4);
    final indent = depth * 8.0;
    final lineColor = _depthLineColors[comment.depth % _depthLineColors.length];
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.onSurfaceVariant;
    final labelStyle = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: muted);
    final isMutedHidden = comment.isAuthorMuted == true && !_revealed;

    return Padding(
      padding: EdgeInsets.only(left: indent + 6, right: 6),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 16, 0),
                    child: Row(
                      children: [
                        AdaptiveInkWell(
                          onTap: isMutedHidden
                              ? null
                              : () => context.push('/u/${comment.username}'),
                          borderRadius: BorderRadius.circular(4),
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Avatar(
                                imageUrl: isMutedHidden
                                    ? null
                                    : comment.author?.proPic?.fullUrl,
                                fallback: isMutedHidden
                                    ? context.l10n.commentMutedUsername
                                    : comment.username,
                                radius: 8,
                              ),
                              SizedBox(width: 8),
                              Text(
                                isMutedHidden
                                    ? context.l10n.commentMutedUsername
                                    : comment.username,
                                style: labelStyle,
                              ),
                              if (isOp) ...[
                                SizedBox(width: 8),
                                Text(
                                  context.l10n.commentOP,
                                  style: labelStyle?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                              if (comment.author?.isAdmin == true) ...[
                                SizedBox(width: 8),
                                Text(
                                  context.l10n.commentAdmin,
                                  style: labelStyle?.copyWith(
                                    color: colorScheme.tertiary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          comment.createdAt.toRelativeString(context.l10n),
                          style: labelStyle,
                        ),
                        if (comment.locked) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.lock, size: 12, color: muted),
                        ],
                        // Most often own comments will be marked as new
                        // since the last call to API to fetch the post
                        // would be before the comment created time.
                        // It's weird to mark own comments as new, so
                        // they are excluded explicitly
                        if (lastPostVisit != null &&
                            comment.createdAt.isAfter(lastPostVisit) &&
                            ref.watch(authProvider).value?.username !=
                                comment.author?.username)
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.kUpvoteColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  _buildCommentContent(context),
                  if (!isMutedHidden) _buildCommentFooter(context, labelStyle),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Comment vote button ───────────────────────────────────────────────────────

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
    return AdaptiveInkWell(
      onTap: showSpinner ? null : onTap,
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
        final ancestor = comment.ancestors?.last;
        if (ancestor == null) {
          result.add(comment);
          continue;
        }
        final insertAfter = result.lastIndexWhere(
          (c) => c.id == ancestor || c.ancestors?.last == ancestor,
        );
        result.insert(insertAfter + 1, comment);
      }
    }
  }

  return result;
}

const _kInlineGifsFrom = ['tenor.com', 'giphy.com'];

/// Extracts the direct address of a linked gif to be inlined in
/// the comment body
Uri? _extractGifUri(String commentBody) {
  RegExp urlRegExp = RegExp(
    r'((https?)://[^\s/$.?#].\S*)',
    caseSensitive: false,
    multiLine: true,
  );
  Iterable<RegExpMatch> matches = urlRegExp.allMatches(commentBody);
  for (RegExpMatch match in matches) {
    String? urlString = match.group(0);
    if (urlString?.endsWith(')') == true) {
      urlString = urlString?.substring(0, urlString.length - 1);
    }
    try {
      Uri uri = Uri.parse(urlString ?? '');
      if (_kInlineGifsFrom.contains(uri.host)) {
        return uri;
      } else if (urlString?.endsWith('.gif') == true ||
          urlString?.endsWith('.webp') == true) {
        return uri;
      }
    } catch (e) {
      // do nothing
    }
  }
  return null;
}
