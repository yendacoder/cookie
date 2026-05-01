import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required String type,
    // notif is a union type (NewVotesNotif | DeletedPostNotif | etc.)
    // deserialized separately based on type
    required Map<String, dynamic> notif,
    required bool seen,
    DateTime? seenAt,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
