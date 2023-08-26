import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<bool> showConfirmationDialog(BuildContext context, String text,
    {required String okText,
    void Function(BuildContext)? onConfirm,
    String? cancelText,
    void Function(BuildContext)? onCancel,
    String? titleText,
    bool isDestructive = false,
    bool isCancellable = true}) {
  return showPlatformDialog<bool>(
      context: context,
      barrierDismissible: isCancellable,
      builder: (dialogContext) => PlatformAlertDialog(
            content: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            title: titleText == null ? null : Text(titleText),
            actions: [
              if (cancelText != null)
                PlatformDialogAction(
                  cupertino: (_, __) => CupertinoDialogActionData(
                    isDestructiveAction: isDestructive,
                  ),
                  onPressed: () {
                    onCancel?.call(dialogContext);
                    Navigator.of(dialogContext).pop(false);
                  },
                  child: Text(cancelText),
                ),
              PlatformDialogAction(
                cupertino: (_, __) => CupertinoDialogActionData(
                  isDefaultAction: true,
                ),
                onPressed: () {
                  onConfirm?.call(dialogContext);
                  Navigator.of(dialogContext).pop(true);
                },
                child: Text(okText),
              )
            ],
          )).then((value) => value == true);
}
