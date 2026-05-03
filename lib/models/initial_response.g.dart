// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InitialCommunityMute _$InitialCommunityMuteFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_InitialCommunityMute', json, ($checkedConvert) {
  final val = _InitialCommunityMute(
    id: $checkedConvert('id', (v) => v as String),
    mutedCommunityId: $checkedConvert('mutedCommunityId', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$InitialCommunityMuteToJson(
  _InitialCommunityMute instance,
) => <String, dynamic>{
  'id': instance.id,
  'mutedCommunityId': instance.mutedCommunityId,
};

_InitialUserMute _$InitialUserMuteFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_InitialUserMute', json, ($checkedConvert) {
      final val = _InitialUserMute(
        id: $checkedConvert('id', (v) => v as String),
        mutedUserId: $checkedConvert('mutedUserId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$InitialUserMuteToJson(_InitialUserMute instance) =>
    <String, dynamic>{'id': instance.id, 'mutedUserId': instance.mutedUserId};

_InitialMutes _$InitialMutesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_InitialMutes', json, ($checkedConvert) {
  final val = _InitialMutes(
    communityMutes: $checkedConvert(
      'communityMutes',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => InitialCommunityMute.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    ),
    userMutes: $checkedConvert(
      'userMutes',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => InitialUserMute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$InitialMutesToJson(_InitialMutes instance) =>
    <String, dynamic>{
      'communityMutes': instance.communityMutes,
      'userMutes': instance.userMutes,
    };

_InitialResponse _$InitialResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_InitialResponse', json, ($checkedConvert) {
      final val = _InitialResponse(
        user: $checkedConvert(
          'user',
          (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
        ),
        communities: $checkedConvert(
          'communities',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => Community.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
        noUsers: $checkedConvert('noUsers', (v) => (v as num?)?.toInt()),
        bannedFrom: $checkedConvert(
          'bannedFrom',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        vapidPublicKey: $checkedConvert('vapidPublicKey', (v) => v as String?),
        mutes: $checkedConvert(
          'mutes',
          (v) => v == null
              ? const InitialMutes()
              : InitialMutes.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$InitialResponseToJson(_InitialResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'communities': instance.communities,
      'noUsers': instance.noUsers,
      'bannedFrom': instance.bannedFrom,
      'vapidPublicKey': instance.vapidPublicKey,
      'mutes': instance.mutes,
    };
