import 'package:cookie/api/model/notification.dart';
import 'package:cookie/features/notifications/notifications_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationsController with ChangeNotifier {
  NotificationsController(this._notificationsRepository);

  final NotificationsRepository _notificationsRepository;

  final List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;
  String? _next;

  int get displayItemsCount {
    int count = _notifications.length;
    if (_notifications.isNotEmpty &&
        !_allPagesLoaded &&
        (isLoading || lastError == null)) {
      count += 1;
    }
    return count;
  }

  Object? _lastError;

  Object? get lastError => _lastError;
  bool _isLoading = false;
  bool _allPagesLoaded = false;

  bool get isLoading => _isLoading;

  void reset() {
    _lastError = null;
    _isLoading = false;
    _allPagesLoaded = false;
    _notifications.clear();
  }

  Future<void> loadNotificationsPage({bool reload = false}) async {
    if (reload) {
      _notifications.clear();
      _next = null;
    }
    if (_allPagesLoaded) {
      return;
    }
    _isLoading = true;
    _lastError = null;
    try {
      final notifications =
          await _notificationsRepository.getNotifications(next: _next);
      _next = notifications.next;
      _allPagesLoaded = _next?.isEmpty == true;
      _notifications.addAll(notifications.items);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _lastError = e;
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> markAsSeen(Notification notification) async {
    await _notificationsRepository.markAsSeen(notification.id);
    notification.seen = true;
    notifyListeners();
  }
}
