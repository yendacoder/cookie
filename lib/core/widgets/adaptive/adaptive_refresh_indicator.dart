import 'package:flutter/cupertino.dart' show CupertinoSliverRefreshControl;
import 'package:flutter/material.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

/// Platform-adaptive pull-to-refresh wrapper for a [CustomScrollView].
///
/// * **Android** – wraps the [CustomScrollView] in a [RefreshIndicator].
/// * **iOS** – injects a [CupertinoSliverRefreshControl] inside the
///   [CustomScrollView]; no outer wrapper is added.
///
/// The [child] must be a [CustomScrollView]. The widget automatically inserts
/// the iOS refresh sliver, so callers only specify [onRefresh] once.
///
/// Use [headerSliverCount] when the [CustomScrollView] begins with sliver
/// app-bar(s) that should appear *above* the refresh indicator. The refresh
/// control is inserted after that many leading slivers (default 0).
///
/// If the [CustomScrollView] does not yet have
/// [AlwaysScrollableScrollPhysics], it is added automatically so that
/// pull-to-refresh works even when the content is shorter than the viewport.
class AdaptiveRefreshIndicator extends StatelessWidget {
  const AdaptiveRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.headerSliverCount = 0,
  });

  final RefreshCallback onRefresh;
  final CustomScrollView child;

  /// Number of leading slivers (e.g. a sliver app bar) that should remain
  /// above the refresh control on iOS.
  final int headerSliverCount;

  @override
  Widget build(BuildContext context) {
    final scrollView = _withPhysicsAndRefreshSliver(context);
    if (context.useIos) return scrollView;
    return RefreshIndicator(onRefresh: onRefresh, child: scrollView);
  }

  CustomScrollView _withPhysicsAndRefreshSliver(BuildContext context) {
    // CupertinoSliverRefreshControl requires BouncingScrollPhysics so the
    // user can actually pull past the top of the list. AlwaysScrollable wraps
    // it so refresh still triggers even when the list is shorter than the
    // viewport.
    final physics = context.useIos
        ? const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics())
        : (child.physics ?? const AlwaysScrollableScrollPhysics());
    final slivers = context.useIos
        ? [
            ...child.slivers.take(headerSliverCount),
            CupertinoSliverRefreshControl(onRefresh: onRefresh),
            ...child.slivers.skip(headerSliverCount),
          ]
        : child.slivers;

    return CustomScrollView(
      key: child.key,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      controller: child.controller,
      primary: child.primary,
      physics: physics,
      scrollBehavior: child.scrollBehavior,
      shrinkWrap: child.shrinkWrap,
      center: child.center,
      anchor: child.anchor,
      cacheExtent: child.cacheExtent,
      slivers: slivers,
      semanticChildCount: child.semanticChildCount,
      dragStartBehavior: child.dragStartBehavior,
      keyboardDismissBehavior: child.keyboardDismissBehavior,
      restorationId: child.restorationId,
      clipBehavior: child.clipBehavior,
    );
  }
}
