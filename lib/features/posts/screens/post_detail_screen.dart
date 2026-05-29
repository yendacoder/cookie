import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/comment_gif.dart';
import '../../../core/widgets/youtube_content.dart';
import '../../voting/providers/voting_provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/api_client.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/markdown_text.dart';
import '../../../models/comment.dart';
import '../../../models/discuit_image.dart';
import '../../../models/post.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/hidden_posts_provider.dart';
import '../providers/post_detail_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/post_card_skeleton.dart';
import '../widgets/post_image_carousel.dart';
import '../widgets/post_save_to_list_sheet.dart';
import 'image_viewer_screen.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({
    super.key,
    required this.communityName,
    required this.postId,
    this.initialPost,
  });

  final String communityName;
  final String postId;

  /// Pre-loaded post passed from the feed. When present, post content is shown
  /// immediately (enabling the hero transition) while the full detail loads.
  final Post? initialPost;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Comment? _replyToComment;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(postDetailProvider(widget.postId).notifier)
          .addComment(body, parentCommentId: _replyToComment?.id);
      if (!mounted) return;
      _controller.clear();
      setState(() {
        _replyToComment = null;
        _isSubmitting = false;
      });
      _focusNode.unfocus();
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.commentSubmitError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(postDetailProvider(widget.postId));
    final post = detailState.value ?? widget.initialPost;
    final isAuthenticated = ref
        .watch(authProvider)
        .value != null;

    if (post == null) {
      return Scaffold(
        appBar: AppBar(),
        body: detailState.when(
          loading: () =>
              SingleChildScrollView(
                child: Column(
                  children: const [
                    PostFeedSkeleton(count: 1, showCommunity: false),
                    Divider(),
                    CommentListSkeleton(count: 4),
                  ],
                ),
              ),
          error: (error, _) =>
              ErrorView(
                error: error,
                onRetry: () =>
                    ref.invalidate(postDetailProvider(widget.postId)),
              ),
          data: (_) => const SizedBox.shrink(),
        ),
      );
    }

    return Scaffold(
      appBar: _PostAppBar(post: post),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(postDetailProvider(widget.postId));
                await ref.read(postDetailProvider(widget.postId).future);
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _PostDetailBody(post: post)),
                  _CommentsSectionSliver(
                    post: post,
                    detailState: detailState,
                    onRetry: () =>
                        ref.invalidate(postDetailProvider(widget.postId)),
                    onReplyTap: isAuthenticated
                        ? (comment) {
                      setState(() => _replyToComment = comment);
                      _focusNode.requestFocus();
                    }
                        : null,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            ),
          ),
          if (isAuthenticated)
            _CommentComposer(
              controller: _controller,
              focusNode: _focusNode,
              replyToComment: _replyToComment,
              isSubmitting: _isSubmitting,
              onCancelReply: () => setState(() => _replyToComment = null),
              onSubmit: _submit,
            ),
        ],
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _PostAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _PostAppBar({required this.post});

  final Post post;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _reportPost(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final reason = await _showReportReasonDialog(context);
    if (reason == null) return;
    try {
      await ref
          .read(postDetailProvider(post.publicId).notifier)
          .reportPost(reason);
      messenger.showSnackBar(SnackBar(content: Text(l10n.postReportSuccess)));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.reportFail)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref
        .watch(authProvider)
        .value;
    final isAuthenticated = currentUser != null;
    final isAuthor = currentUser?.username == post.username;
    final l10n = context.l10n;

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
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        if (isAuthenticated)
          PopupMenuButton<_PostMenuAction>(
            itemBuilder: (_) =>
            [
              PopupMenuItem(
                value: .openInBrowser,
                child: Text(l10n.postMenuOpenInBrowser),
              ),
              PopupMenuItem(
                value: .saveToList,
                child: Text(l10n.postMenuSaveToList),
              ),
              if (isAuthor) ...[
                PopupMenuItem(value: .editPost, child: Text(l10n.postMenuEdit)),
                PopupMenuItem(
                  value: .deletePost,
                  child: Text(
                    l10n.postMenuDelete,
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .error,
                    ),
                  ),
                ),
              ],
              PopupMenuItem(value: .hide, child: Text(l10n.postMenuHide)),
              PopupMenuItem(value: .report, child: Text(l10n.postMenuReport)),
            ],
            onSelected: (action) async {
              switch (action) {
                case .openInBrowser:
                  launchUrl(
                    post.postWebUrl,
                    mode: LaunchMode.externalApplication,
                  );
                case .saveToList:
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => PostSaveToListSheet(post: post),
                  );
                case .editPost:
                  await context.push('/compose', extra: post);
                  if (context.mounted) {
                    ref.invalidate(postDetailProvider(post.publicId));
                  }
                case .deletePost:
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) =>
                        AlertDialog(
                          title: Text(l10n.postDeleteTitle),
                          content: Text(l10n.postDeleteConfirm),
                          actions: [
                            TextButton(
                              onPressed: () => ctx.pop(false),
                              child: Text(l10n.cancelButton),
                            ),
                            TextButton(
                              onPressed: () => ctx.pop(true),
                              style: TextButton.styleFrom(
                                foregroundColor: Theme
                                    .of(
                                  context,
                                )
                                    .colorScheme
                                    .error,
                              ),
                              child: Text(l10n.deleteButton),
                            ),
                          ],
                        ),
                  );
                  if (confirmed != true || !context.mounted) return;
                  try {
                    await ref
                        .read(apiClientProvider)
                        .delete(
                      'posts/${post
                          .publicId}?deleteAs=normal&deleteContent=true',
                    );
                    if (context.mounted) context.pop();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                case .hide:
                  ref.read(hiddenPostsProvider.notifier).hide(post.id);
                  context.pop();
                case .report:
                  _reportPost(context, ref);
              }
            },
          ),
      ],
    );
  }
}

