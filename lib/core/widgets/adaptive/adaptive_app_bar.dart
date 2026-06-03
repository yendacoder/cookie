import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../providers/platform_style_provider.dart';

class AdaptiveAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.title,
    this.titleSpacing,
    this.actions,
    this.leading,
    this.actionsPadding,
    this.backgroundColor,
    this.foregroundColor,
    this.systemOverlayStyle,
  });

  final Widget? title;
  final double? titleSpacing;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsetsGeometry? actionsPadding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  /// Android only — controls the status bar icon brightness.
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.useIos) {
      final canPop = Navigator.of(context).canPop();
      Widget bar = GlassAppBar(
        title: title,
        actions: actions,
        leading:
            leading ??
            (canPop ? const CupertinoNavigationBarBackButton() : null),
        preferredSize: preferredSize,
        backgroundColor: backgroundColor ?? Colors.transparent,
        settings: const LiquidGlassSettings(),
      );
      if (foregroundColor != null) {
        bar = IconTheme(
          data: IconThemeData(color: foregroundColor),
          child: DefaultTextStyle(
            style: TextStyle(color: foregroundColor),
            child: bar,
          ),
        );
      }
      return bar;
    }
    return AppBar(
      title: title,
      titleSpacing: titleSpacing,
      actions: actions,
      leading: leading,
      actionsPadding: actionsPadding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      systemOverlayStyle: systemOverlayStyle,
    );
  }
}

class AdaptiveSliverAppBar extends ConsumerWidget {
  const AdaptiveSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.actionsPadding,
    this.pinned = true,
  });

  final Widget title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  /// Whether the bar stays pinned when scrolled on iOS.
  /// Android always uses floating+snap regardless of this value.
  final bool pinned;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.useIos) {
      final topPadding = MediaQuery.viewPaddingOf(context).top;
      return SliverPersistentHeader(
        pinned: pinned,
        delegate: _GlassAppBarDelegate(
          totalHeight: topPadding + kToolbarHeight,
          title: title,
          actions: actions,
        ),
      );
    }
    return SliverAppBar(
      title: title,
      actions: actions,
      actionsPadding: actionsPadding,
      floating: true,
      snap: true,
    );
  }
}

class _GlassAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _GlassAppBarDelegate({
    required this.totalHeight,
    required this.title,
    this.actions,
  });

  final double totalHeight;
  final Widget title;
  final List<Widget>? actions;

  @override
  double get minExtent => totalHeight;

  @override
  double get maxExtent => totalHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final canPop = Navigator.of(context).canPop();
    return GlassAppBar(
      title: title,
      actions: actions,
      leading: canPop ? const CupertinoNavigationBarBackButton() : null,
      preferredSize: const Size.fromHeight(kToolbarHeight),
      settings: const LiquidGlassSettings(),
    );
  }

  @override
  bool shouldRebuild(_GlassAppBarDelegate old) =>
      old.totalHeight != totalHeight ||
      old.title != title ||
      old.actions != actions;
}
