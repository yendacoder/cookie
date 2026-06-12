import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_segmented_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookie/core/utils/markdown_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/markdown_text.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/public_user.dart';
import 'package:cookie/models/user_feed_item.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/posts/widgets/post_card.dart';
import 'package:cookie/features/posts/widgets/post_card_skeleton.dart';
import 'package:cookie/features/shell/providers/nav_bar_visibility_provider.dart';
import 'package:cookie/features/user/providers/user_mutes_provider.dart';
import 'package:cookie/features/user/providers/user_provider.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key, required this.username});

  final String username;

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <= 0) {
      ref.read(navBarVisibilityProvider.notifier).show();
      return;
    }
    switch (_scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        ref.read(navBarVisibilityProvider.notifier).show();
      case ScrollDirection.reverse:
        ref.read(navBarVisibilityProvider.notifier).hide();
      case ScrollDirection.idle:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userDetailProvider(widget.username));

    return userState.when(
      loading: () => AdaptiveScaffold(
        appBar: AdaptiveAppBar(title: Text(widget.username)),
        body: const PostFeedSkeleton(showCommunity: false),
      ),
      error: (error, _) => AdaptiveScaffold(
        appBar: AdaptiveAppBar(title: Text(widget.username)),
        body: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(userDetailProvider(widget.username)),
        ),
      ),
      data: (user) =>
          _UserLoaded(user: user, scrollController: _scrollController),
    );
  }
}

// ── Loaded state ──────────────────────────────────────────────────────────────

class _UserLoaded extends ConsumerStatefulWidget {
  const _UserLoaded({required this.user, required this.scrollController});

  final PublicUser user;
  final ScrollController scrollController;

  @override
  ConsumerState<_UserLoaded> createState() => _UserLoadedState();
}

class _UserLoadedState extends ConsumerState<_UserLoaded> {
  UserActivityFilter _filter = .all;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: AdaptiveRefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userDetailProvider(widget.user.username));
          ref.invalidate(userActivityProvider(widget.user.username, _filter));
          await ref.read(userDetailProvider(widget.user.username).future);
        },
        headerSliverCount: 1,
        child: CustomScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            AdaptiveSliverAppBar(title: Text('@${widget.user.username}')),
            SliverToBoxAdapter(child: _UserHeader(user: widget.user)),
            SliverToBoxAdapter(
              child: _FilterChips(
                filter: _filter,
                onFilterChanged: (f) => setState(() => _filter = f),
              ),
            ),
            _ActivitySliver(user: widget.user, filter: _filter),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

// ── User header ───────────────────────────────────────────────────────────────

class _UserHeader extends ConsumerWidget {
  const _UserHeader({required this.user});

  final PublicUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).value;
    final isAuthenticated = currentUser != null;
    final isOwnProfile = currentUser?.username == user.username;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final muted = colorScheme.onSurfaceVariant;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: colorScheme.primaryContainer,
                    child: user.proPic != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.proPic!.fullUrl,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            user.username.isNotEmpty
                                ? user.username[0].toUpperCase()
                                : '?',
                            style: textTheme.headlineSmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            if (user.isAdmin) ...[
                              Text(
                                context.l10n.userAdmin,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(color: colorScheme.tertiary),
                              ),
                              const SizedBox(height: 12),
                            ],
                            _StatChip(
                              label: context.l10n.pointsLabel(user.points),
                            ),
                            _StatChip(
                              label: context.l10n.postsLabel(user.noPosts),
                            ),
                            _StatChip(
                              label: context.l10n.commentsLabel(
                                user.noComments,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.l10n.userJoined(
                            DateFormat.yMMMM().format(user.createdAt),
                          ),
                          style: textTheme.bodySmall?.copyWith(color: muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (markdownToPlainText(user.aboutMe ?? '').trim()
                  case final String about when about.isNotEmpty) ...[
                const SizedBox(height: 24),
                MarkdownText(about, baseStyle: textTheme.bodyMedium),
              ],
              if (isAuthenticated && !isOwnProfile) ...[
                const SizedBox(height: 12),
                _UserMuteButton(user: user),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
        const AdaptiveDivider(height: 1),
      ],
    );
  }
}

// ── Stat chip ─────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelLarge?.copyWith(color: muted)),
      ],
    );
  }
}

// ── User mute button ──────────────────────────────────────────────────────────

class _UserMuteButton extends ConsumerWidget {
  const _UserMuteButton({required this.user});

  final PublicUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muted = ref.watch(userMutesProvider).contains(user.id);

    return AdaptiveOutlinedButton(
      onPressed: () {
        final notifier = ref.read(userMutesProvider.notifier);
        if (muted) {
          notifier.unmute(user.id);
        } else {
          notifier.mute(user.id, user.username);
        }
      },
      icon: Icon(
        muted ? Icons.volume_up_outlined : Icons.volume_off_outlined,
        size: 18,
      ),
      child: Text(muted ? context.l10n.userUnmute : context.l10n.userMute),
    );
  }
}

