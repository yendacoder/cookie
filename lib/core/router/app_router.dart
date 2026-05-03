import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/communities/screens/communities_screen.dart';
import '../../features/communities/screens/community_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/lists/screens/lists_screen.dart';
import '../../features/posts/screens/image_viewer_screen.dart';
import '../../features/posts/screens/post_detail_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/shell/providers/last_tab_provider.dart';
import '../../features/shell/screens/shell_screen.dart';
import '../../features/user/screens/user_screen.dart';
import '../../features/subscriptions/screens/subscriptions_screen.dart';
import '../../models/post.dart';

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
        builder: (context, state) => const CommunitiesScreen(),
      ),
      GoRoute(
        path: '/lists',
        builder: (context, state) => const ListsScreen(),
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
        path: '/c/:communityName',
        builder: (context, state) => CommunityScreen(
          communityName: state.pathParameters['communityName']!,
        ),
      ),
      GoRoute(
        path: '/c/:communityName/post/:postId',
        builder: (context, state) => PostDetailScreen(
          communityName: state.pathParameters['communityName']!,
          postId: state.pathParameters['postId']!,
          initialPost: state.extra as Post?,
        ),
      ),
      GoRoute(
        path: '/u/:username',
        builder: (context, state) => UserScreen(
          username: state.pathParameters['username']!,
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
