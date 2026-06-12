import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/communities/providers/community_mutes_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

Map<String, dynamic> _userJson({
  String username = 'alice',
  required int notificationsNewCount,
}) => {
  'id': 'u1',
  'username': username,
  'points': 42,
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
  'isBanned': false,
  'notificationsNewCount': notificationsNewCount,
};

Response<dynamic> _initialResponse({
  Map<String, dynamic>? user,
  List<Map<String, dynamic>> communityMutes = const [],
}) => Response(
  data: {
    'user': user,
    'communities': <dynamic>[],
    'mutes': {'communityMutes': communityMutes, 'userMutes': <dynamic>[]},
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

  group('AuthNotifier — refreshNotificationCount', () {
    test('updates notificationsNewCount without re-seeding mutes', () async {
      when(() => mockDio.get('_initial')).thenAnswer((_) async {
        return _initialResponse(
          user: _userJson(notificationsNewCount: 2),
          communityMutes: [
            {'id': 'm1', 'mutedCommunityId': 'c1'},
          ],
        );
      });

      when(() => mockDio.get('_user')).thenAnswer((_) async {
        return Response(
          data: _userJson(username: 'changed', notificationsNewCount: 5),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(authProvider.future);
      expect(container.read(communityMutesProvider), {'c1'});

      await container.read(authProvider.notifier).refreshNotificationCount();

      final user = container.read(authProvider).value;
      expect(user!.notificationsNewCount, 5);
      // Other fields are left untouched by the refresh.
      expect(user.username, 'alice');
      expect(container.read(communityMutesProvider), {'c1'});
    });

    test('is a no-op when logged out', () async {
      when(
        () => mockDio.get('_initial'),
      ).thenAnswer((_) async => _initialResponse(user: null));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(authProvider.future);
      await container.read(authProvider.notifier).refreshNotificationCount();

      verify(() => mockDio.get('_initial')).called(1);
    });

    test('swallows DioException and leaves state unchanged', () async {
      when(() => mockDio.get('_initial')).thenAnswer((_) async {
        return _initialResponse(user: _userJson(notificationsNewCount: 2));
      });
      when(() => mockDio.get('_user')).thenAnswer((_) async {
        throw DioException(requestOptions: RequestOptions(path: '_user'));
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(authProvider.future);
      await container.read(authProvider.notifier).refreshNotificationCount();

      expect(container.read(authProvider).value!.notificationsNewCount, 2);
    });
  });
}
