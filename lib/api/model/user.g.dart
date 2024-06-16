// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['username'] as String,
      json['proPic'] == null
          ? null
          : Image.fromJson(json['proPic'] as Map<String, dynamic>),
      json['email'] as String?,
      json['emailConfirmedAt'] as String?,
      json['aboutMe'] as String?,
      json['points'] as int,
      json['isAdmin'] as bool,
      json['noPosts'] as int,
      json['noComments'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['isBanned'] as bool,
      json['bannedAt'] == null
          ? null
          : DateTime.parse(json['bannedAt'] as String),
      json['notificationsNewCount'] as int,
      json['moddingList'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'proPic': instance.proPic,
      'email': instance.email,
      'emailConfirmedAt': instance.emailConfirmedAt,
      'aboutMe': instance.aboutMe,
      'points': instance.points,
      'isAdmin': instance.isAdmin,
      'noPosts': instance.noPosts,
      'noComments': instance.noComments,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isBanned': instance.isBanned,
      'bannedAt': instance.bannedAt?.toIso8601String(),
      'notificationsNewCount': instance.notificationsNewCount,
      'moddingList': instance.moddingList,
    };
