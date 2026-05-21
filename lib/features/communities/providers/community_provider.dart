import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';
import '../../../models/community.dart';
import '../../../models/post.dart';
import '../../home/providers/home_feed_provider.dart';

part 'community_provider.g.dart';

// ── Community detail ──────────────────────────────────────────────────────────

@riverpod
class CommunityDetail extends _$CommunityDetail {
  @override
  Future<Community> build(String communityName) async {
    final response = await ref.read(apiClientProvider).get(
      'communities/$communityName',
      queryParameters: {'byName': 'true'},
    );
    return Community.fromJson(response.data as Map<String, dynamic>);
  }

  /// Directly replaces the community state — used by mod tools after mutations
  /// to avoid a network round-trip and prevent loading flicker.
  void replace(Community community) => state = AsyncData(community);

  /// Toggles the current user's membership of the community.
  Future<void> toggleJoin() async {
    final community = state.value;
    if (community == null) return;

    final leaving = community.userJoined == true;

    // Optimistic update.
    state = AsyncData(community.copyWith(
      userJoined: !leaving,
      noMembers: leaving ? community.noMembers - 1 : community.noMembers + 1,
    ));

    try {
      final response = await ref.read(apiClientProvider).post(
        '_joinCommunity',
        data: {'communityId': community.id, 'leave': leaving},
      );
      state = AsyncData(
        Community.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (_) {
      state = AsyncData(community); // revert on failure
    }
  }
}

// ── Per-community sort preference ─────────────────────────────────────────────

@riverpod
class CommunityFeedSort extends _$CommunityFeedSort {
  static final _prefs = SharedPreferencesAsync();
  // Stored from build() so setSort() can access it without the argument.
  late String _communityName;

  @override
  Future<PostSort> build(String communityName) async {
    _communityName = communityName;
    final saved = await _prefs.getString('community_sort_$communityName');
    if (saved == null) return PostSort.hot;
    return PostSort.values.firstWhere(
      (s) => s.name == saved,
      orElse: () => PostSort.hot,
    );
  }

  Future<void> setSort(PostSort sort) async {
    state = AsyncData(sort);
    await _prefs.setString('community_sort_$_communityName', sort.name);
  }
}

// ── Community post feed ───────────────────────────────────────────────────────

@riverpod
class CommunityFeedNotifier extends _$CommunityFeedNotifier {
  final _seenIds = <String>{};
  // Stored from build() so loadMore() can access them without the family args.
  late String _communityName;
  late String _communityId;

  @override
  Future<PostFeedState> build(String communityName, String communityId) async {
    _communityName = communityName;
    _communityId = communityId;
    _seenIds.clear();
    final sort =
        await ref.watch(communityFeedSortProvider(communityName).future);
    return _loadPage(sort: sort, cursor: null);
  }

  Future<PostFeedState> _loadPage({
    required PostSort sort,
    required String? cursor,
  }) async {
    final response = await ref.read(apiClientProvider).get(
      'posts',
      queryParameters: {
        'feed': 'community',
        'sort': sort.apiValue,
        'communityId': _communityId,
        'next': ?cursor,
      },
    );
    final data = response.data as Map<String, dynamic>;
    final posts = (data['posts'] as List)
        .cast<Map<String, dynamic>>()
        .map(Post.fromJson)
        .where((p) => _seenIds.add(p.id))
        .toList();

    return PostFeedState(posts: posts, nextCursor: data['next']?.toString());
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final cursorToLoad = current.nextCursor!;

    state = AsyncData(PostFeedState(
      posts: current.posts,
      nextCursor: cursorToLoad,
      isLoadingMore: true,
    ));

    try {
      final sort = ref
              .read(communityFeedSortProvider(_communityName))
              .value ??
          PostSort.hot;
      final page = await _loadPage(sort: sort, cursor: cursorToLoad);

      if (state case AsyncData(:final value)
          when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(PostFeedState(
          posts: [...value.posts, ...page.posts],
          nextCursor: page.nextCursor,
        ));
      }
    } catch (e) {
      if (state case AsyncData(:final value)
          when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(PostFeedState(
          posts: value.posts,
          nextCursor: value.nextCursor,
          loadMoreError: e,
        ));
      }
    }
  }
}
