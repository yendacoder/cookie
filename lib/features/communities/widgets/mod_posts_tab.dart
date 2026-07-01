import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/features/communities/providers/community_mod_posts_provider.dart';
import 'package:cookie/features/posts/screens/post_detail_screen.dart';
import 'package:cookie/features/posts/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A mod-tools tab showing either removed or locked posts for a community.
class ModPostsTab extends ConsumerStatefulWidget {
  const ModPostsTab({
    super.key,
    required this.communityId,
    required this.filter,
  });

  final String communityId;
  final ModPostsFilter filter;

  @override
  ConsumerState<ModPostsTab> createState() => _ModPostsTabState();
}

class _ModPostsTabState extends ConsumerState<ModPostsTab> {
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
      ref
          .read(
            communityModPostsProvider(widget.communityId, widget.filter)
                .notifier,
          )
          .loadMore();
    }
  }

  String _emptyLabel(BuildContext context) {
    final l10n = context.l10n;
    return switch (widget.filter) {
      .removed => l10n.modToolsRemovedEmpty,
      .locked => l10n.modToolsLockedEmpty,
    };
  }

  @override
  Widget build(BuildContext context, [WidgetRef? _]) {
    final postsAsync = ref.watch(
      communityModPostsProvider(widget.communityId, widget.filter),
    );

    return switch (postsAsync) {
      AsyncData(:final value) when value.posts.isEmpty => Center(
        child: Text(
          _emptyLabel(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      AsyncData(:final value) => ListView.separated(
        controller: _scrollController,
        itemCount: value.posts.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 32),
        padding: const .only(top: 16),
        itemBuilder: (context, index) {
          if (index == value.posts.length) {
            return _ModPostsFooter(
              state: value,
              communityId: widget.communityId,
              filter: widget.filter,
            );
          }
          final post = value.posts[index];
          const scope = HeroTagScope(.moderating);
          return PostCard(
            post: post,
            heroTagScope: scope,
            showCommunity: false,
            onTap: () => context.push(
              '/c/${post.communityName}/post/${post.publicId}',
              extra: PostDetailArgs(post: post, heroTagScope: scope),
            ),
          );
        },
      ),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(
          communityModPostsProvider(widget.communityId, widget.filter),
        ),
      ),
      _ => const Center(child: AdaptiveProgressIndicator()),
    };
  }
}

// ── Footer (loading / load-more error / end of content) ──────────────────────

class _ModPostsFooter extends ConsumerWidget {
  const _ModPostsFooter({
    required this.state,
    required this.communityId,
    required this.filter,
  });

  final CommunityModPostsState state;
  final String communityId;
  final ModPostsFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: AdaptiveProgressIndicator()),
      );
    }

    if (state.loadMoreError != null) {
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
                  .read(
                    communityModPostsProvider(communityId, filter).notifier,
                  )
                  .loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
