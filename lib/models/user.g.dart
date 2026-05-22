// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_User', json, ($checkedConvert) {
  final val = _User(
    id: $checkedConvert('id', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String?),
    emailConfirmedAt: $checkedConvert(
      'emailConfirmedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    aboutMe: $checkedConvert('aboutMe', (v) => v as String?),
    points: $checkedConvert('points', (v) => (v as num).toInt()),
    isAdmin: $checkedConvert('isAdmin', (v) => v as bool),
    proPic: $checkedConvert(
      'proPic',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    badges: $checkedConvert(
      'badges',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    noPosts: $checkedConvert('noPosts', (v) => (v as num).toInt()),
    noComments: $checkedConvert('noComments', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    deleted: $checkedConvert('deleted', (v) => v as bool),
    deletedAt: $checkedConvert(
      'deletedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    upvoteNotificationsOff: $checkedConvert(
      'upvoteNotificationsOff',
      (v) => v as bool,
    ),
    replyNotificationsOff: $checkedConvert(
      'replyNotificationsOff',
      (v) => v as bool,
    ),
    homeFeed: $checkedConvert('homeFeed', (v) => v as String),
    rememberFeedSort: $checkedConvert('rememberFeedSort', (v) => v as bool),
    embedsOff: $checkedConvert('embedsOff', (v) => v as bool),
    hideUserProfilePictures: $checkedConvert(
      'hideUserProfilePictures',
      (v) => v as bool,
    ),
    bannedAt: $checkedConvert(
      'bannedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    isBanned: $checkedConvert('isBanned', (v) => v as bool),
    notificationsNewCount: $checkedConvert(
      'notificationsNewCount',
      (v) => (v as num).toInt(),
    ),
  );
  return val;
});

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'emailConfirmedAt': instance.emailConfirmedAt?.toIso8601String(),
  'aboutMe': instance.aboutMe,
  'points': instance.points,
  'isAdmin': instance.isAdmin,
  'proPic': instance.proPic,
  'badges': instance.badges,
  'noPosts': instance.noPosts,
  'noComments': instance.noComments,
  'createdAt': instance.createdAt.toIso8601String(),
  'deleted': instance.deleted,
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'upvoteNotificationsOff': instance.upvoteNotificationsOff,
  'replyNotificationsOff': instance.replyNotificationsOff,
  'homeFeed': instance.homeFeed,
  'rememberFeedSort': instance.rememberFeedSort,
  'embedsOff': instance.embedsOff,
  'hideUserProfilePictures': instance.hideUserProfilePictures,
  'bannedAt': instance.bannedAt?.toIso8601String(),
  'isBanned': instance.isBanned,
  'notificationsNewCount': instance.notificationsNewCount,
};

_Badge _$BadgeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Badge', json, ($checkedConvert) {
      final val = _Badge(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        type: $checkedConvert('type', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BadgeToJson(_Badge instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
};
