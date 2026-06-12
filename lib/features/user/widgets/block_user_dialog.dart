import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/features/user/providers/user_mutes_provider.dart';

/// Shows a confirmation dialog, then mutes [userId] and reports [targetId]
/// (a post or comment) so moderators are notified of the content.
///
/// Returns `true` if the user was actually blocked (i.e. the mute succeeded),
/// or `false` if the dialog was cancelled or the block failed.
Future<bool> showBlockUserDialog(
  BuildContext context,
  WidgetRef ref, {
  required String userId,
  required String username,
  required String targetId,
  required String targetType,
}) async {
  final l10n = context.l10n;
  final confirmed = await showPlatformDialog<bool>(
    context: context,
    builder: (ctx) => AdaptiveAlertDialog(
      title: Text(l10n.blockUserTitle),
      content: Text(l10n.blockUserConfirm(username)),
      actions: [
        AdaptiveDialogAction(
          onPressed: () => ctx.pop(false),
          child: Text(l10n.cancelButton),
        ),
        AdaptiveDialogAction(
          isDefault: true,
          isDestructive: true,
          onPressed: () => ctx.pop(true),
          child: Text(l10n.postMenuBlock),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return false;

  try {
    await blockUserAndReport(
      ref,
      userId: userId,
      username: username,
      targetId: targetId,
      targetType: targetType,
    );
    if (context.mounted) showPlatformSnackBar(context, l10n.blockUserSuccess);
    return true;
  } catch (_) {
    if (context.mounted) showPlatformSnackBar(context, l10n.blockUserFail);
    return false;
  }
}
