import 'package:cookie/core/hero_tag_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/features/posts/providers/read_new_comments_notifier.dart';

part 'home_feed_provider.g.dart';

enum PostSort {
  hot,
  latest,
  activity,
  day,
  week,
  month,
  year,
  all;

  /// Matches the API's `sort` query parameter values exactly.
  String get apiValue => name;

  String label(AppLocalizations l10n) => switch (this) {
    hot => l10n.sortHot,
    latest => l10n.sortNew,
    activity => l10n.sortActivity,
    day => l10n.sortDay,
    week => l10n.sortWeek,
    month => l10n.sortMonth,
    year => l10n.sortYear,
    all => l10n.sortAll,
  };
}

class PostFeedState {
  PostFeedState({
    required this.posts,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<Post> posts;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
}

@Riverpod(keepAlive: true)
class HomeFeedSort extends _$HomeFeedSort {
  static const _key = 'home_feed_sort';
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
class HomeFeedNotifier extends _$HomeFeedNotifier {
  final _seenIds = <String>{};

  @override
  Future<PostFeedState> build() async {
    _seenIds.clear();
    final sort = await ref.watch(homeFeedSortProvider.future);
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
          queryParameters: {'sort': sort.apiValue, 'next': ?cursor},
        );
    final data = response.data as Map<String, dynamic>;
    final posts = (data['posts'] as List)
        .cast<Map<String, dynamic>>()
        .map(Post.fromJson)
        .where((p) => _seenIds.add(p.id))
        .toList();
    if (cursor == null) {
      ref
          .read(
            readNewCommentsProvider(HeroTagScope(.home).toString()).notifier,
          )
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
      final sort = ref.read(homeFeedSortProvider).value ?? PostSort.hot;
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
