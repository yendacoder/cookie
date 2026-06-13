import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_menu_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/posts/providers/post_detail_provider.dart';
import 'package:cookie/features/user/widgets/block_user_dialog.dart';
import 'package:cookie/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'comment_mod_actions_sheet.dart';
import 'report_reason_dialog.dart';

// ── Comment menu button ───────────────────────────────────────────────────────

enum _CommentMenuAction { edit, delete, report, block, modActions }

class CommentMenuButton extends ConsumerWidget {
  const CommentMenuButton({
    super.key,
    required this.comment,
    required this.postPublicId,
    required this.muted,
    this.isMod = false,
  });

  final Comment comment;
  final String postPublicId;
  final Color muted;
  final bool isMod;

  void _deleteComment(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(l10n.commentDeleteTitle),
        content: Text(l10n.commentDeleteConfirm),
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
    if (confirmed != true || !context.mounted) return;
    try {
      await ref
          .read(postDetailProvider(postPublicId).notifier)
          .deleteComment(comment.id);
    } catch (e) {
      if (context.mounted) {
        showPlatformSnackBar(context, e.toString());
      }
    }
  }

  void _reportComment(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final reason = await showReportReasonDialog(context);
    if (reason == null) return;
    try {
      await ref
          .read(postDetailProvider(postPublicId).notifier)
          .reportComment(comment.id, reason);
      if (context.mounted) {
        showPlatformSnackBar(context, l10n.commentReportSuccess);
      }
    } catch (_) {
      if (context.mounted) showPlatformSnackBar(context, l10n.reportFail);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).value;
    if (currentUser == null) {
      return const SizedBox.shrink();
    }

    final isOwn = currentUser.username == comment.username;
    final l10n = context.l10n;

    return AdaptiveMenuButton<_CommentMenuAction>(
      androidIcon: Icon(Icons.more_horiz, size: 14, color: muted),
      iconSize: 14,
      iosButtonSize: 28,
      androidStyle: TextButton.styleFrom(
        padding: .zero,
        visualDensity: .compact,
        minimumSize: Size.zero,
        iconSize: 14,
        tapTargetSize: .shrinkWrap,
      ),
      items: [
        if (isOwn) ...[
          AdaptiveMenuItem(
            value: _CommentMenuAction.edit,
            label: l10n.commentMenuEdit,
          ),
          AdaptiveMenuItem(
            value: _CommentMenuAction.delete,
            label: l10n.commentMenuDelete,
            isDestructive: true,
          ),
        ],
        AdaptiveMenuItem(
          value: _CommentMenuAction.report,
          label: l10n.postMenuReport,
        ),
        if (!isOwn && comment.userId != null)
          AdaptiveMenuItem(
            value: _CommentMenuAction.block,
            label: l10n.postMenuBlock,
            isDestructive: true,
          ),
        if (isMod)
          AdaptiveMenuItem(
            value: _CommentMenuAction.modActions,
            label: l10n.commentMenuModActions,
          ),
      ],
      onSelected: (action) async {
        switch (action) {
          case .edit:
            showPlatformSheet<void>(
              context: context,
              builder: (_) => _CommentEditSheet(
                comment: comment,
                postPublicId: postPublicId,
              ),
            );
          case .delete:
            _deleteComment(context, ref);
          case .report:
            _reportComment(context, ref);
          case .block:
            final userId = comment.userId;
            if (userId == null) return;
            final blocked = await showBlockUserDialog(
              context,
              ref,
              userId: userId,
              username: comment.username,
              targetId: comment.id,
              targetType: 'comment',
            );
            if (blocked) {
              ref.invalidate(postDetailProvider(postPublicId));
            }
          case .modActions:
            showPlatformSheet<void>(
              context: context,
              builder: (_) => CommentModActionsSheet(
                comment: comment,
                postPublicId: postPublicId,
              ),
            );
        }
      },
    );
  }
}

// ── Comment edit sheet ────────────────────────────────────────────────────────

class _CommentEditSheet extends ConsumerStatefulWidget {
  const _CommentEditSheet({required this.comment, required this.postPublicId});

  final Comment comment;
  final String postPublicId;

  @override
  ConsumerState<_CommentEditSheet> createState() => _CommentEditSheetState();
}

class _CommentEditSheetState extends ConsumerState<_CommentEditSheet> {
  late final TextEditingController _ctrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.comment.body);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final body = _ctrl.text.trim();
    if (body.isEmpty || body == widget.comment.body) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(postDetailProvider(widget.postPublicId).notifier)
          .editComment(widget.comment.id, body);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        showPlatformSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdaptiveSheetHeader(title: l10n.commentEditTitle),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _ctrl,
                  decoration: InputDecoration(),
                  maxLines: 6,
                  minLines: 3,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                AdaptiveFilledButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox.square(
                          dimension: 20,
                          child: AdaptiveProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.saveButton),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
