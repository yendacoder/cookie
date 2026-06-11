import 'dart:async';

import 'package:cookie/core/consts.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_poll_provider.g.dart';

/// Periodically refreshes the notification count while the app is
/// authenticated and in the foreground, and immediately on resume.
@Riverpod(keepAlive: true)
class NotificationPoller extends _$NotificationPoller {
  Timer? _timer;
  AppLifecycleListener? _lifecycleListener;
  bool _isAuthenticated = false;
  bool _isResumed = true;

  @override
  void build() {
    _isAuthenticated = ref.read(authProvider).value != null;

    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _isResumed = true;
        _syncTimer();
        if (_isAuthenticated) {
          ref.read(authProvider.notifier).refreshNotificationCount();
        }
      },
      onPause: () {
        _isResumed = false;
        _syncTimer();
      },
    );
    ref.onDispose(() {
      _timer?.cancel();
      _lifecycleListener?.dispose();
    });

    // build() runs only once (no ref.watch dependencies above), so reacting
    // to auth changes via ref.listen avoids tearing down the lifecycle
    // listener/timer on every login/logout.
    ref.listen(authProvider.select((s) => s.value != null), (
      _,
      isAuthenticated,
    ) {
      _isAuthenticated = isAuthenticated;
      _syncTimer();
    });

    _syncTimer();
  }

  void _syncTimer() {
    if (_isAuthenticated && _isResumed) {
      _timer ??= Timer.periodic(kNotificationPollInterval, (_) {
        ref.read(authProvider.notifier).refreshNotificationCount();
      });
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }
}