// ── Filter chips ──────────────────────────────────────────────────────────────

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.filter, required this.onFilterChanged});

  final UserActivityFilter filter;
  final ValueChanged<UserActivityFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: AdaptiveSegmentedButton<int>(
          segments: [
            AdaptiveButtonSegment(value: 0, label: context.l10n.userTabAll),
            AdaptiveButtonSegment(value: 1, label: context.l10n.userTabPosts),
            AdaptiveButtonSegment(
              value: 2,
              label: context.l10n.userTabComments,
            ),
          ],
          selected: {filter.index},
          onSelectionChanged: (i) =>
              onFilterChanged(UserActivityFilter.values[i.first]),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: [
          FilterChip(
            label: Text(context.l10n.userTabAll),
            selected: filter == UserActivityFilter.all,
            showCheckmark: false,
            onSelected: (_) => onFilterChanged(UserActivityFilter.all),
          ),
          FilterChip(
            label: Text(context.l10n.userTabPosts),
            selected: filter == UserActivityFilter.posts,
            showCheckmark: false,
            onSelected: (_) => onFilterChanged(UserActivityFilter.posts),
          ),
          FilterChip(
            label: Text(context.l10n.userTabComments),
            selected: filter == UserActivityFilter.comments,
            showCheckmark: false,
            onSelected: (_) => onFilterChanged(UserActivityFilter.comments),
          ),
        ],
      ),
    );
  }
}

// ── Activity sliver ───────────────────────────────────────────────────────────

class _ActivitySliver extends ConsumerWidget {
  const _ActivitySliver({required this.user, required this.filter});

  final PublicUser user;
  final UserActivityFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(
      userActivityProvider(user.username, filter),
    );

    return activityState.when(
      loading: () => SliverToBoxAdapter(
        child: PostFeedSkeleton(
          showCommunity: false,
          count: filter == UserActivityFilter.all ? 5 : 3,
        ),
      ),
      error: (error, _) => SliverToBoxAdapter(
        child: ErrorView(
          error: error,
          onRetry: () =>
              ref.invalidate(userActivityProvider(user.username, filter)),
        ),
      ),
      data: (activity) {
        final items = activity.items;

        if (items.isEmpty && !activity.hasMore) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  context.l10n.feedEndOfContent,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }

        return SliverMainAxisGroup(
          slivers: [
            SliverList.separated(
              itemCount: items.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 32),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return _ActivityFooter(
                    activity: activity,
                    username: user.username,
                    filter: filter,
                  );
                }
                final item = items[index];
                final scope = HeroTagScope(.user, id: user.username);
                return switch (item) {
                  UserFeedPost(:final post) => PostCard(
                    post: post,
                    heroTagScope: scope,
                    showCommunity: true,
                    checkMutedUser: false,
                    onTap: () => context.push(
                      '/c/${post.communityName}/post/${post.publicId}',
                      extra: (post: post, heroTagScope: scope),
                    ),
                  ),
                  UserFeedComment(:final comment) => _UserCommentCard(
                    comment: comment,
                  ),
                };
              },
            ),
          ],
        );
      },
    );
  }
}

// ── Comment card ──────────────────────────────────────────────────────────────

class _UserCommentCard extends StatelessWidget {
  const _UserCommentCard({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final muted = colorScheme.onSurfaceVariant;

    return AdaptiveInkWell(
      onTap: () => context.push(
        '/c/${comment.communityName}/post/${comment.postPublicId}',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.mode_comment_outlined, size: 12, color: muted),
                const SizedBox(width: 4),
                Text(
                  comment.communityName,
                  style: textTheme.labelSmall?.copyWith(color: muted),
                ),
                const Spacer(),
                Text(
                  comment.createdAt.toRelativeString(context.l10n),
                  style: textTheme.labelSmall?.copyWith(color: muted),
                ),
              ],
            ),
            const SizedBox(height: 6),
            comment.deleted
                ? Text(
                    context.l10n.postDetailCommentDeleted,
                    style: textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : MarkdownText(comment.body, baseStyle: textTheme.bodySmall),
            if (comment.postTitle case final String title
                when title.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                context.l10n.commentPostReference(title),
                style: textTheme.labelSmall?.copyWith(color: muted),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Activity footer ───────────────────────────────────────────────────────────

class _ActivityFooter extends ConsumerWidget {
  const _ActivityFooter({
    required this.activity,
    required this.username,
    required this.filter,
  });

  final UserActivityState activity;
  final String username;
  final UserActivityFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger loadMore when this widget becomes visible.
    if (!activity.isLoadingMore && activity.hasMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref.read(userActivityProvider(username, filter).notifier).loadMore();
        }
      });
    }

    if (activity.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: AdaptiveProgressIndicator()),
      );
    }

    if (activity.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.feedLoadMoreError,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            AdaptiveTextButton(
              onPressed: () => ref
                  .read(userActivityProvider(username, filter).notifier)
                  .loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (!activity.hasMore) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            context.l10n.feedEndOfContent,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
