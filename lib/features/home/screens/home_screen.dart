import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_filter_chip.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/consts.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/adaptive/adaptive_progress_indicator.dart';
import '../../../core/widgets/default_app_bar.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/providers/auth_provider.dart';
import '../../posts/widgets/post_card.dart';
import '../../posts/widgets/post_card_skeleton.dart';
import '../../shell/providers/nav_bar_visibility_provider.dart';
import '../providers/home_feed_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();
  double _anchorOffset = 0;
  ScrollDirection _lastDirection = ScrollDirection.idle;

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
      ref.read(homeFeedProvider.notifier).loadMore();
    }

    // Always show bars when at the very top.
    if (_scrollController.position.pixels <= 0) {
      ref.read(navBarVisibilityProvider.notifier).show();
      return;
    }

    final pos = _scrollController.position;
    final direction = pos.userScrollDirection;
    if (direction != ScrollDirection.idle && direction != _lastDirection) {
      _anchorOffset = pos.pixels;
      _lastDirection = direction;
    }

    final delta = (pos.pixels - _anchorOffset).abs();

    switch (_scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        if (delta >= kScrollNavigationShowThreshold) {
          ref.read(navBarVisibilityProvider.notifier).show();
        }
      case ScrollDirection.reverse:
        if (delta >= kScrollNavigationHideThreshold) {
          ref.read(navBarVisibilityProvider.notifier).hide();
        }
      case ScrollDirection.idle:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return authState.when(
      loading: () => Scaffold(
        appBar: DefaultAppBar(title: context.l10n.homeScreenTitle),
        body: const Center(child: AdaptiveProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: DefaultAppBar(title: context.l10n.homeScreenTitle),
        body: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(authProvider),
        ),
      ),
      // The data state embeds a SliverAppBar so it collapses with the content.
      data: (user) =>
          Scaffold(body: _FeedView(scrollController: _scrollController)),
    );
  }
}

// ── Feed ──────────────────────────────────────────────────────────────────────

class _FeedView extends ConsumerWidget {
  const _FeedView({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(homeFeedProvider);
    ref.listen(homeFeedProvider, (previous, next) {
      if (previous?.hasValue == true && next.isLoading) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    return AdaptiveRefreshIndicator(
      onRefresh: () async {
        ref.invalidate(homeFeedProvider);
        await ref.read(homeFeedProvider.future);
      },
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          DefaultSliverAppBar(title: context.l10n.homeScreenTitle, pinned: false),
          SliverToBoxAdapter(child: _SortChips()),
          feedState.when(
            loading: () => const SliverToBoxAdapter(child: PostFeedSkeleton()),
            error: (error, _) => SliverFillRemaining(
              child: ErrorView(
                error: error,
                onRetry: () => ref.invalidate(homeFeedProvider),
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
    final current = ref.watch(homeFeedSortProvider).value ?? PostSort.hot;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: [
          for (final sort in PostSort.values)
            AdaptiveFilterChip(
              label: sort.label(context.l10n),
              selected: sort == current,
              onSelected: (_) =>
                  ref.read(homeFeedSortProvider.notifier).setSort(sort),
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
        child: Center(child: AdaptiveProgressIndicator()),
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
            AdaptiveTextButton(
              onPressed: () => ref.read(homeFeedProvider.notifier).loadMore(),
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
