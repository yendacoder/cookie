import 'package:cookie/api/model/notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications.g.dart';

@JsonSerializable()
class Notifications {
  const Notifications(this.items, this.next);

  final List<Notification> items;
  final String? next;

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
}