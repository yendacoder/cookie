// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Community _$CommunityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Community', json, ($checkedConvert) {
  final val = _Community(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    nsfw: $checkedConvert('nsfw', (v) => v as bool),
    about: $checkedConvert('about', (v) => v as String?),
    noMembers: $checkedConvert('noMembers', (v) => (v as num).toInt()),
    proPic: $checkedConvert(
      'proPic',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    bannerImage: $checkedConvert(
      'bannerImage',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    postingRestricted: $checkedConvert('postingRestricted', (v) => v as bool),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    deletedAt: $checkedConvert(
      'deletedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    isDefault: $checkedConvert('isDefault', (v) => v as bool?),
    userJoined: $checkedConvert('userJoined', (v) => v as bool?),
    userMod: $checkedConvert('userMod', (v) => v as bool?),
    mods: $checkedConvert(
      'mods',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    rules: $checkedConvert(
      'rules',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => CommunityRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$CommunityToJson(_Community instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'nsfw': instance.nsfw,
      'about': instance.about,
      'noMembers': instance.noMembers,
      'proPic': instance.proPic,
      'bannerImage': instance.bannerImage,
      'postingRestricted': instance.postingRestricted,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isDefault': instance.isDefault,
      'userJoined': instance.userJoined,
      'userMod': instance.userMod,
      'mods': instance.mods,
      'rules': instance.rules,
    };

_CommunityRule _$CommunityRuleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CommunityRule', json, ($checkedConvert) {
      final val = _CommunityRule(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        rule: $checkedConvert('rule', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        communityId: $checkedConvert('communityId', (v) => v as String),
        zIndex: $checkedConvert('zIndex', (v) => (v as num).toInt()),
        createdBy: $checkedConvert('createdBy', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CommunityRuleToJson(_CommunityRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rule': instance.rule,
      'description': instance.description,
      'communityId': instance.communityId,
      'zIndex': instance.zIndex,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
    };
