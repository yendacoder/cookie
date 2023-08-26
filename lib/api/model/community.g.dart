// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) => Community(
      json['id'] as String,
      json['userId'] as String,
      json['name'] as String,
      json['nsfw'] as bool,
      json['about'] as String?,
      json['noMembers'] as int,
      json['proPic'] == null
          ? null
          : Image.fromJson(json['proPic'] as Map<String, dynamic>),
      json['bannerImage'] == null
          ? null
          : Image.fromJson(json['bannerImage'] as Map<String, dynamic>),
      json['createdAt'] as String,
      json['deletedAt'] as String?,
      json['isDefault'] as bool?,
      json['userJoined'] as bool?,
      json['userMod'] as bool?,
      (json['mods'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'nsfw': instance.nsfw,
      'about': instance.about,
      'noMembers': instance.noMembers,
      'proPic': instance.proPic,
      'bannerImage': instance.bannerImage,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'isDefault': instance.isDefault,
      'userJoined': instance.userJoined,
      'userMod': instance.userMod,
      'mods': instance.mods,
    };
