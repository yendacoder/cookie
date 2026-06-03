import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../providers/platform_style_provider.dart';

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  if (context.useIos) {
    return showCupertinoDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: false,
    );
  }
  return showDialog<T>(context: context, builder: builder);
}

/// Platform-adaptive alert dialog.
/// Renders as [CupertinoAlertDialog] on iOS and [AlertDialog] on Android.
class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
  });

  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions ?? const [],
      );
    }
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}

/// Platform-adaptive dialog action button.
///
/// On iOS renders as [CupertinoDialogAction]; on Android as [TextButton] or
/// [FilledButton] depending on [isDefault].
class AdaptiveDialogAction extends StatelessWidget {
  const AdaptiveDialogAction({
    super.key,
    required this.onPressed,
    required this.child,
    this.isDefault = false,
    this.isDestructive = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  /// Primary action — bold on iOS, [FilledButton] on Android.
  final bool isDefault;
  /// Destructive action — red on iOS, error-coloured [TextButton] on Android.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return CupertinoDialogAction(
        onPressed: onPressed,
        isDefaultAction: isDefault,
        isDestructiveAction: isDestructive,
        child: child,
      );
    }
    if (isDestructive) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error,
        ),
        child: child,
      );
    }
    return isDefault
        ? FilledButton(onPressed: onPressed, child: child)
        : TextButton(onPressed: onPressed, child: child);
  }
}
