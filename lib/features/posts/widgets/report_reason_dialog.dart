import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:flutter/material.dart';

Future<int?> showReportReasonDialog(BuildContext context) {
  final reasons = context.l10n.reportReasons.split('\n');
  return showPlatformDialog<int>(
    context: context,
    builder: (ctx) => AdaptiveAlertDialog(
      title: Text(context.l10n.reportTitle),
      content: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            for (int i = 0; i < reasons.length; i++)
              AdaptiveListTile(
                onTap: () => Navigator.pop(ctx, i + 1),
                title: Text(
                  reasons[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
      actions: [
        AdaptiveDialogAction(
          isDefault: true,
          onPressed: () => Navigator.pop(ctx),
          child: Text(context.l10n.cancelButton),
        ),
      ],
    ),
  );
}
