import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/communities/providers/muted_communities_list_provider.dart';
import 'package:cookie/features/posts/providers/hidden_posts_provider.dart';
import 'package:cookie/features/posts/widgets/post_card.dart';
import 'package:cookie/features/user/providers/muted_users_list_provider.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/initial_response.dart';
import 'package:cookie/models/post.dart';
import 'package:cookie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// State-injection notifier subclasses
// ---------------------------------------------------------------------------

class _AuthNull extends AuthNotifier {
  @override
  Future<User?> build() async => null;
}

class _HiddenSet extends HiddenPosts {
  _HiddenSet(this._ids);

  final Set<String> _ids;

  @override
  Set<String> build() => _ids;
}

class _MutedCommunities extends MutedCommunitiesList {
  _MutedCommunities(this._mutes);

  final List<InitialCommunityMute> _mutes;

  @override
  List<InitialCommunityMute> build() => _mutes;
}

class _MutedUsers extends MutedUsersList {
  _MutedUsers(this._mutes);

  final List<InitialUserMute> _mutes;

  @override
  List<InitialUserMute> build() => _mutes;
}

// ---------------------------------------------------------------------------
// Data helpers
// ---------------------------------------------------------------------------

User _fakeUser(String id) => User(
  id: id,
  username: 'author-$id',
  points: 0,
  isAdmin: false,
  noPosts: 0,
  noComments: 0,
  createdAt: DateTime(2024),
  deleted: false,
  upvoteNotificationsOff: false,
  replyNotificationsOff: false,
  homeFeed: 'all',
  rememberFeedSort: false,
  embedsOff: false,
  hideUserProfilePictures: false,
  isBanned: false,
  notificationsNewCount: 0,
);

Post _post({String id = 'p1', String communityId = 'comm-1', User? author}) =>
    Post(
      id: id,
      type: 'text',
      publicId: 'pub-$id',
      userId: 'user-1',
      username: 'testuser',
      userGroup: 'normal',
      userDeleted: false,
      isPinned: false,
      isPinnedSite: false,
      communityId: communityId,
      communityName: 'testcomm',
      title: 'Hello world',
      locked: false,
      upvotes: 0,
      downvotes: 0,
      hotness: 0,
      createdAt: DateTime(2024),
      lastActivityAt: DateTime(2024),
      deleted: false,
      deletedContent: false,
      noComments: 0,
      isAuthorMuted: false,
      isCommunityMuted: false,
      author: author,
    );

// ---------------------------------------------------------------------------
// Widget helpers
// ---------------------------------------------------------------------------

// Only override providers that have unsafe build() methods (i.e. make network
// calls). Providers with safe empty-collection defaults are left alone so that
// individual tests can override them via [extra] without triggering the
// "duplicate override" assertion.
List<Override> _baseOverrides() => [
  platformStyleProvider.overrideWithValue(PlatformStyle.android),
  authProvider.overrideWith(() => _AuthNull()),
];

Widget _wrap(Widget child, {List<Override> extra = const []}) {
  return ProviderScope(
    overrides: [..._baseOverrides(), ...extra],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------
const _kHeroTagScope = HeroTagScope(.home);

void main() {
  group('PostCard visibility', () {
    testWidgets('renders post title when visible', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(post: _post(), heroTagScope: _kHeroTagScope, onTap: () {}),
        ),
      );
      await tester.pump();
      expect(find.text('Hello world'), findsOneWidget);
      expect(find.text('Post hidden'), findsNothing);
    });

    testWidgets('shows hidden placeholder when post id is in hidden set', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(id: 'p1'),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
          ),
          extra: [
            hiddenPostsProvider.overrideWith(() => _HiddenSet({'p1'})),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Post hidden'), findsOneWidget);
      expect(find.text('Hello world'), findsNothing);
    });

    testWidgets('hidden placeholder includes undo button', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(id: 'p1'),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
          ),
          extra: [
            hiddenPostsProvider.overrideWith(() => _HiddenSet({'p1'})),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('shows placeholder when community is muted', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(communityId: 'comm-muted'),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
          ),
          extra: [
            mutedCommunitiesListProvider.overrideWith(
              () => _MutedCommunities([
                const InitialCommunityMute(
                  id: 'comm-muted',
                  mutedCommunityId: 'comm-muted',
                ),
              ]),
            ),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Post hidden'), findsOneWidget);
      expect(find.text('Undo'), findsNothing);
    });

    testWidgets('shows placeholder when author is muted', (tester) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(author: _fakeUser('author-99')),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
          ),
          extra: [
            mutedUsersListProvider.overrideWith(
              () => _MutedUsers([
                const InitialUserMute(
                  id: 'author-99',
                  mutedUserId: 'author-99',
                ),
              ]),
            ),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Post hidden'), findsOneWidget);
      expect(find.text('Hello world'), findsNothing);
    });

    testWidgets('checkMutedUser=false does not hide muted author', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(author: _fakeUser('author-99')),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
            checkMutedUser: false,
          ),
          extra: [
            mutedUsersListProvider.overrideWith(
              () => _MutedUsers([
                const InitialUserMute(
                  id: 'author-99',
                  mutedUserId: 'author-99',
                ),
              ]),
            ),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Hello world'), findsOneWidget);
      expect(find.text('Post hidden'), findsNothing);
    });

    testWidgets('checkMutedCommunity=false does not hide muted community', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          PostCard(
            post: _post(communityId: 'comm-muted'),
            heroTagScope: _kHeroTagScope,
            onTap: () {},
            checkMutedCommunity: false,
          ),
          extra: [
            mutedCommunitiesListProvider.overrideWith(
              () => _MutedCommunities([
                const InitialCommunityMute(
                  id: 'comm-muted',
                  mutedCommunityId: 'comm-muted',
                ),
              ]),
            ),
          ],
        ),
      );
      await tester.pump();
      expect(find.text('Hello world'), findsOneWidget);
      expect(find.text('Post hidden'), findsNothing);
    });
  });
}
