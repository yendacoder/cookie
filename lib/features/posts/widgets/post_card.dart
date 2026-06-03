import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_menu_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookie/core/theme/app_theme.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/core/widgets/youtube_content.dart';
import 'package:cookie/features/communities/providers/muted_communities_list_provider.dart';
import 'package:cookie/features/posts/providers/read_new_comments_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/utils/markdown_utils.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/avatar.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/communities/providers/community_mutes_provider.dart';
import 'package:cookie/features/user/providers/muted_users_list_provider.dart';
import 'package:cookie/features/user/providers/user_mutes_provider.dart';
import 'package:cookie/features/voting/providers/voting_provider.dart';
import 'package:cookie/features/posts/providers/hidden_posts_provider.dart';
import 'package:cookie/features/posts/screens/image_viewer_screen.dart';
import 'post_image_carousel.dart';
import 'post_save_to_list_sheet.dart';

enum _PostMenuAction {
  saveToList,
  removeFromList,
  editPost,
  deletePost,
  hide,
  muteUser,
  muteCommunity,
}

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    this.checkMutedUser = true,
    this.checkMutedCommunity = true,
    this.showCommunity = true,
    this.onRemoveFromList,
  });

  final Post post;
  final bool checkMutedUser;
  final bool checkMutedCommunity;
  final VoidCallback onTap;

  /// When false the community name and icon are hidden in the post header.
  /// Set to false when displaying posts inside a community screen.
  final bool showCommunity;

  /// When set, the menu shows "Remove from list" instead of "Save to list".
  final VoidCallback? onRemoveFromList;

  static String heroTag(String postId) => 'post-image-$postId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHidden = ref.watch(hiddenPostsProvider).contains(post.id);
    final isMutedCommunity =
        checkMutedCommunity &&
        ref
            .watch(mutedCommunitiesListProvider)
            .any((it) => it.id == post.communityId);
    final isMutedUser =
        checkMutedUser &&
        ref.watch(mutedUsersListProvider).any((it) => it.id == post.author?.id);
    if (isHidden || isMutedUser || isMutedCommunity) {
      return _HiddenPlaceholder(post: post, withUndo: isHidden);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tappable area — navigates to post detail.
        AdaptiveInkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PostHeader(post: post, showCommunity: showCommunity),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    if (post.isPinned)
                      Icon(
                        Icons.push_pin,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
                _PostContent(post: post),
              ],
            ),
          ),
        ),
        // Footer sits outside InkWell — no gesture conflict with vote taps.
        _PostFooter(
          post: post,
          muteUser: checkMutedUser,
          muteCommunity: checkMutedCommunity,
          onDetailTap: onTap,
          onRemoveFromList: onRemoveFromList,
        ),
      ],
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _PostHeader extends StatelessWidget {
  const _PostHeader({required this.post, required this.showCommunity});

  final Post post;
  final bool showCommunity;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Flexible(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.push('/u/${post.username}'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Avatar(
                  imageUrl: post.author?.proPic?.fullUrl,
                  fallback: post.username,
                  radius: 10,
                ),
                const SizedBox(width: 6),
                Text(
                  post.username,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: muted),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        if (showCommunity) ...[
          const SizedBox(width: 8),
          GestureDetector(
            // Intercepts before the outer InkWell so this tap opens the
            // community screen rather than the post detail.
            behavior: HitTestBehavior.opaque,
            onTap: () => context.push('/c/${post.communityName}'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  post.communityName,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: muted),
                  overflow: .ellipsis,
                ),
                const SizedBox(width: 6),
                Avatar(
                  imageUrl: post.communityProPic?.fullUrl,
                  fallback: post.communityName,
                  radius: 10,
                ),
              ],
            ),
          ),
        ],
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
    final youtubeId = YoutubePlayerController.convertUrlToId(link.url);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          GestureDetector(
            behavior: .opaque,
            onTap: () => launchUrl(
              Uri.parse(link.url),
              mode: LaunchMode.externalApplication,
            ),
            child: Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
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
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                        placeholder: (_, _) => _ImagePlaceholder(
                          color: link.image?.averageColorValue,
                        ),
                        errorWidget: (_, _, _) => _ImagePlaceholder(
                          color: link.image?.averageColorValue,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (youtubeId != null) YoutubeContent(videoId: youtubeId),
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
        markdownToPlainText(body),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _PostFooter extends ConsumerWidget {
  const _PostFooter({
    required this.post,
    required this.muteUser,
    required this.muteCommunity,
    required this.onDetailTap,
    this.onRemoveFromList,
  });

  final Post post;
  final bool muteUser;
  final bool muteCommunity;
  final VoidCallback onDetailTap;
  final VoidCallback? onRemoveFromList;

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
        ? AppTheme.kUpvoteColor
        : votedDown
        ? AppTheme.kDownvoteColor
        : muted;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 4, 12),
      child: Row(
        children: [
          _VoteButton(
            icon: Icons.arrow_upward_rounded,
            size: 16,
            isActive: votedUp,
            activeColor: AppTheme.kUpvoteColor,
            showSpinner: showUpSpinner,
            muted: muted,
            onTap: () => ref.read(postVotesProvider.notifier).vote(post, true),
          ),
          Text('$score', style: base?.copyWith(color: scoreColor)),
          _VoteButton(
            icon: Icons.arrow_downward_rounded,
            size: 16,
            isActive: votedDown,
            activeColor: AppTheme.kDownvoteColor,
            showSpinner: showDownSpinner,
            muted: muted,
            onTap: () => ref.read(postVotesProvider.notifier).vote(post, false),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onDetailTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.mode_comment_outlined, size: 14, color: muted),
                    const SizedBox(width: 6),
                    Text('${post.noComments}', style: base),
                    if (!ref.watch(readNewCommentsProvider).contains(post.id) &&
                        (post.newComments ?? 0) > 0)
                      Tooltip(
                        message: context.l10n.commentsNewCountTooltip(
                          post.newComments!,
                          post.noComments,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '+${post.newComments}',
                            style: base!.copyWith(color: AppTheme.kUpvoteColor),
                          ),
                        ),
                      ),
                    const Spacer(),
                    Text(
                      post.createdAt.toRelativeString(context.l10n),
                      style: base,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            // ios menu button has outline and needs to be aligned differently
            padding: context.useIos
                ? const EdgeInsets.symmetric(horizontal: 8)
                : EdgeInsets.zero,
            child: _PostMenuButton(
              post: post,
              muted: muted,
              muteUser: muteUser,
              muteCommunity: muteCommunity,
              onRemoveFromList: onRemoveFromList,
            ),
          ),
        ],
      ),
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
    return AdaptiveInkWell(
      onTap: showSpinner ? null : onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: EdgeInsetsGeometry.all(6),
        child: showSpinner
            ? SizedBox.square(
                dimension: size,
                child: AdaptiveProgressIndicator(
                  strokeWidth: 1.5,
                  color: muted,
                ),
              )
            : Icon(icon, size: size, color: isActive ? activeColor : muted),
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

// ── Hidden placeholder ────────────────────────────────────────────────────────

class _HiddenPlaceholder extends ConsumerWidget {
  const _HiddenPlaceholder({required this.post, required this.withUndo});

  final Post post;
  final bool withUndo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text(
            context.l10n.postHiddenLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          if (withUndo)
            AdaptiveTextButton(
              onPressed: () =>
                  ref.read(hiddenPostsProvider.notifier).unhide(post.id),
              child: Text(context.l10n.undoButton),
            ),
        ],
      ),
    );
  }
}

