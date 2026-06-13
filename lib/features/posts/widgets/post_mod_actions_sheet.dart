import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/features/posts/providers/post_detail_provider.dart';
import 'package:cookie/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Sheet with moderator actions (lock, pin, delete) for a post, shown to
/// users who moderate the post's community.
class PostModActionsSheet extends ConsumerStatefulWidget {
  const PostModActionsSheet({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<PostModActionsSheet> createState() =>
      _PostModActionsSheetState();
}

class _PostModActionsSheetState extends ConsumerState<PostModActionsSheet> {
  bool _updatingLock = false;
  bool _updatingPin = false;
  bool _deleting = false;

  Future<void> _setLocked(bool locked) async {
    setState(() => _updatingLock = true);
    try {
      await ref
          .read(postDetailProvider(widget.post.publicId).notifier)
          .setLocked(locked);
    } catch (_) {
      if (mounted) {
        showPlatformSnackBar(context, context.l10n.postModActionsError);
      }
    } finally {
      if (mounted) setState(() => _updatingLock = false);
    }
  }

  Future<void> _setPinned(bool pinned) async {
    setState(() => _updatingPin = true);
    try {
      await ref
          .read(postDetailProvider(widget.post.publicId).notifier)
          .setPinned(pinned);
    } catch (_) {
      if (mounted) {
        showPlatformSnackBar(context, context.l10n.postModActionsError);
      }
    } finally {
      if (mounted) setState(() => _updatingPin = false);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(l10n.postModActionsDelete),
        content: Text(l10n.postModActionsDeleteConfirm),
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
          .read(postDetailProvider(widget.post.publicId).notifier)
          .deleteAsMod();
      if (mounted) {
        Navigator.of(context).pop();
        showPlatformSnackBar(context, l10n.postModActionsDeleted);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _deleting = false);
        showPlatformSnackBar(context, l10n.postModActionsError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final post =
        ref.watch(postDetailProvider(widget.post.publicId)).value ??
        widget.post;

    return SafeArea(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AdaptiveSheetHeader(title: l10n.postModActionsTitle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AdaptiveSwitchListTile(
              title: Text(l10n.postModActionsLocked),
              value: post.locked,
              onChanged: _updatingLock || post.deleted ? null : _setLocked,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AdaptiveSwitchListTile(
              title: Text(l10n.postModActionsPinned),
              value: post.isPinned,
              onChanged: _updatingPin || post.deleted ? null : _setPinned,
            ),
          ),
          AdaptiveListTile(
            title: Text(
              l10n.postModActionsDelete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            trailing: _deleting
                ? const SizedBox.square(
                    dimension: 20,
                    child: AdaptiveProgressIndicator(strokeWidth: 2),
                  )
                : null,
            onTap: _deleting || post.deleted ? null : _delete,
            contentPadding: context.useIos ? const EdgeInsets.all(20) : null,
            isLast: true,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
