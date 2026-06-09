import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/markdown_text.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/models/user_list.dart';
import 'package:cookie/features/posts/widgets/post_card.dart';
import 'package:cookie/features/posts/widgets/post_card_skeleton.dart';
import 'package:cookie/features/lists/providers/list_items_provider.dart';
import 'package:cookie/features/lists/providers/user_lists_provider.dart';
import 'package:cookie/features/lists/widgets/list_form_sheet.dart';

class ListDetailScreen extends ConsumerStatefulWidget {
  const ListDetailScreen({super.key, required this.listId, this.initialList});

  final int listId;
  final UserList? initialList;

  @override
  ConsumerState<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends ConsumerState<ListDetailScreen> {
  late UserList? _list;

  @override
  void initState() {
    super.initState();
    _list = widget.initialList;
  }

  Future<void> _showEditSheet() async {
    if (_list == null) return;
    await showPlatformSheet(
      context: context,
      builder: (_) => ListFormSheet(
        initial: _list,
        onSave:
            ({
              required name,
              required displayName,
              description,
              required public,
            }) async {
              final response = await ref
                  .read(apiClientProvider)
                  .put(
                    'lists/${widget.listId}',
                    data: {
                      'name': name,
                      'displayName': displayName,
                      'description': description,
                      'public': public,
                    },
                  );
              final updated = UserList.fromJson(
                response.data as Map<String, dynamic>,
              );
              if (mounted) setState(() => _list = updated);
              ref.read(userListsProvider.notifier).updateList(updated);
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _list?.displayName ?? '';

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(title),
        actions: [
          if (_list != null)
            IconButton(
              icon: Icon(context.editIcon),
              tooltip: context.l10n.listsEditTitle,
              onPressed: _showEditSheet,
            ),
        ],
      ),
      body: _ListDetailBody(listId: widget.listId, list: _list),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _ListDetailBody extends ConsumerWidget {
  const _ListDetailBody({required this.listId, required this.list});

  final int listId;
  final UserList? list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(listItemsProvider(listId));

    return AdaptiveRefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listItemsProvider(listId));
        await ref.read(listItemsProvider(listId).future);
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Description header
          if (list?.description case final String desc when desc.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Text(
                  desc,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),

          switch (feedState) {
            AsyncLoading() => SliverToBoxAdapter(
              child: PostFeedSkeleton(showCommunity: true),
            ),
            AsyncError(:final error) => SliverFillRemaining(
              child: ErrorView(
                error: error,
                onRetry: () => ref.invalidate(listItemsProvider(listId)),
              ),
            ),
            AsyncData(:final value) => _ItemsSliver(
              feed: value,
              listId: listId,
            ),
          },

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// ── Items sliver ──────────────────────────────────────────────────────────────

class _ItemsSliver extends ConsumerWidget {
  const _ItemsSliver({required this.feed, required this.listId});

  final ListItemFeedState feed;
  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (feed.items.isEmpty && !feed.hasMore) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            context.l10n.listItemsEmpty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverList.builder(
          itemCount: feed.items.length,
          itemBuilder: (context, index) {
            final item = feed.items[index];
            return _ItemTile(item: item, listId: listId);
          },
        ),
        SliverToBoxAdapter(
          child: _ItemsFooter(feed: feed, listId: listId),
        ),
      ],
    );
  }
}

// ── Item tile ─────────────────────────────────────────────────────────────────

class _ItemTile extends ConsumerWidget {
  const _ItemTile({required this.item, required this.listId});

  final ListItem item;
  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: colorScheme.error,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(context.deleteIcon, color: colorScheme.onError),
                const SizedBox(height: 4),
                Text(
                  context.l10n.listItemRemove,
                  style: TextStyle(color: colorScheme.onError, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (_) =>
          ref.read(listItemsProvider(listId).notifier).removeItem(item.id),
      child: _itemContent(context, ref),
    );
  }

  Widget _itemContent(BuildContext context, WidgetRef ref) {
    if (item.targetType == 'post' && item.targetItem != null) {
      final post = Post.fromJson(item.targetItem!);
      return PostCard(
        post: post,
        heroTagScope: 'list',
        showCommunity: true,
        checkMutedCommunity: false,
        checkMutedUser: false,
        onTap: () => context.push(
          '/c/${post.communityName}/post/${post.publicId}',
          extra: (post: post, heroTagScope: 'list'),
        ),
        onRemoveFromList: () =>
            ref.read(listItemsProvider(listId).notifier).removeItem(item.id),
      );
    }
    if (item.targetType == 'comment' && item.targetItem != null) {
      final comment = Comment.fromJson(item.targetItem!);
      return _CommentItem(comment: comment);
    }
    return const SizedBox.shrink();
  }
}

// ── Comment item ──────────────────────────────────────────────────────────────

class _CommentItem extends StatelessWidget {
  const _CommentItem({required this.comment});

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
          ],
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _ItemsFooter extends ConsumerWidget {
  const _ItemsFooter({required this.feed, required this.listId});

  final ListItemFeedState feed;
  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!feed.isLoadingMore && feed.hasMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref.read(listItemsProvider(listId).notifier).loadMore();
        }
      });
    }

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
              onPressed: () =>
                  ref.read(listItemsProvider(listId).notifier).loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (!feed.hasMore && feed.items.isNotEmpty) {
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