// ── Post menu button ──────────────────────────────────────────────────────────

class _PostMenuButton extends ConsumerWidget {
  const _PostMenuButton({
    required this.post,
    required this.muted,
    required this.muteUser,
    required this.muteCommunity,
    this.onRemoveFromList,
  });

  final Post post;
  final Color muted;
  final bool muteUser;
  final bool muteCommunity;
  final VoidCallback? onRemoveFromList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).value;
    if (currentUser == null) return const SizedBox(width: 16);

    final isAuthor = currentUser.username == post.username;
    final l10n = context.l10n;

    return AdaptiveMenuButton<_PostMenuAction>(
      androidIcon: Icon(Icons.more_horiz, size: 16, color: muted),
      iconSize: 14,
      iosButtonSize: 28,
      androidPadding: EdgeInsets.zero,
      items: [
        if (onRemoveFromList != null)
          AdaptiveMenuItem(
            value: _PostMenuAction.removeFromList,
            label: l10n.postMenuRemoveFromList,
          )
        else
          AdaptiveMenuItem(
            value: _PostMenuAction.saveToList,
            label: l10n.postMenuSaveToList,
          ),
        if (isAuthor) ...[
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
        AdaptiveMenuItem(value: _PostMenuAction.hide, label: l10n.postMenuHide),
        if (muteUser)
          AdaptiveMenuItem(
            value: _PostMenuAction.muteUser,
            label: l10n.postMenuMuteUser,
          ),
        if (muteCommunity)
          AdaptiveMenuItem(
            value: _PostMenuAction.muteCommunity,
            label: l10n.postMenuMuteCommunity,
          ),
      ],
      onSelected: (action) async {
        switch (action) {
          case .saveToList:
            showPlatformSheet(
              context: context,
              builder: (_) => PostSaveToListSheet(post: post),
            );
          case .removeFromList:
            onRemoveFromList?.call();
          case .editPost:
            context.push('/compose', extra: post);
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
              if (context.mounted) {
                ref.read(hiddenPostsProvider.notifier).hide(post.id);
              }
            } catch (e) {
              if (context.mounted) {
                showPlatformSnackBar(context, e.toString());
              }
            }
          case .hide:
            await ref.read(hiddenPostsProvider.notifier).hide(post.id);
          case .muteCommunity:
            await ref
                .read(communityMutesProvider.notifier)
                .mute(post.communityId, post.communityName);
          case .muteUser:
            await ref
                .read(userMutesProvider.notifier)
                .mute(post.author?.id ?? '', post.author?.username ?? '');
        }
      },
    );
  }
}
