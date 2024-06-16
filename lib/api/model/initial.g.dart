// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Initial _$InitialFromJson(Map<String, dynamic> json) => Initial(
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      (json['communities'] as List<dynamic>)
          .map((e) => Community.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['noUsers'] as int,
      (json['bannedFrom'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Mutes.fromJson(json['mutes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InitialToJson(Initial instance) => <String, dynamic>{
      'user': instance.user,
      'communities': instance.communities,
      'noUsers': instance.noUsers,
      'bannedFrom': instance.bannedFrom,
      'mutes': instance.mutes,
    };
