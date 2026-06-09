import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cookie/features/auth/screens/login_screen.dart';
import 'package:cookie/features/communities/screens/communities_screen.dart';
import 'package:cookie/features/communities/screens/mod_tools_screen.dart';
import 'package:cookie/features/posts/screens/compose_screen.dart';
import 'package:cookie/features/communities/screens/community_screen.dart';
import 'package:cookie/features/communities/screens/muted_communities_screen.dart';
import 'package:cookie/features/home/screens/home_screen.dart';
import 'package:cookie/features/notifications/screens/notifications_screen.dart';
import 'package:cookie/features/posts/screens/youtube_player_screen.dart';
import 'package:cookie/features/profile/screens/edit_profile_screen.dart';
import 'package:cookie/features/lists/screens/list_detail_screen.dart';
import 'package:cookie/features/lists/screens/lists_screen.dart';
import 'package:cookie/features/profile/screens/settings_screen.dart';
import 'package:cookie/models/user_list.dart';
import 'package:cookie/features/posts/screens/image_viewer_screen.dart';
import 'package:cookie/features/posts/screens/post_detail_screen.dart';
import 'package:cookie/features/profile/screens/profile_screen.dart';
import 'package:cookie/features/shell/providers/last_tab_provider.dart';
import 'package:cookie/features/shell/screens/shell_screen.dart';
import 'package:cookie/features/user/screens/muted_users_screen.dart';
import 'package:cookie/features/user/screens/user_screen.dart';
import 'package:cookie/features/subscriptions/screens/subscriptions_screen.dart';
import 'package:cookie/models/community.dart';
import 'package:cookie/models/post.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final initialLocation = switch (ref.read(lastTabProvider)) {
    1 => '/subscriptions',
    2 => '/profile',
    _ => '/',
  };
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShellScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/subscriptions',
                builder: (context, state) => const SubscriptionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/communities',
        builder: (context, state) =>
            CommunitiesScreen(selectMode: state.extra == true),
      ),
      GoRoute(path: '/lists', builder: (context, state) => const ListsScreen()),
      GoRoute(
        path: '/lists/:listId',
        builder: (context, state) => ListDetailScreen(
          listId: int.parse(state.pathParameters['listId']!),
          initialList: state.extra as UserList?,
        ),
      ),
      GoRoute(
        path: '/image-viewer',
        builder: (context, state) {
          final args = state.extra as ImageViewerArgs;
          return ImageViewerScreen(
            images: args.images,
            initialIndex: args.initialIndex,
          );
        },
      ),
      GoRoute(
        path: '/youtube-player',
        builder: (context, state) {
          final videoId = state.extra as String;
          return YoutubePlayerScreen(videoId: videoId);
        },
      ),
      GoRoute(
        path: '/c/:communityName',
        builder: (context, state) => CommunityScreen(
          communityName: state.pathParameters['communityName']!,
        ),
      ),
      GoRoute(
        path: '/c/:communityName/mod-tools',
        builder: (context, state) => ModToolsScreen(
          communityName: state.pathParameters['communityName']!,
        ),
      ),
      GoRoute(
        path: '/c/:communityName/post/:postId',
        builder: (context, state) {
          final extra =
              state.extra as ({Post post, String heroTagScope})?;
          return PostDetailScreen(
            communityName: state.pathParameters['communityName']!,
            postId: state.pathParameters['postId']!,
            initialPost: extra?.post,
            heroTagScope: extra?.heroTagScope ?? '',
          );
        },
      ),
      GoRoute(
        path: '/u/:username',
        builder: (context, state) =>
            UserScreen(username: state.pathParameters['username']!),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/muted-users',
        builder: (context, state) => const MutedUsersScreen(),
      ),
      GoRoute(
        path: '/muted-communities',
        builder: (context, state) => const MutedCommunitiesScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/compose',
        pageBuilder: (context, state) {
          final extra = state.extra;
          return MaterialPage(
            fullscreenDialog: true,
            child: extra is Post
                ? ComposeScreen(editingPost: extra)
                : ComposeScreen(community: extra as Community?),
          );
        },
      ),
    ],
  );
}
