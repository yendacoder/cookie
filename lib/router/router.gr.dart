// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:cookie/api/model/community.dart' as _i14;
import 'package:cookie/api/model/post.dart' as _i15;
import 'package:cookie/features/compose/compose_screen.dart' as _i1;
import 'package:cookie/features/feed/feed_content_screen.dart' as _i2;
import 'package:cookie/features/feed/feed_screen.dart' as _i3;
import 'package:cookie/features/image_preview/image_preview_screen.dart' as _i5;
import 'package:cookie/features/notifications/notifications_screen.dart' as _i6;
import 'package:cookie/features/post/post_screen.dart' as _i7;
import 'package:cookie/features/profile/profile_screen.dart' as _i8;
import 'package:cookie/features/settings/settings_screen.dart' as _i9;
import 'package:cookie/features/user/user_screen.dart' as _i10;
import 'package:cookie/features/youtube/youtube_screen.dart' as _i11;
import 'package:cookie/router/router.dart' as _i4;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    ComposeRoute.name: (routeData) {
      final args = routeData.argsAs<ComposeRouteArgs>(
          orElse: () => const ComposeRouteArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ComposeScreen(
          key: args.key,
          community: args.community,
          editPost: args.editPost,
        ),
      );
    },
    FeedContentRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FeedContentScreen(),
      );
    },
    FeedRoute.name: (routeData) {
      final args =
          routeData.argsAs<FeedRouteArgs>(orElse: () => const FeedRouteArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.FeedScreen(
          key: args.key,
          feedType: args.feedType,
          communityId: args.communityId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    ImagePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<ImagePreviewRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ImagePreviewScreen(
          key: args.key,
          url: args.url,
        ),
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NotificationsScreen(),
      );
    },
    PostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostRouteArgs>(
          orElse: () => PostRouteArgs(postId: pathParams.getString('postId')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.PostScreen(
          key: args.key,
          postId: args.postId,
          post: args.post,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ProfileScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsScreen(),
      );
    },
    UserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserRouteArgs>(
          orElse: () =>
              UserRouteArgs(username: pathParams.getString('username')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.UserScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    YoutubeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<YoutubeRouteArgs>(
          orElse: () =>
              YoutubeRouteArgs(videoId: pathParams.getString('videoId')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.YoutubeScreen(
          key: args.key,
          videoId: args.videoId,
          url: args.url,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ComposeScreen]
class ComposeRoute extends _i12.PageRouteInfo<ComposeRouteArgs> {
  ComposeRoute({
    _i13.Key? key,
    _i14.Community? community,
    _i15.Post? editPost,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ComposeRoute.name,
          args: ComposeRouteArgs(
            key: key,
            community: community,
            editPost: editPost,
          ),
          initialChildren: children,
        );

  static const String name = 'ComposeRoute';

  static const _i12.PageInfo<ComposeRouteArgs> page =
      _i12.PageInfo<ComposeRouteArgs>(name);
}

class ComposeRouteArgs {
  const ComposeRouteArgs({
    this.key,
    this.community,
    this.editPost,
  });

  final _i13.Key? key;

  final _i14.Community? community;

  final _i15.Post? editPost;

  @override
  String toString() {
    return 'ComposeRouteArgs{key: $key, community: $community, editPost: $editPost}';
  }
}

/// generated route for
/// [_i2.FeedContentScreen]
class FeedContentRoute extends _i12.PageRouteInfo<void> {
  const FeedContentRoute({List<_i12.PageRouteInfo>? children})
      : super(
          FeedContentRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedContentRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.FeedScreen]
class FeedRoute extends _i12.PageRouteInfo<FeedRouteArgs> {
  FeedRoute({
    _i13.Key? key,
    String? feedType,
    String? communityId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          FeedRoute.name,
          args: FeedRouteArgs(
            key: key,
            feedType: feedType,
            communityId: communityId,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedRoute';

  static const _i12.PageInfo<FeedRouteArgs> page =
      _i12.PageInfo<FeedRouteArgs>(name);
}

class FeedRouteArgs {
  const FeedRouteArgs({
    this.key,
    this.feedType,
    this.communityId,
  });

  final _i13.Key? key;

  final String? feedType;

  final String? communityId;

  @override
  String toString() {
    return 'FeedRouteArgs{key: $key, feedType: $feedType, communityId: $communityId}';
  }
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ImagePreviewScreen]
class ImagePreviewRoute extends _i12.PageRouteInfo<ImagePreviewRouteArgs> {
  ImagePreviewRoute({
    _i13.Key? key,
    required String url,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ImagePreviewRoute.name,
          args: ImagePreviewRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'ImagePreviewRoute';

  static const _i12.PageInfo<ImagePreviewRouteArgs> page =
      _i12.PageInfo<ImagePreviewRouteArgs>(name);
}

class ImagePreviewRouteArgs {
  const ImagePreviewRouteArgs({
    this.key,
    required this.url,
  });

  final _i13.Key? key;

  final String url;

  @override
  String toString() {
    return 'ImagePreviewRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [_i6.NotificationsScreen]
class NotificationsRoute extends _i12.PageRouteInfo<void> {
  const NotificationsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PostScreen]
class PostRoute extends _i12.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i13.Key? key,
    required String postId,
    _i15.Post? post,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          PostRoute.name,
          args: PostRouteArgs(
            key: key,
            postId: postId,
            post: post,
          ),
          rawPathParams: {'postId': postId},
          initialChildren: children,
        );

  static const String name = 'PostRoute';

  static const _i12.PageInfo<PostRouteArgs> page =
      _i12.PageInfo<PostRouteArgs>(name);
}

class PostRouteArgs {
  const PostRouteArgs({
    this.key,
    required this.postId,
    this.post,
  });

  final _i13.Key? key;

  final String postId;

  final _i15.Post? post;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, postId: $postId, post: $post}';
  }
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UserScreen]
class UserRoute extends _i12.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    _i13.Key? key,
    required String username,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          UserRoute.name,
          args: UserRouteArgs(
            key: key,
            username: username,
          ),
          rawPathParams: {'username': username},
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const _i12.PageInfo<UserRouteArgs> page =
      _i12.PageInfo<UserRouteArgs>(name);
}

class UserRouteArgs {
  const UserRouteArgs({
    this.key,
    required this.username,
  });

  final _i13.Key? key;

  final String username;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i11.YoutubeScreen]
class YoutubeRoute extends _i12.PageRouteInfo<YoutubeRouteArgs> {
  YoutubeRoute({
    _i13.Key? key,
    required String videoId,
    String? url,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          YoutubeRoute.name,
          args: YoutubeRouteArgs(
            key: key,
            videoId: videoId,
            url: url,
          ),
          rawPathParams: {'videoId': videoId},
          initialChildren: children,
        );

  static const String name = 'YoutubeRoute';

  static const _i12.PageInfo<YoutubeRouteArgs> page =
      _i12.PageInfo<YoutubeRouteArgs>(name);
}

class YoutubeRouteArgs {
  const YoutubeRouteArgs({
    this.key,
    required this.videoId,
    this.url,
  });

  final _i13.Key? key;

  final String videoId;

  final String? url;

  @override
  String toString() {
    return 'YoutubeRouteArgs{key: $key, videoId: $videoId, url: $url}';
  }
}
