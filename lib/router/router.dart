import 'package:auto_route/auto_route.dart';
import 'package:cookie/router/router.gr.dart';

@RoutePage()
class HomeScreen extends AutoRouter {
  const HomeScreen({super.key});
}

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, children: [
          AutoRoute(path: '', page: FeedRoute.page, children: [
            AutoRoute(path: '', page: FeedContentRoute.page),
            AutoRoute(path: ':postId', page: PostRoute.page),
            AutoRoute(path: 'user/:username', page: UserRoute.page),
          ]),
          AutoRoute(path: 'profile', page: ProfileRoute.page),
          AutoRoute(path: 'settings', page: SettingsRoute.page),
          AutoRoute(path: 'image_preview', page: ImagePreviewRoute.page),
          AutoRoute(path: 'compose', page: ComposeRoute.page),
          AutoRoute(path: 'notifications', page: NotificationsRoute.page),
          CustomRoute(
              path: 'youtube',
              page: YoutubeRoute.page,
              opaque: false,
              durationInMilliseconds: 0,
              reverseDurationInMilliseconds: 0),
        ]),
      ];
}
