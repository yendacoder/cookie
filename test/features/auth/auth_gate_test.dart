import 'dart:async';

import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/auth/widgets/auth_gate.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Keeps [authProvider] in AsyncLoading forever.
class _AuthLoading extends AuthNotifier {
  @override
  Future<User?> build() => Completer<User?>().future;
}

/// Resolves [authProvider] with null (unauthenticated).
class _AuthNull extends AuthNotifier {
  @override
  Future<User?> build() async => null;
}

/// Resolves [authProvider] with a real User.
class _AuthUser extends AuthNotifier {
  @override
  Future<User?> build() async => _fakeUser;
}

/// Resolves [authProvider] with an unhandled error.
class _AuthError extends AuthNotifier {
  @override
  Future<User?> build() => Future.error(StateError('network error'));
}

final _fakeUser = User(
  id: 'u1',
  username: 'alice',
  points: 42,
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

Widget _wrap(Widget child, {required AuthNotifier notifier}) {
  return ProviderScope(
    overrides: [
      authProvider.overrideWith(() => notifier),
      platformStyleProvider.overrideWithValue(PlatformStyle.android),
    ],
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

void main() {
  group('AuthGate', () {
    testWidgets('shows spinner while auth is loading', (tester) async {
      await tester.pumpWidget(
        _wrap(const AuthGate(child: Text('child')), notifier: _AuthLoading()),
      );

      // One pump: loading frame.
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('child'), findsNothing);
    });

    testWidgets('shows sign-in prompt when user is null', (tester) async {
      await tester.pumpWidget(
        _wrap(const AuthGate(child: Text('child')), notifier: _AuthNull()),
      );

      await tester.pumpAndSettle();
      expect(find.text('Sign in to continue'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('child'), findsNothing);
    });

    testWidgets('shows child when user is authenticated', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AuthGate(child: Text('secret content')),
          notifier: _AuthUser(),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('secret content'), findsOneWidget);
      expect(find.text('Sign in'), findsNothing);
    });

    testWidgets('shows error view on auth error', (tester) async {
      await tester.pumpWidget(
        _wrap(const AuthGate(child: Text('child')), notifier: _AuthError()),
      );

      await tester.pumpAndSettle();
      expect(find.text('child'), findsNothing);
      expect(find.text('Sign in to continue'), findsNothing);
      // ErrorView classifies StateError as UnknownException.
      expect(find.text('Unexpected error'), findsOneWidget);
    });
  });
}
