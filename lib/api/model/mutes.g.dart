// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mutes _$MutesFromJson(Map<String, dynamic> json) => Mutes(
      (json['communityMutes'] as List<dynamic>)
          .map((e) => CommunityMute.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['userMutes'] as List<dynamic>)
          .map((e) => UserMute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MutesToJson(Mutes instance) => <String, dynamic>{
      'communityMutes': instance.communityMutes,
      'userMutes': instance.userMutes,
    };
