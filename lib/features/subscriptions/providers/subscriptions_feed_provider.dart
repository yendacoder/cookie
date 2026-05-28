import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';
import '../../../models/post.dart';
import '../../home/providers/home_feed_provider.dart'
    show PostFeedState, PostSort;

part 'subscriptions_feed_provider.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionsFeedSort extends _$SubscriptionsFeedSort {
  static const _key = 'subscriptions_feed_sort';
  static final _prefs = SharedPreferencesAsync();

  @override
  Future<PostSort> build() async {
    final saved = await _prefs.getString(_key);
    if (saved == null) return PostSort.hot;
    return PostSort.values.firstWhere(
      (s) => s.name == saved,
      orElse: () => PostSort.hot,
    );
  }

  Future<void> setSort(PostSort sort) async {
    if (state.value == sort) return;
    state = AsyncData(sort);
    await _prefs.setString(_key, sort.name);
  }
}

@Riverpod(keepAlive: true)
class SubscriptionsFeedNotifier extends _$SubscriptionsFeedNotifier {
  final _seenIds = <String>{};

  @override
  Future<PostFeedState> build() async {
    _seenIds.clear();
    final sort = await ref.watch(subscriptionsFeedSortProvider.future);
    return _loadPage(sort: sort, cursor: null);
  }

  Future<PostFeedState> _loadPage({
    required PostSort sort,
    required String? cursor,
  }) async {
    final response = await ref
        .read(apiClientProvider)
        .get(
          'posts',
          queryParameters: {
            'feed': 'home',
            'sort': sort.apiValue,
            'next': ?cursor,
          },
        );
    final data = response.data as Map<String, dynamic>;
    final posts = (data['posts'] as List)
        .cast<Map<String, dynamic>>()
        .map(Post.fromJson)
        .where((p) => _seenIds.add(p.id))
        .toList();
    final res = PostFeedState(
      posts: posts,
      nextCursor: data['next']?.toString(),
    );
    return res;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final cursorToLoad = current.nextCursor!;

    state = AsyncData(
      PostFeedState(
        posts: current.posts,
        nextCursor: cursorToLoad,
        isLoadingMore: true,
      ),
    );

    try {
      final sort =
          ref.read(subscriptionsFeedSortProvider).value ?? PostSort.hot;
      final page = await _loadPage(sort: sort, cursor: cursorToLoad);

      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(
          PostFeedState(
            posts: [...value.posts, ...page.posts],
            nextCursor: page.nextCursor,
          ),
        );
      }
    } catch (e) {
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(
          PostFeedState(
            posts: value.posts,
            nextCursor: value.nextCursor,
            loadMoreError: e,
          ),
        );
      }
    }
  }
}
