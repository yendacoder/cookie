// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMute _$UserMuteFromJson(Map<String, dynamic> json) => UserMute(
      json['id'] as String,
      json['type'] as String,
      json['mutedUserId'] as String,
      DateTime.parse(json['createdAt'] as String),
      User.fromJson(json['mutedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserMuteToJson(UserMute instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'mutedUserId': instance.mutedUserId,
      'createdAt': instance.createdAt.toIso8601String(),
      'mutedUser': instance.mutedUser,
    };
