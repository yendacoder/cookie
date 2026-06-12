// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_poll_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Periodically refreshes the notification count while the app is
/// authenticated and in the foreground, and immediately on resume.

@ProviderFor(NotificationPoller)
final notificationPollerProvider = NotificationPollerProvider._();

/// Periodically refreshes the notification count while the app is
/// authenticated and in the foreground, and immediately on resume.
final class NotificationPollerProvider
    extends $NotifierProvider<NotificationPoller, void> {
  /// Periodically refreshes the notification count while the app is
  /// authenticated and in the foreground, and immediately on resume.
  NotificationPollerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPollerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPollerHash();

  @$internal
  @override
  NotificationPoller create() => NotificationPoller();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$notificationPollerHash() =>
    r'dc141da3c0b62345f41e41bcd597d934486f3aa3';

/// Periodically refreshes the notification count while the app is
/// authenticated and in the foreground, and immediately on resume.

abstract class _$NotificationPoller extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
