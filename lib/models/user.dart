import 'package:freezed_annotation/freezed_annotation.dart';

import 'discuit_image.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String username,
    String? email,
    DateTime? emailConfirmedAt,
    String? aboutMe,
    required int points,
    required bool isAdmin,
    DiscuitImage? proPic,
    @Default([]) List<Badge> badges,
    required int noPosts,
    required int noComments,
    required DateTime createdAt,
    required bool deleted,
    DateTime? deletedAt,
    required bool upvoteNotificationsOff,
    required bool replyNotificationsOff,
    required String homeFeed,
    required bool rememberFeedSort,
    required bool embedsOff,
    required bool hideUserProfilePictures,
    DateTime? bannedAt,
    required bool isBanned,
    required int notificationsNewCount,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class Badge with _$Badge {
  const factory Badge({
    required int id,
    required String type,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}
