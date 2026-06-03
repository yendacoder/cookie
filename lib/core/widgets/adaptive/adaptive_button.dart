import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

/// Wraps [button] in a [CupertinoTheme] that sources its primary colour from
/// the ambient Material [ColorScheme], so Cupertino buttons use the app's
/// brand colour rather than the default iOS blue.
Widget _themed(BuildContext context, Widget button, {Color? primaryColor}) {
  return CupertinoTheme(
    data: CupertinoThemeData(
      primaryColor: primaryColor ?? Theme.of(context).colorScheme.primary,
    ),
    child: button,
  );
}

Widget _labelWithIcon(Widget icon, Widget label) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [icon, const SizedBox(width: 6), label],
);

// ---------------------------------------------------------------------------
// AdaptiveFilledButton
// ---------------------------------------------------------------------------

class AdaptiveFilledButton extends StatelessWidget {
  const AdaptiveFilledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.tonal = false,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final EdgeInsets? padding;

  /// Maps to [FilledButton.tonal] on Android; uses [ColorScheme.secondaryContainer] on iOS.
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    final content = icon != null ? _labelWithIcon(icon!, child) : child;
    if (context.useIos) {
      final cs = Theme.of(context).colorScheme;
      return _themed(
        context,
        CupertinoButton(
          onPressed: onPressed,
          color: tonal ? cs.secondaryContainer : cs.primary,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: content,
        ),
        primaryColor: tonal ? cs.onSecondaryContainer : cs.onPrimary,
      );
    }
    final style = padding == null
        ? null
        : FilledButton.styleFrom(padding: padding);
    if (icon != null) {
      return tonal
          ? FilledButton.tonal(
              onPressed: onPressed,

              style: style,
              child: _labelWithIcon(icon!, child),
            )
          : FilledButton.icon(
              onPressed: onPressed,
              style: style,
              icon: icon!,
              label: child,
            );
    }
    return tonal
        ? FilledButton.tonal(onPressed: onPressed, style: style, child: child)
        : FilledButton(onPressed: onPressed, style: style, child: child);
  }
}

// ---------------------------------------------------------------------------
// AdaptiveOutlinedButton
// ---------------------------------------------------------------------------

class AdaptiveOutlinedButton extends StatelessWidget {
  const AdaptiveOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final content = icon != null ? _labelWithIcon(icon!, child) : child;
    if (context.useIos) {
      return _themed(
        context,
        CupertinoButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: content,
        ),
      );
    }
    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: child,
      );
    }
    return OutlinedButton(onPressed: onPressed, child: child);
  }
}

// ---------------------------------------------------------------------------
// AdaptiveTextButton
// ---------------------------------------------------------------------------

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.foregroundColor,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;

  /// Overrides the text/icon colour — use for destructive actions.
  final Color? foregroundColor;

  /// Passed through on Android only; ignored on iOS.
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final content = icon != null ? _labelWithIcon(icon!, child) : child;
    if (context.useIos) {
      return _themed(
        context,
        CupertinoButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: content,
        ),
        primaryColor: foregroundColor,
      );
    }
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: child,
        style: style,
      );
    }
    return TextButton(onPressed: onPressed, style: style, child: child);
  }
}
