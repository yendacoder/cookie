import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlatformStyle { auto, android, ios }

final platformStyleProvider = Provider<PlatformStyle>((_) => .ios);

extension PlatformStyleRef on WidgetRef {
  bool get useIos => switch (watch(platformStyleProvider)) {
    .auto => defaultTargetPlatform == .iOS,
    .ios => true,
    .android => false,
  };
}

// For use in functions/callbacks that have BuildContext but not WidgetRef.
extension PlatformStyleContext on BuildContext {
  bool get useIos {
    final style = ProviderScope.containerOf(this).read(platformStyleProvider);
    return switch (style) {
      .auto => defaultTargetPlatform == .iOS,
      .ios => true,
      .android => false,
    };
  }
}

/// Platform-appropriate icon data for common actions.
/// Usage: `Icon(context.shareIcon)`, `Icon(context.deleteIcon, size: 20)`.
extension PlatformIcons on BuildContext {
  IconData get shareIcon => useIos ? CupertinoIcons.share : Icons.share;

  IconData get editIcon => useIos ? CupertinoIcons.pencil : Icons.edit_outlined;

  IconData get deleteIcon =>
      useIos ? CupertinoIcons.trash : Icons.delete_outline;

  IconData get closeIcon => useIos ? CupertinoIcons.xmark : Icons.close;

  IconData get chevronRightIcon =>
      useIos ? CupertinoIcons.chevron_right : Icons.chevron_right;

  IconData get searchIcon => useIos ? CupertinoIcons.search : Icons.search;

  IconData get settingsIcon => useIos ? CupertinoIcons.gear : Icons.settings;

  IconData get bookmarkIcon =>
      useIos ? CupertinoIcons.bookmark : Icons.bookmark_outline;

  IconData get notificationsIcon =>
      useIos ? CupertinoIcons.bell : Icons.notifications_outlined;
}
