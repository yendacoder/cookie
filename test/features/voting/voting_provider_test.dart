import 'dart:async';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/voting/providers/voting_provider.dart';
import 'package:cookie/models/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mock & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

/// Minimal valid Post JSON — only includes the fields required by the model.
Map<String, dynamic> _postJson({
  String id = 'post-1',
  int upvotes = 10,
  int downvotes = 2,
  bool? userVoted,
  bool? userVotedUp,
}) => {
  'id': id,
  'type': 'text',
  'publicId': 'pub-1',
  'userId': 'user-1',
  'username': 'testuser',
  'userGroup': 'normal',
  'userDeleted': false,
  'isPinned': false,
  'isPinnedSite': false,
  'communityId': 'comm-1',
  'communityName': 'testcomm',
  'title': 'Test Post',
  'locked': false,
  'upvotes': upvotes,
  'downvotes': downvotes,
  'hotness': 0,
  'createdAt': '2024-01-01T00:00:00.000Z',
  'lastActivityAt': '2024-01-01T00:00:00.000Z',
  'deleted': false,
  'deletedContent': false,
  'noComments': 0,
  'isAuthorMuted': false,
  'isCommunityMuted': false,
  'userVoted': ?userVoted,
  'userVotedUp': ?userVotedUp,
};

Response<dynamic> _ok(Map<String, dynamic> data) => Response(
  data: data,
  statusCode: 200,
  requestOptions: RequestOptions(path: ''),
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _MockDio mockDio;
  late ProviderContainer container;

  setUp(() {
    mockDio = _MockDio();
    container = ProviderContainer(
      overrides: [apiClientProvider.overrideWithValue(mockDio)],
    );
  });

  tearDown(() => container.dispose());

  PostVotesNotifier notifier() => container.read(postVotesProvider.notifier);
  VoteState? stateFor(String id) => container.read(postVotesProvider)[id];

  group('optimistic vote state — _optimistic logic via notifier', () {
    test(
      'fresh upvote: increments upvotes, sets userVoted=true/Up=true',
      () async {
        final post = Post.fromJson(_postJson(upvotes: 10, downvotes: 2));
        when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => _ok(
            _postJson(
              upvotes: 11,
              downvotes: 2,
              userVoted: true,
              userVotedUp: true,
            ),
          ),
        );

        // Don't await — read the optimistic state immediately after the sync part
        unawaited(notifier().vote(post, true));

        final opt = stateFor('post-1')!;
        expect(opt.upvotes, 11);
        expect(opt.userVoted, true);
        expect(opt.userVotedUp, true);
        expect(opt.isLoading, true);

        await pumpEventQueue();
      },
    );

    test(
      'fresh downvote: increments downvotes, sets userVotedUp=false',
      () async {
        final post = Post.fromJson(_postJson(upvotes: 10, downvotes: 2));
        when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => _ok(
            _postJson(
              upvotes: 10,
              downvotes: 3,
              userVoted: true,
              userVotedUp: false,
            ),
          ),
        );

        unawaited(notifier().vote(post, false));

        final opt = stateFor('post-1')!;
        expect(opt.downvotes, 3);
        expect(opt.userVotedUp, false);
        expect(opt.isLoading, true);

        await pumpEventQueue();
      },
    );

    test('same-direction tap toggles vote off and decrements count', () async {
      // Already upvoted
      final post = Post.fromJson(
        _postJson(
          upvotes: 11,
          downvotes: 2,
          userVoted: true,
          userVotedUp: true,
        ),
      );
      when(
        () => mockDio.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => _ok(_postJson(upvotes: 10, downvotes: 2)));

      unawaited(notifier().vote(post, true)); // tap upvote again → toggle off

      final opt = stateFor('post-1')!;
      expect(opt.userVoted, false);
      expect(opt.userVotedUp, isNull);
      expect(opt.upvotes, 10); // decremented

      await pumpEventQueue();
    });

    test('direction switch adjusts both upvotes and downvotes', () async {
      // Currently upvoted
      final post = Post.fromJson(
        _postJson(
          upvotes: 11,
          downvotes: 2,
          userVoted: true,
          userVotedUp: true,
        ),
      );
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => _ok(
          _postJson(
            upvotes: 10,
            downvotes: 3,
            userVoted: true,
            userVotedUp: false,
          ),
        ),
      );

      unawaited(notifier().vote(post, false)); // switch to downvote

      final opt = stateFor('post-1')!;
      expect(opt.upvotes, 10); // upvote removed
      expect(opt.downvotes, 3); // downvote added
      expect(opt.userVotedUp, false);

      await pumpEventQueue();
    });
  });

  group('loading guard', () {
    test('second vote while first is in-flight is silently dropped', () async {
      final post = Post.fromJson(_postJson());
      final completer = Completer<Response<dynamic>>();
      when(
        () => mockDio.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) => completer.future);

      unawaited(notifier().vote(post, true));

      // Second call arrives while isLoading = true
      await notifier().vote(post, false);

      // Only one network request should have been made
      verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);

      completer.complete(
        _ok(_postJson(upvotes: 11, userVoted: true, userVotedUp: true)),
      );
      await pumpEventQueue();
    });
  });

  group('rollback on API failure', () {
    test('removes vote override so original post data is shown', () async {
      final post = Post.fromJson(_postJson(upvotes: 10));
      when(
        () => mockDio.post(any(), data: any(named: 'data')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      await notifier().vote(post, true);

      // Override must be removed → feed shows original post counts
      expect(container.read(postVotesProvider).containsKey('post-1'), isFalse);
    });
  });

  group('state after successful server response', () {
    test('updates from server response, not just optimistic values', () async {
      final post = Post.fromJson(_postJson(upvotes: 10, downvotes: 2));
      // Server returns slightly different counts (e.g. concurrent votes)
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => _ok(
          _postJson(
            upvotes: 13, // server says 13, not 11
            downvotes: 2,
            userVoted: true,
            userVotedUp: true,
          ),
        ),
      );

      await notifier().vote(post, true);

      final s = stateFor('post-1')!;
      expect(s.upvotes, 13); // server value wins
      expect(s.isLoading, false);
    });
  });
}
