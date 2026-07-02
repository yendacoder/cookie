import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_mod_posts_provider.g.dart';

enum ModPostsFilter {
  removed,
  locked;

  /// Maps to the API's `filter` query parameter value.
  String get apiValue => switch (this) {
    .removed => 'deleted',
    .locked => 'locked',
  };
}

class CommunityModPostsState {
  CommunityModPostsState({
    required this.posts,
    required this.total,
    required this.page,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<Post> posts;
  final int total;
  final int page;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => posts.length < total;
}

const _kPageSize = 10;

@riverpod
class CommunityModPosts extends _$CommunityModPosts {
  late String _communityId;
  late ModPostsFilter _filter;

  @override
  Future<CommunityModPostsState> build(
    String communityId,
    ModPostsFilter filter,
  ) async {
    _communityId = communityId;
    _filter = filter;
    return _loadPage(1);
  }

  Future<CommunityModPostsState> _loadPage(int page) async {
    final response = await ref
        .read(apiClientProvider)
        .get(
          'posts',
          queryParameters: {
            'filter': _filter.apiValue,
            'communityId': _communityId,
            'page': page,
            'limit': _kPageSize,
          },
        );
    final data = response.data as Map<String, dynamic>;
    final total = (data['noPosts'] as num).toInt();
    final posts = ((data['posts'] as List?) ?? const [])
        .cast<Map<String, dynamic>>()
        .map(Post.fromJson)
        .toList();
    return CommunityModPostsState(posts: posts, total: total, page: page);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final loadedPage = current.page;
    state = AsyncData(
      CommunityModPostsState(
        posts: current.posts,
        total: current.total,
        page: current.page,
        isLoadingMore: true,
      ),
    );

    try {
      final next = await _loadPage(loadedPage + 1);
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.page == loadedPage) {
        state = AsyncData(
          CommunityModPostsState(
            posts: [...value.posts, ...next.posts],
            total: next.total,
            page: loadedPage + 1,
          ),
        );
      }
    } catch (e) {
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.page == loadedPage) {
        state = AsyncData(
          CommunityModPostsState(
            posts: value.posts,
            total: value.total,
            page: value.page,
            loadMoreError: e,
          ),
        );
      }
    }
  }
}
