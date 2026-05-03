import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/error_view.dart';
import '../../../models/comment.dart';
import '../../../models/discuit_image.dart';
import '../../../models/public_user.dart';
import '../../../models/user_feed_item.dart';
import '../../auth/providers/auth_provider.dart';
import '../../posts/widgets/post_card.dart';
import '../../posts/widgets/post_card_skeleton.dart';
import '../../shell/providers/nav_bar_visibility_provider.dart';
import '../providers/user_mutes_provider.dart';
import '../providers/user_provider.dart';

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
    final userState =
        ref.watch(userDetailProvider(widget.username));

    return userState.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(widget.username)),
        body: const PostFeedSkeleton(showCommunity: false),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: Text(widget.username)),
        body: ErrorView(
          error: error,
          onRetry: () =>
              ref.invalidate(userDetailProvider(widget.username)),
        ),
      ),
      data: (user) => _UserLoaded(
        user: user,
        scrollController: _scrollController,
      ),
    );
  }
}

// ── Loaded state ──────────────────────────────────────────────────────────────

class _UserLoaded extends ConsumerStatefulWidget {
  const _UserLoaded({
    required this.user,
    required this.scrollController,
  });

  final PublicUser user;
  final ScrollController scrollController;

  @override
  ConsumerState<_UserLoaded> createState() => _UserLoadedState();
}

class _UserLoadedState extends ConsumerState<_UserLoaded> {
  UserActivityFilter _filter = UserActivityFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userDetailProvider(widget.user.username));
          ref.invalidate(userActivityProvider(widget.user.username));
          await ref
              .read(userDetailProvider(widget.user.username).future);
        },
        child: CustomScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(widget.user.username),
            ),
            SliverToBoxAdapter(
              child: _UserHeader(user: widget.user),
            ),
            SliverToBoxAdapter(
              child: _FilterChips(
                filter: _filter,
                onFilterChanged: (f) => setState(() => _filter = f),
              ),
            ),
            _ActivitySliver(
              user: widget.user,
              filter: _filter,
            ),
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
    final isAuthenticated = ref.watch(authProvider).value != null;
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
                        Text(
                          '@${user.username}',
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            _StatChip(
                              label: context.l10n.pointsLabel(user.points),
                            ),
                            const SizedBox(width: 12),
                            _StatChip(
                              label: context.l10n.postsLabel(user.noPosts),
                            ),
                            const SizedBox(width: 12),
                            _StatChip(
                              label: context.l10n.commentsLabel(user.noComments),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          context.l10n.userJoined(
                            DateFormat.yMMMM().format(user.createdAt),
                          ),
                          style: textTheme.bodySmall
                              ?.copyWith(color: muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (user.aboutMe case final String about when about.isNotEmpty)
                ...[
                const SizedBox(height: 12),
                Text(about, style: textTheme.bodyMedium),
              ],
              const SizedBox(height: 12),
              if (isAuthenticated)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _UserMuteButton(user: user),
                  ],
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const Divider(height: 1),
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
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(color: muted),
        ),
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

    return OutlinedButton.icon(
      onPressed: () {
        final notifier = ref.read(userMutesProvider.notifier);
        if (muted) {
          notifier.unmute(user.id);
        } else {
          notifier.mute(user.id);
        }
      },
      icon: Icon(
        muted ? Icons.volume_up_outlined : Icons.volume_off_outlined,
        size: 18,
      ),
      label: Text(muted ? context.l10n.userUnmute : context.l10n.userMute),
    );
  }
}

// ── Filter chips ──────────────────────────────────────────────────────────────

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filter,
    required this.onFilterChanged,
  });

  final UserActivityFilter filter;
  final ValueChanged<UserActivityFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
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
    final activityState =
        ref.watch(userActivityProvider(user.username));

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
              ref.invalidate(userActivityProvider(user.username)),
        ),
      ),
      data: (activity) {
        final List<UserFeedItem> filteredItems = switch (filter) {
          UserActivityFilter.all => activity.items,
          UserActivityFilter.posts =>
            activity.items.whereType<UserFeedPost>().toList(),
          UserActivityFilter.comments =>
            activity.items.whereType<UserFeedComment>().toList(),
        };

        if (filteredItems.isEmpty && !activity.hasMore) {
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
              itemCount: filteredItems.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 32),
              itemBuilder: (context, index) {
                if (index == filteredItems.length) {
                  return _ActivityFooter(
                    activity: activity,
                    username: user.username,
                  );
                }
                final item = filteredItems[index];
                return switch (item) {
                  UserFeedPost(:final post) => PostCard(
                      post: post,
                      showCommunity: true,
                      onTap: () => context.push(
                        '/c/${post.communityName}/post/${post.publicId}',
                        extra: post,
                      ),
                    ),
                  UserFeedComment(:final comment) =>
                    _UserCommentCard(comment: comment),
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

    return InkWell(
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
                Icon(
                  Icons.mode_comment_outlined,
                  size: 12,
                  color: muted,
                ),
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
            Text(
              comment.deleted ? '[deleted]' : comment.body,
              style: textTheme.bodySmall?.copyWith(
                fontStyle: comment.deleted ? FontStyle.italic : null,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (comment.postTitle case final String title when title.isNotEmpty)
              ...[
              const SizedBox(height: 4),
              Text(
                'on: $title',
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
  });

  final UserActivityState activity;
  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger loadMore when this widget becomes visible.
    if (!activity.isLoadingMore && activity.hasMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref
              .read(userActivityProvider(username).notifier)
              .loadMore();
        }
      });
    }

    if (activity.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
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
            TextButton(
              onPressed: () => ref
                  .read(userActivityProvider(username).notifier)
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