enum _PostMenuAction {
  openInBrowser,
  saveToList,
  editPost,
  deletePost,
  hide,
  report,
}

// ── Post body ─────────────────────────────────────────────────────────────────

class _PostDetailBody extends StatelessWidget {
  const _PostDetailBody({required this.post});

  final Post post;

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
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _PostDetailContent(post: post),
        ),
        _PostDetailFooter(post: post),
        const Divider(),
      ],
    );
  }
}

class _PostMeta extends StatelessWidget {
  const _PostMeta({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final muted = Theme
        .of(context)
        .colorScheme
        .onSurfaceVariant;
    final style = Theme
        .of(
      context,
    )
        .textTheme
        .labelSmall
        ?.copyWith(color: muted);

    return GestureDetector(
      onTap: () => context.push('/u/${post.username}'),
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
        ],
      ),
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

class _DetailImage extends StatefulWidget {
  const _DetailImage({required this.post});

  final Post post;

  static double _containerRatio(List<DiscuitImage> images) =>
      images
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
        onTap: (index) =>
            context.push(
              '/image-viewer',
              extra: ImageViewerArgs(images: images, initialIndex: index),
            ),
      ),
    );

    if (images.length == 1) {
      carousel = Hero(tag: PostCard.heroTag(widget.post.id), child: carousel);
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

    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final youtubeId = YoutubePlayerController.convertUrlToId(link.url);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () =>
              launchUrl(
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
                    style: Theme
                        .of(
                      context,
                    )
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: colorScheme.primary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (youtubeId != null)
          YoutubeContent(videoId: youtubeId)
        else
          if (link.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
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

    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final muted = colorScheme.onSurfaceVariant;
    final style = Theme
        .of(
      context,
    )
        .textTheme
        .labelMedium
        ?.copyWith(color: muted);

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
          InkWell(
            onTap: () =>
                SharePlus.instance.share(
                  ShareParams(uri: post.postWebUrl, subject: post.title),
                ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(Icons.share, size: 14, color: muted),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: showSpinner ? null : onTap,
      child: Padding(
        padding: EdgeInsetsGeometry.all(6),
        child: showSpinner
            ? SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: muted,
          ),
        )
            : Icon(icon, size: 16, color: isActive ? activeColor : muted),
      ),
    );
  }
}

// ── Comment composer ──────────────────────────────────────────────────────────

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({
    required this.controller,
    required this.focusNode,
    required this.replyToComment,
    required this.isSubmitting,
    required this.onCancelReply,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Comment? replyToComment;
  final bool isSubmitting;
  final VoidCallback onCancelReply;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final canSend = controller.text
            .trim()
            .isNotEmpty && !isSubmitting;

        return Material(
          color: colorScheme.surface,
          elevation: 4,
          shadowColor: Colors.transparent,
          surfaceTintColor: colorScheme.surfaceTint,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (replyToComment != null)
                  _ReplyChip(
                    username: replyToComment!.username,
                    onCancel: onCancelReply,
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                  child: Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: context.l10n.commentHint,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: colorScheme.outline,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            isDense: true,
                          ),
                          minLines: 1,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.newline,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        height: 44,
                        child: IconButton(
                          icon: isSubmitting
                              ? SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          )
                              : Icon(
                            Icons.send_rounded,
                            color: canSend
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(
                              alpha: 0.38,
                            ),
                          ),
                          onPressed: canSend ? onSubmit : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReplyChip extends StatelessWidget {
  const _ReplyChip({required this.username, required this.onCancel});

  final String username;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final muted = colorScheme.onSurfaceVariant;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        child: Row(
          children: [
            Icon(Icons.reply_rounded, size: 14, color: muted),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                context.l10n.commentReplyingTo(username),
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: muted),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: onCancel,
              icon: Icon(Icons.close_rounded, size: 16, color: muted),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

// ── Comments ──────────────────────────────────────────────────────────────────

class _CommentsSectionSliver extends StatelessWidget {
  const _CommentsSectionSliver({
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

    return SliverMainAxisGroup(
      slivers: [
        if (isLoading)
          const SliverToBoxAdapter(child: CommentListSkeleton())
        else
          if (hasError)
            SliverToBoxAdapter(
              child: ErrorView(error: detailState.error!, onRetry: onRetry),
            )
          else
            if (comments == null || comments.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      context.l10n.postDetailNoComments,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurfaceVariant,
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
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index == comments.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: OutlinedButton(
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
                    postPublicId: post.publicId,
                    lastPostVisit: post.lastVisitAt,
                    onReply: onReplyTap != null
                        ? () => onReplyTap!(comment)
                        : null,
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

class _CommentCard extends ConsumerWidget {
  const _CommentCard({
    required this.comment,
    required this.isOp,
    required this.postPublicId,
    required this.lastPostVisit,
    this.onReply,
  });

  final Comment comment;
  final bool isOp;
  final String postPublicId;
  final DateTime? lastPostVisit;
  final VoidCallback? onReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depth = comment.depth.clamp(0, 4);
    final indent = depth * 8.0;
    final lineColor = _depthLineColors[comment.depth % _depthLineColors.length];
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final muted = colorScheme.onSurfaceVariant;
    final labelStyle = Theme
        .of(
      context,
    )
        .textTheme
        .labelSmall
        ?.copyWith(color: muted);
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

    final gifUri = _extractGifUri(comment.body);

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
                        GestureDetector(
                          onTap: () => context.push('/u/${comment.username}'),
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Avatar(
                                imageUrl: comment.author?.proPic?.fullUrl,
                                fallback: comment.username,
                                radius: 8,
                              ),
                              SizedBox(width: 8),
                              Text(comment.username, style: labelStyle),
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
                        // Most often own comments will be marked as new
                        // since the last call to API to fetch the post
                        // would be before the comment created time.
                        // It's weird to mark own comments as new, so
                        // they are excluded explicitly
                        if (lastPostVisit != null &&
                            comment.createdAt.isAfter(lastPostVisit!) &&
                            ref
                                .watch(authProvider)
                                .value
                                ?.username !=
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
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: isDeleted
                        ? Text(
                      context.l10n.postDetailCommentDeleted,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        color: muted,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                        : MarkdownText(
                      comment.body,
                      baseStyle: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ),
                  if (gifUri != null)
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                      child: CommentGif(gifUri: gifUri),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SizedBox(width: 2),
                      _CommentVoteButton(
                        icon: Icons.arrow_upward_rounded,
                        isActive: votedUp,
                        activeColor: AppTheme.kUpvoteColor,
                        showSpinner: showUpSpinner,
                        muted: muted,
                        onTap: () =>
                            ref
                                .read(commentVotesProvider.notifier)
                                .vote(comment, true),
                      ),
                      Text(
                        '${upvotes - downvotes}',
                        style: labelStyle?.copyWith(
                          color: votedUp
                              ? AppTheme.kUpvoteColor
                              : votedDown
                              ? AppTheme.kDownvoteColor
                              : muted,
                        ),
                      ),
                      _CommentVoteButton(
                        icon: Icons.arrow_downward_rounded,
                        isActive: votedDown,
                        activeColor: AppTheme.kDownvoteColor,
                        showSpinner: showDownSpinner,
                        muted: muted,
                        onTap: () =>
                            ref
                                .read(commentVotesProvider.notifier)
                                .vote(comment, false),
                      ),
                      if (comment.noReplies > 0) ...[
                        const SizedBox(width: 2),
                        Icon(
                          Icons.subdirectory_arrow_right_rounded,
                          size: 12,
                          color: muted,
                        ),
                        const SizedBox(width: 2),
                        Text('${comment.noReplies}', style: labelStyle),
                        const SizedBox(width: 6),
                      ],
                      if (onReply != null && !isDeleted) ...[
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: onReply,
                          child: Text(
                            context.l10n.commentReplyButton,
                            style: labelStyle,
                          ),
                        ),
                      ],
                      if (!isDeleted) ...[
                        const SizedBox(width: 12),
                        _CommentMenuButton(
                          comment: comment,
                          postPublicId: postPublicId,
                          muted: muted,
                        ),
                      ],
                    ],
                  ),
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

// ── Comment menu button ───────────────────────────────────────────────────────

enum _CommentMenuAction { edit, delete, report }

class _CommentMenuButton extends ConsumerWidget {
  const _CommentMenuButton({
    required this.comment,
    required this.postPublicId,
    required this.muted,
  });

  final Comment comment;
  final String postPublicId;
  final Color muted;

  void _deleteComment(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text(l10n.commentDeleteTitle),
            content: Text(l10n.commentDeleteConfirm),
            actions: [
              TextButton(
                onPressed: () => ctx.pop(false),
                child: Text(l10n.cancelButton),
              ),
              TextButton(
                onPressed: () => ctx.pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme
                      .of(context)
                      .colorScheme
                      .error,
                ),
                child: Text(l10n.deleteButton),
              ),
            ],
          ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref
          .read(postDetailProvider(postPublicId).notifier)
          .deleteComment(comment.id);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _reportComment(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final reason = await _showReportReasonDialog(context);
    if (reason == null) return;
    try {
      await ref
          .read(postDetailProvider(postPublicId).notifier)
          .reportComment(comment.id, reason);
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.commentReportSuccess)),
      );
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.reportFail)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref
        .watch(authProvider)
        .value;
    if (currentUser == null) {
      return const SizedBox.shrink();
    }

    final isOwn = currentUser.username == comment.username;
    final l10n = context.l10n;

    return PopupMenuButton<_CommentMenuAction>(
      iconSize: 14,
      icon: Icon(Icons.more_horiz, size: 14, color: muted),
      padding: .zero,
      style: TextButton.styleFrom(
        padding: .zero,
        visualDensity: .compact,
        minimumSize: Size.zero,
        iconSize: 14,
        tapTargetSize: .shrinkWrap,
      ),
      itemBuilder: (_) =>
      [
        if (isOwn) ...[
          PopupMenuItem(value: .edit, child: Text(l10n.commentMenuEdit)),
          PopupMenuItem(
            value: .delete,
            child: Text(
              l10n.commentMenuDelete,
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .error),
            ),
          ),
        ],
        PopupMenuItem(value: .report, child: Text(l10n.postMenuReport)),
      ],
      onSelected: (action) async {
        switch (action) {
          case .edit:
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (_) =>
                  _CommentEditSheet(
                    comment: comment,
                    postPublicId: postPublicId,
                  ),
            );
          case .delete:
            _deleteComment(context, ref);
          case .report:
            _reportComment(context, ref);
        }
      },
    );
  }
}

// ── Comment edit sheet ────────────────────────────────────────────────────────

class _CommentEditSheet extends ConsumerStatefulWidget {
  const _CommentEditSheet({required this.comment, required this.postPublicId});

  final Comment comment;
  final String postPublicId;

  @override
  ConsumerState<_CommentEditSheet> createState() => _CommentEditSheetState();
}

class _CommentEditSheetState extends ConsumerState<_CommentEditSheet> {
  late final TextEditingController _ctrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.comment.body);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final body = _ctrl.text.trim();
    if (body.isEmpty || body == widget.comment.body) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(postDetailProvider(widget.postPublicId).notifier)
          .editComment(widget.comment.id, body);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery
          .viewInsetsOf(context)
          .bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.commentEditTitle,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _ctrl,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 6,
                  minLines: 3,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(l10n.saveButton),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
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
    return InkWell(
      onTap: showSpinner ? null : onTap,
      child: Padding(
        padding: EdgeInsetsGeometry.all(6),
        child: showSpinner
            ? SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(
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

Future<int?> _showReportReasonDialog(BuildContext context) {
  final reasons = context.l10n.reportReasons.split('\n');
  return showDialog<int>(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title: Text(context.l10n.reportTitle),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reasons.length,
              itemBuilder: (_, i) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => Navigator.pop(ctx, i + 1),
                  title: Text(
                    reasons[i],
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(context.l10n.cancelButton),
            ),
          ],
        ),
  );
}
