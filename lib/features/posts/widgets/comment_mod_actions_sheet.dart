import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/features/communities/providers/community_banned_provider.dart';
import 'package:cookie/features/posts/providers/post_detail_provider.dart';
import 'package:cookie/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Sheet with moderator actions (lock, delete) for a comment, shown to
/// users who moderate the comment's community.
class CommentModActionsSheet extends ConsumerStatefulWidget {
  const CommentModActionsSheet({
    super.key,
    required this.comment,
    required this.postPublicId,
  });

  final Comment comment;
  final String postPublicId;

  @override
  ConsumerState<CommentModActionsSheet> createState() =>
      _CommentModActionsSheetState();
}

class _CommentModActionsSheetState
    extends ConsumerState<CommentModActionsSheet> {
  bool _updatingLock = false;
  bool _deleting = false;
  bool _banningUser = false;

  Future<void> _setLocked(bool locked) async {
    setState(() => _updatingLock = true);
    try {
      await ref
          .read(postDetailProvider(widget.postPublicId).notifier)
          .setCommentLocked(widget.comment.id, locked);
    } catch (_) {
      if (mounted) {
        showPlatformSnackBar(context, context.l10n.commentModActionsError);
      }
    } finally {
      if (mounted) setState(() => _updatingLock = false);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(l10n.commentModActionsDelete),
        content: Text(l10n.commentModActionsDeleteConfirm),
        actions: [
          AdaptiveDialogAction(
            onPressed: () => ctx.pop(false),
            child: Text(l10n.cancelButton),
          ),
          AdaptiveDialogAction(
            isDefault: true,
            isDestructive: true,
            onPressed: () => ctx.pop(true),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _deleting = true);
    try {
      await ref
          .read(postDetailProvider(widget.postPublicId).notifier)
          .deleteCommentAsMod(widget.comment.id);
      if (mounted) {
        Navigator.of(context).pop();
        showPlatformSnackBar(context, l10n.commentModActionsDeleted);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _deleting = false);
        showPlatformSnackBar(context, l10n.commentModActionsError);
      }
    }
  }

  Future<void> _banUser() async {
    final l10n = context.l10n;
    final username = widget.comment.username;
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(l10n.modActionsBanUser),
        content: Text(l10n.modActionsBanUserConfirm(username)),
        actions: [
          AdaptiveDialogAction(
            onPressed: () => ctx.pop(false),
            child: Text(l10n.cancelButton),
          ),
          AdaptiveDialogAction(
            isDefault: true,
            isDestructive: true,
            onPressed: () => ctx.pop(true),
            child: Text(l10n.modActionsBanUser),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _banningUser = true);
    try {
      await ref
          .read(apiClientProvider)
          .post(
            'communities/${widget.comment.communityId}/banned',
            data: {'username': username},
          );
      ref.invalidate(
        communityBannedUsersProvider(widget.comment.communityId),
        asReload: true,
      );
      if (mounted) {
        Navigator.of(context).pop();
        showPlatformSnackBar(context, l10n.modActionsUserBanned(username));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _banningUser = false);
        showPlatformSnackBar(context, apiErrorMessage(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final post = ref.watch(postDetailProvider(widget.postPublicId)).value;
    final comment =
        post?.comments?.firstWhere(
          (c) => c.id == widget.comment.id,
          orElse: () => widget.comment,
        ) ??
        widget.comment;

    return SafeArea(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AdaptiveSheetHeader(title: l10n.commentModActionsTitle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AdaptiveSwitchListTile(
              title: Text(l10n.commentModActionsLocked),
              value: comment.locked,
              onChanged: _updatingLock || comment.deleted ? null : _setLocked,
            ),
          ),
          AdaptiveListTile(
            title: Text(
              l10n.commentModActionsDelete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            trailing: _deleting
                ? const SizedBox.square(
                    dimension: 20,
                    child: AdaptiveProgressIndicator(strokeWidth: 2),
                  )
                : null,
            onTap: _deleting || comment.deleted ? null : _delete,
            contentPadding: context.useIos ? const EdgeInsets.all(20) : null,
          ),
          AdaptiveListTile(
            title: Text(
              l10n.modActionsBanUser,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            trailing: _banningUser
                ? const SizedBox.square(
                    dimension: 20,
                    child: AdaptiveProgressIndicator(strokeWidth: 2),
                  )
                : null,
            onTap: _banningUser || comment.userDeleted ? null : _banUser,
            contentPadding: context.useIos ? const EdgeInsets.all(20) : null,
            isLast: true,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
