
import 'package:cookie/api/model/notifications.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/repository.dart';

class NotificationsRepository extends Repository {
  NotificationsRepository(this._authRecordProvider);

  final AuthRecordProvider _authRecordProvider;

  Future<Notifications> getNotifications({String? next}) async {
    final uri = client.initRequest('notifications', parameters: {
      if (next?.isNotEmpty == true) 'next': next,
    });
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => Notifications.fromJson(json));
  }

  Future<void> markAsSeen(int notificationId) async {
    final uri = client.initRequest('notifications/$notificationId', parameters: {
      'action': 'markAsSeen',
      'seen': 'true',
    });
    final authRecord = await _authRecordProvider.getAuthRecord();
    await performRequestEmptyResult(authRecord, () => client.http.putUrl(uri));
  }
}