import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/widgets/auth_gate.dart';
import '../../home/providers/home_feed_provider.dart' show PostFeedState, PostSort;
import '../../posts/widgets/post_card.dart';
import '../../posts/widgets/post_card_skeleton.dart';
import '../../shell/providers/nav_bar_visibility_provider.dart';
import '../providers/subscriptions_feed_provider.dart';

class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  ConsumerState<SubscriptionsScreen> createState() =>
      _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends ConsumerState<SubscriptionsScreen> {
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
    if (_scrollController.position.extentAfter < 400) {
      ref.read(subscriptionsFeedProvider.notifier).loadMore();
    }

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
    final authState = ref.watch(authProvider);

    return authState.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(context.l10n.subscriptionsScreenTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: Text(context.l10n.subscriptionsScreenTitle)),
        body: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(authProvider),
        ),
      ),
      data: (_) => Scaffold(
        body: AuthGate(
          child: _FeedView(scrollController: _scrollController),
        ),
      ),
    );
  }
}

// ── Feed ──────────────────────────────────────────────────────────────────────

class _FeedView extends ConsumerWidget {
  const _FeedView({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(subscriptionsFeedProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(subscriptionsFeedProvider);
        await ref.read(subscriptionsFeedProvider.future);
      },
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(context.l10n.subscriptionsScreenTitle),
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(child: _SortChips()),
          feedState.when(
            loading: () => const SliverToBoxAdapter(
              child: PostFeedSkeleton(),
            ),
            error: (error, _) => SliverFillRemaining(
              child: ErrorView(
                error: error,
                onRetry: () => ref.invalidate(subscriptionsFeedProvider),
              ),
            ),
            data: (feed) => SliverMainAxisGroup(
              slivers: [
                SliverList.separated(
                  itemCount: feed.posts.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(height: 32),
                  itemBuilder: (context, index) {
                    if (index == feed.posts.length) {
                      return _FeedFooter(feed: feed, ref: ref);
                    }
                    final post = feed.posts[index];
                    return PostCard(
                      post: post,
                      onTap: () => context.push(
                        '/c/${post.communityName}/post/${post.publicId}',
                        extra: post,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sort chips ────────────────────────────────────────────────────────────────

class _SortChips extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current =
        ref.watch(subscriptionsFeedSortProvider).value ?? PostSort.hot;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: [
          for (final sort in PostSort.values)
            FilterChip(
              label: Text(sort.label(context.l10n)),
              selected: sort == current,
              showCheckmark: false,
              onSelected: (_) =>
                  ref.read(subscriptionsFeedSortProvider.notifier).setSort(sort),
            ),
        ],
      ),
    );
  }
}

// ── List footer ───────────────────────────────────────────────────────────────

class _FeedFooter extends StatelessWidget {
  const _FeedFooter({required this.feed, required this.ref});

  final PostFeedState feed;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    if (feed.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (feed.loadMoreError != null) {
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
              onPressed: () =>
                  ref.read(subscriptionsFeedProvider.notifier).loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (!feed.hasMore) {
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
