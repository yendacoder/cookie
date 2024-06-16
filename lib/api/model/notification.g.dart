// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      json['id'] as int,
      json['type'] as String,
      json['seen'] as bool,
      json['seenAt'] == null ? null : DateTime.parse(json['seenAt'] as String),
      DateTime.parse(json['createdAt'] as String),
      json['notif'] == null
          ? null
          : NotificationContent.fromJson(json['notif'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seen': instance.seen,
      'seenAt': instance.seenAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'notif': instance.notif,
    };
