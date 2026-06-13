import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/feed/models/feed_type.dart';
import 'package:cookie/features/feed/models/post_feed_state.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/features/posts/providers/read_new_comments_notifier.dart';

part 'feed_provider.g.dart';

@Riverpod(keepAlive: true)
class FeedSort extends _$FeedSort {
  static final _prefs = SharedPreferencesAsync();

  // Stored from build() so setSort() can access it without the family arg.
  late FeedType _type;

  @override
  Future<PostSort> build(FeedType type) async {
    _type = type;
    final saved = await _prefs.getString(type.sortPrefsKey);
    if (saved == null) return PostSort.hot;
    return PostSort.values.firstWhere(
      (s) => s.name == saved,
      orElse: () => PostSort.hot,
    );
  }

  Future<void> setSort(PostSort sort) async {
    if (state.value == sort) return;
    state = AsyncData(sort);
    await _prefs.setString(_type.sortPrefsKey, sort.name);
  }
}

@Riverpod(keepAlive: true)
class FeedNotifier extends _$FeedNotifier {
  final _seenIds = <String>{};

  // Stored from build() so loadMore() can access it without the family arg.
  late FeedType _type;

  @override
  Future<PostFeedState> build(FeedType type) async {
    _type = type;
    _seenIds.clear();
    final sort = await ref.watch(feedSortProvider(type).future);
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
            if (_type.apiFeedParam != null) 'feed': _type.apiFeedParam,
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

    if (cursor == null) {
      ref
          .read(readNewCommentsProvider(_type.heroTagScope.toString()).notifier)
          .clear();
    }
    return PostFeedState(posts: posts, nextCursor: data['next']?.toString());
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
      final sort = ref.read(feedSortProvider(_type)).value ?? PostSort.hot;
      final page = await _loadPage(sort: sort, cursor: cursorToLoad);

      // Guard against stale completions after a sort change resets the state.
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
