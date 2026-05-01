// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppNotification', json, ($checkedConvert) {
      final val = _AppNotification(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        type: $checkedConvert('type', (v) => v as String),
        notif: $checkedConvert('notif', (v) => v as Map<String, dynamic>),
        seen: $checkedConvert('seen', (v) => v as bool),
        seenAt: $checkedConvert(
          'seenAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'notif': instance.notif,
      'seen': instance.seen,
      'seenAt': instance.seenAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
