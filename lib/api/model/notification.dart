import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/notification_content.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cookie/common/util/common_util.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  Notification(
    this.id,
    this.type,
    this.seen,
    this.seenAt,
    this.createdAt,
    this.notif,
  );

  final int id;
  final String type;
  NotificationType? get typeType => type.toEnumOrNull(NotificationType.values);

  bool seen;
  final DateTime? seenAt;
  final DateTime createdAt;
  final NotificationContent? notif;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
