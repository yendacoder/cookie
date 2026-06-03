import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/home/providers/home_feed_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

/// Overrides HomeFeedSort to return a fixed value without touching prefs.
class _FixedSort extends HomeFeedSort {
  _FixedSort(this._sort);

  final PostSort _sort;

  @override
  Future<PostSort> build() async => _sort;
}

Map<String, dynamic> _postJson(String id) => {
  'id': id,
  'type': 'text',
  'publicId': 'pub-$id',
  'userId': 'user-1',
  'username': 'testuser',
  'userGroup': 'normal',
  'userDeleted': false,
  'isPinned': false,
  'isPinnedSite': false,
  'communityId': 'comm-1',
  'communityName': 'testcomm',
  'title': 'Post $id',
  'locked': false,
  'upvotes': 0,
  'downvotes': 0,
  'hotness': 0,
  'createdAt': '2024-01-01T00:00:00.000Z',
  'lastActivityAt': '2024-01-01T00:00:00.000Z',
  'deleted': false,
  'deletedContent': false,
  'noComments': 0,
  'isAuthorMuted': false,
  'isCommunityMuted': false,
};

Response<dynamic> _page(List<String> ids, {String? next}) => Response(
  data: {'posts': ids.map(_postJson).toList(), 'next': next},
  statusCode: 200,
  requestOptions: RequestOptions(path: ''),
);

ProviderContainer _container(_MockDio dio) => ProviderContainer(
  overrides: [
    apiClientProvider.overrideWithValue(dio),
    homeFeedSortProvider.overrideWith(() => _FixedSort(PostSort.hot)),
  ],
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _MockDio mockDio;

  setUp(() => mockDio = _MockDio());

  group('HomeFeedNotifier — initial load', () {
    test('returns posts from first page', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['a', 'b', 'c'], next: 'cur1'));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(homeFeedProvider.future);
      expect(state.posts.map((p) => p.id), ['a', 'b', 'c']);
      expect(state.nextCursor, 'cur1');
      expect(state.hasMore, true);
    });

    test('hasMore is false when next is null', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['a']));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(homeFeedProvider.future);
      expect(state.hasMore, false);
    });
  });

  group('HomeFeedNotifier — deduplication', () {
    test('duplicate ids across pages are dropped', () async {
      // First call returns 'a','b'. Second call returns 'b','c' — 'b' is dup.
      var callCount = 0;
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        return callCount == 1
            ? _page(['a', 'b'], next: 'cur1')
            : _page(['b', 'c']);
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(homeFeedProvider.future);
      await container.read(homeFeedProvider.notifier).loadMore();

      final state = container.read(homeFeedProvider).value!;
      final ids = state.posts.map((p) => p.id).toList();
      expect(ids, ['a', 'b', 'c']); // 'b' not repeated
    });
  });

  group('HomeFeedNotifier — loadMore', () {
    test('appends second page posts', () async {
      var callCount = 0;
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        return callCount == 1
            ? _page(['a', 'b'], next: 'cur1')
            : _page(['c', 'd']);
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(homeFeedProvider.future);
      await container.read(homeFeedProvider.notifier).loadMore();

      final ids = container
          .read(homeFeedProvider)
          .value!
          .posts
          .map((p) => p.id);
      expect(ids, ['a', 'b', 'c', 'd']);
    });

    test('loadMore no-op when hasMore is false', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['a'])); // no next cursor

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(homeFeedProvider.future);
      await container.read(homeFeedProvider.notifier).loadMore();

      // Only the initial GET should have been made.
      verify(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('loadMore no-op while already loading more', () async {
      var callCount = 0;
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return _page(['a'], next: 'cur1');
        // Delay second call so the isLoadingMore guard is active.
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return _page(['b']);
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(homeFeedProvider.future);

      // Fire two loadMore calls in quick succession.
      final notifier = container.read(homeFeedProvider.notifier);
      final f1 = notifier.loadMore();
      final f2 = notifier.loadMore(); // should be dropped
      await Future.wait([f1, f2]);

      // Only 2 GET calls total (initial + one loadMore).
      verify(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(2);
    });
  });
}
