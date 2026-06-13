import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/models/public_user.dart';
import 'package:cookie/models/user_feed_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

// ── User detail ───────────────────────────────────────────────────────────────

@riverpod
class UserDetailNotifier extends _$UserDetailNotifier {
  @override
  Future<PublicUser> build(String username) async {
    final response = await ref.read(apiClientProvider).get('users/$username');
    return PublicUser.fromJson(response.data as Map<String, dynamic>);
  }
}

// ── User activity filter ──────────────────────────────────────────────────────

enum UserActivityFilter { all, posts, comments }

// ── User activity state ───────────────────────────────────────────────────────

class UserActivityState {
  UserActivityState({
    required this.items,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<UserFeedItem> items;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
}

// ── User activity notifier ────────────────────────────────────────────────────

@riverpod
class UserActivityNotifier extends _$UserActivityNotifier {
  final _seenIds = <String>{};
  late String _username;
  late UserActivityFilter _filter;

  @override
  Future<UserActivityState> build(
    String username,
    UserActivityFilter filter,
  ) async {
    _username = username;
    _filter = filter;
    _seenIds.clear();
    return _loadPage(cursor: null);
  }

  Future<UserActivityState> _loadPage({required String? cursor}) async {
    final response = await ref
        .read(apiClientProvider)
        .get(
          'users/$_username/feed',
          queryParameters: {
            'next': ?cursor,
            if (_filter != UserActivityFilter.all) 'filter': _filter.name,
          },
        );
    final data = response.data as Map<String, dynamic>;
    final rawItems = (data['items'] as List).cast<Map<String, dynamic>>();

    final items = <UserFeedItem>[];
    for (final raw in rawItems) {
      try {
        final type = raw['type'] as String?;
        final itemData = raw['item'] as Map<String, dynamic>;
        switch (type) {
          case 'post':
            final post = Post.fromJson(itemData);
            if (_seenIds.add('p_${post.id}')) {
              items.add(UserFeedPost(post));
            }
          case 'comment':
            final comment = Comment.fromJson(itemData);
            if (_seenIds.add('c_${comment.id}')) {
              items.add(UserFeedComment(comment));
            }
          default:
            // Unknown type — skip silently.
            break;
        }
      } catch (_) {
        // Skip items that fail to parse.
      }
    }

    return UserActivityState(
      items: items,
      nextCursor: data['next']?.toString(),
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final cursorToLoad = current.nextCursor!;

    state = AsyncData(
      UserActivityState(
        items: current.items,
        nextCursor: cursorToLoad,
        isLoadingMore: true,
      ),
    );

    try {
      final page = await _loadPage(cursor: cursorToLoad);

      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(
          UserActivityState(
            items: [...value.items, ...page.items],
            nextCursor: page.nextCursor,
          ),
        );
      }
    } catch (e) {
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.nextCursor == cursorToLoad) {
        state = AsyncData(
          UserActivityState(
            items: value.items,
            nextCursor: value.nextCursor,
            loadMoreError: e,
          ),
        );
      }
    }
  }
}
