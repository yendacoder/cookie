import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/features/posts/providers/read_new_comments_notifier.dart';
import 'package:cookie/models/user_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_items_provider.g.dart';

class ListItemFeedState {
  ListItemFeedState({
    required this.items,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<ListItem> items;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
}

@riverpod
class ListItemsNotifier extends _$ListItemsNotifier {
  @override
  Future<ListItemFeedState> build(int listId) => _loadPage(null);

  Future<ListItemFeedState> _loadPage(String? cursor) async {
    final response = await ref
        .read(apiClientProvider)
        .get('lists/$listId/items', queryParameters: {'next': ?cursor});
    final data = response.data as Map<String, dynamic>;
    if (cursor == null) {
      ref
          .read(
            readNewCommentsProvider(
              HeroTagScope(.list, id: listId.toString()).toString(),
            ).notifier,
          )
          .clear();
    }
    return ListItemFeedState(
      items: (data['items'] as List)
          .cast<Map<String, dynamic>>()
          .map(ListItem.fromJson)
          .toList(),
      nextCursor: data['next']?.toString(),
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final cursor = current.nextCursor!;
    state = AsyncData(
      ListItemFeedState(
        items: current.items,
        nextCursor: cursor,
        isLoadingMore: true,
      ),
    );

    try {
      final page = await _loadPage(cursor);
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursor) {
        state = AsyncData(
          ListItemFeedState(
            items: [...value.items, ...page.items],
            nextCursor: page.nextCursor,
          ),
        );
      }
    } catch (e) {
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursor) {
        state = AsyncData(
          ListItemFeedState(
            items: value.items,
            nextCursor: value.nextCursor,
            loadMoreError: e,
          ),
        );
      }
    }
  }

  Future<void> removeItem(int itemId) async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      ListItemFeedState(
        items: current.items.where((i) => i.id != itemId).toList(),
        nextCursor: current.nextCursor,
      ),
    );
    try {
      await ref.read(apiClientProvider).delete('lists/$listId/items/$itemId');
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }
}
