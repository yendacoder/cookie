// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicUser _$PublicUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PublicUser', json, ($checkedConvert) {
  final val = _PublicUser(
    id: $checkedConvert('id', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
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
    bannedAt: $checkedConvert(
      'bannedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    isBanned: $checkedConvert('isBanned', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PublicUserToJson(_PublicUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
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
      'bannedAt': instance.bannedAt?.toIso8601String(),
      'isBanned': instance.isBanned,
    };
