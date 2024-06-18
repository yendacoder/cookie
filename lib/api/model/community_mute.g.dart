// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMute _$CommunityMuteFromJson(Map<String, dynamic> json) =>
    CommunityMute(
      json['id'] as String,
      json['mutedCommunityId'] as String,
      DateTime.parse(json['createdAt'] as String),
      Community.fromJson(json['mutedCommunity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommunityMuteToJson(CommunityMute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mutedCommunityId': instance.mutedCommunityId,
      'createdAt': instance.createdAt.toIso8601String(),
      'mutedCommunity': instance.mutedCommunity,
    };
