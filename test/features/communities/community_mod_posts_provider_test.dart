import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/communities/providers/community_mod_posts_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

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
  'upvotes': 1,
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

Response<dynamic> _page(List<String> ids, {required int noPosts}) => Response(
  data: {
    'noPosts': noPosts,
    'limit': 10,
    'page': 0,
    'posts': ids.map(_postJson).toList(),
  },
  statusCode: 200,
  requestOptions: RequestOptions(path: ''),
);

ProviderContainer _container(_MockDio dio) =>
    ProviderContainer(overrides: [apiClientProvider.overrideWithValue(dio)]);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _MockDio mockDio;

  setUp(() => mockDio = _MockDio());

  group('ModPostsFilter.apiValue', () {
    test('removed maps to deleted', () {
      expect(ModPostsFilter.removed.apiValue, 'deleted');
    });

    test('locked maps to locked', () {
      expect(ModPostsFilter.locked.apiValue, 'locked');
    });
  });

  group('CommunityModPosts — initial load', () {
    final provider = communityModPostsProvider(
      'comm-1',
      ModPostsFilter.removed,
    );

    test('returns posts and total from first page', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['p1', 'p2'], noPosts: 5));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(provider.future);
      expect(state.posts.map((p) => p.id), ['p1', 'p2']);
      expect(state.total, 5);
      expect(state.hasMore, true);
    });

    test('hasMore is false when posts cover the total', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['p1', 'p2'], noPosts: 2));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(provider.future);
      expect(state.hasMore, false);
    });

    test('passes correct filter query parameter', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page([], noPosts: 0));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);

      final captured =
          verify(
                () => mockDio.get(
                  'posts',
                  queryParameters: captureAny(named: 'queryParameters'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured['filter'], 'deleted');
      expect(captured['communityId'], 'comm-1');
    });
  });

  group('CommunityModPosts — loadMore', () {
    final provider = communityModPostsProvider('comm-1', ModPostsFilter.locked);

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
            ? _page(['p1', 'p2'], noPosts: 4)
            : _page(['p3', 'p4'], noPosts: 4);
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      final state = container.read(provider).value!;
      expect(state.posts.map((p) => p.id), ['p1', 'p2', 'p3', 'p4']);
      expect(state.page, 2);
      expect(state.hasMore, false);
    });

    test('loadMore is a no-op when hasMore is false', () async {
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page(['p1'], noPosts: 1));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      verify(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('sets loadMoreError on failure and keeps existing posts', () async {
      var callCount = 0;
      when(
        () => mockDio.get(
          'posts',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return _page(['p1'], noPosts: 5);
        throw Exception('network error');
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      final state = container.read(provider).value!;
      expect(state.posts.map((p) => p.id), ['p1']);
      expect(state.isLoadingMore, false);
      expect(state.loadMoreError, isNotNull);
    });
  });
}
