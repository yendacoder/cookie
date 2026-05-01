// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    };
