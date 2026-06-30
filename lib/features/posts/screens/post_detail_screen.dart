import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_menu_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/posts/providers/hidden_posts_provider.dart';
import 'package:cookie/features/posts/providers/post_detail_provider.dart';
import 'package:cookie/features/posts/providers/read_new_comments_notifier.dart';
import 'package:cookie/features/posts/widgets/comment_card.dart';
import 'package:cookie/features/posts/widgets/comment_composer.dart';
import 'package:cookie/features/posts/widgets/post_card_skeleton.dart';
import 'package:cookie/features/posts/widgets/post_detail_body.dart';
import 'package:cookie/features/posts/widgets/post_mod_actions_sheet.dart';
import 'package:cookie/features/posts/widgets/post_save_to_list_sheet.dart';
import 'package:cookie/features/posts/widgets/report_reason_dialog.dart';
import 'package:cookie/features/user/widgets/block_user_dialog.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({
    super.key,
    required this.communityName,
    required this.postId,
    this.initialPost,
    this.heroTagScope = const HeroTagScope(.unknown),
  });

  final String communityName;
  final String postId;

  /// Pre-loaded post passed from the feed. When present, post content is shown
  /// immediately (enabling the hero transition) while the full detail loads.
  final Post? initialPost;

  /// Must match the heroTagScope of the PostCard that triggered navigation.
  final HeroTagScope heroTagScope;

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
      showPlatformSnackBar(context, context.l10n.commentSubmitError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(postDetailProvider(widget.postId));
    if (detailState.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(
              readNewCommentsProvider(widget.heroTagScope.toString()).notifier,
            )
            .setRead(widget.postId);
      });
    }
    final post = detailState.value ?? widget.initialPost;
    final isAuthenticated = ref.watch(authProvider).value != null;

    if (post == null) {
      return AdaptiveScaffold(
        appBar: AdaptiveAppBar(),
        body: detailState.when(
          loading: () => SingleChildScrollView(
            child: Column(
              children: const [
                PostFeedSkeleton(count: 1, showCommunity: false),
                AdaptiveDivider(),
                CommentListSkeleton(count: 4),
              ],
            ),
          ),
          error: (error, _) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(postDetailProvider(widget.postId)),
          ),
          data: (_) => const SizedBox.shrink(),
        ),
      );
    }

    return AdaptiveScaffold(
      appBar: _PostAppBar(post: post),
      body: Column(
        children: [
          Expanded(
            child: AdaptiveRefreshIndicator(
              onRefresh: () async {
                ref.invalidate(postDetailProvider(widget.postId));
                await ref.read(postDetailProvider(widget.postId).future);
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: PostDetailBody(
                      post: post,
                      heroTagScope: widget.heroTagScope,
                    ),
                  ),
                  CommentsSectionSliver(
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
            CommentComposer(
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
    final l10n = context.l10n;
    final reason = await showReportReasonDialog(context);
    if (reason == null) return;
    try {
      await ref
          .read(postDetailProvider(post.publicId).notifier)
          .reportPost(reason);
      if (context.mounted) {
        showPlatformSnackBar(context, l10n.postReportSuccess);
      }
    } catch (_) {
      if (context.mounted) showPlatformSnackBar(context, l10n.reportFail);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).value;
    final isAuthenticated = currentUser != null;
    final isAuthor = currentUser?.username == post.username;
    final isMod = post.community?.userMod == true;
    final l10n = context.l10n;

    return AdaptiveAppBar(
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
      actions: [
        if (isAuthenticated)
          AdaptiveMenuButton<_PostMenuAction>(
            items: [
              AdaptiveMenuItem(
                value: _PostMenuAction.openInBrowser,
                label: l10n.postMenuOpenInBrowser,
              ),
              if (!post.deleted)
                AdaptiveMenuItem(
                  value: _PostMenuAction.saveToList,
                  label: l10n.postMenuSaveToList,
                ),
              if (isAuthor && !post.deleted) ...[
                AdaptiveMenuItem(
                  value: _PostMenuAction.editPost,
                  label: l10n.postMenuEdit,
                ),
                AdaptiveMenuItem(
                  value: _PostMenuAction.deletePost,
                  label: l10n.postMenuDelete,
                  isDestructive: true,
                ),
              ],
              AdaptiveMenuItem(
                value: _PostMenuAction.hide,
                label: l10n.postMenuHide,
              ),
              AdaptiveMenuItem(
                value: _PostMenuAction.report,
                label: l10n.postMenuReport,
              ),
              if (!isAuthor && post.author != null)
                AdaptiveMenuItem(
                  value: _PostMenuAction.block,
                  label: l10n.postMenuBlock,
                  isDestructive: true,
                ),
              if (isMod)
                AdaptiveMenuItem(
                  value: _PostMenuAction.modActions,
                  label: l10n.postMenuModActions,
                ),
            ],
            onSelected: (action) async {
              switch (action) {
                case .openInBrowser:
                  launchUrl(
                    post.postWebUrl,
                    mode: LaunchMode.externalApplication,
                  );
                case .saveToList:
                  showPlatformSheet(
                    context: context,
                    builder: (_) => PostSaveToListSheet(post: post),
                  );
                case .editPost:
                  await context.push('/compose', extra: post);
                  if (context.mounted) {
                    ref.invalidate(postDetailProvider(post.publicId));
                  }
                case .deletePost:
                  final confirmed = await showPlatformDialog<bool>(
                    context: context,
                    builder: (ctx) => AdaptiveAlertDialog(
                      title: Text(l10n.postDeleteTitle),
                      content: Text(l10n.postDeleteConfirm),
                      actions: [
                        AdaptiveDialogAction(
                          onPressed: () => ctx.pop(false),
                          child: Text(l10n.cancelButton),
                        ),
                        AdaptiveDialogAction(
                          isDefault: true,
                          isDestructive: true,
                          onPressed: () => ctx.pop(true),
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
                          'posts/${post.publicId}?deleteAs=normal&deleteContent=true',
                        );
                    if (context.mounted) context.pop();
                  } catch (e) {
                    if (context.mounted) {
                      showPlatformSnackBar(context, apiErrorMessage(e));
                    }
                  }
                case .hide:
                  ref.read(hiddenPostsProvider.notifier).hide(post.id);
                  context.pop();
                case .report:
                  _reportPost(context, ref);
                case .block:
                  final author = post.author;
                  if (author == null) return;
                  final blocked = await showBlockUserDialog(
                    context,
                    ref,
                    userId: author.id,
                    username: author.username,
                    targetId: post.id,
                    targetType: 'post',
                  );
                  if (blocked && context.mounted) context.pop();
                case .modActions:
                  showPlatformSheet(
                    context: context,
                    builder: (_) => PostModActionsSheet(post: post),
                  );
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
  block,
  modActions,
}
