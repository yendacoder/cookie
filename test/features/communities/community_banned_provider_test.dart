import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/communities/providers/community_banned_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

Map<String, dynamic> _userJson(String username) => {
  'id': 'user-$username',
  'username': username,
  'points': 0,
  'isAdmin': false,
  'noPosts': 0,
  'noComments': 0,
  'createdAt': '2024-01-01T00:00:00.000Z',
  'deleted': false,
  'upvoteNotificationsOff': false,
  'replyNotificationsOff': false,
  'homeFeed': 'all',
  'rememberFeedSort': false,
  'embedsOff': false,
  'hideUserProfilePictures': false,
  'isBanned': true,
  'notificationsNewCount': 0,
};

Response<dynamic> _list(List<String> usernames) => Response(
  data: usernames.map(_userJson).toList(),
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
  final provider = communityBannedUsersProvider('comm-1');

  setUp(() => mockDio = _MockDio());

  group('CommunityBannedUsers — initial load', () {
    test('returns banned users from the API', () async {
      when(
        () => mockDio.get('communities/comm-1/banned'),
      ).thenAnswer((_) async => _list(['alice', 'bob']));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final users = await container.read(provider.future);
      expect(users.map((u) => u.username), ['alice', 'bob']);
    });
  });

  group('CommunityBannedUsers — ban', () {
    test('appends the user returned by the API', () async {
      when(
        () => mockDio.get('communities/comm-1/banned'),
      ).thenAnswer((_) async => _list(['alice']));
      when(
        () => mockDio.post(
          'communities/comm-1/banned',
          data: {'username': 'bob'},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: _userJson('bob'),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).ban('bob');

      final users = container.read(provider).value!;
      expect(users.map((u) => u.username), ['alice', 'bob']);
    });
  });

  group('CommunityBannedUsers — unban', () {
    test('removes the user from state', () async {
      when(
        () => mockDio.get('communities/comm-1/banned'),
      ).thenAnswer((_) async => _list(['alice', 'bob']));
      when(
        () => mockDio.delete(
          'communities/comm-1/banned',
          data: {'username': 'alice'},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).unban('alice');

      final users = container.read(provider).value!;
      expect(users.map((u) => u.username), ['bob']);
    });
  });
}
