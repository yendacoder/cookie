import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_fab.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/core/widgets/avatar.dart';
import 'package:cookie/features/communities/providers/community_provider.dart';
import 'package:cookie/models/community.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The "Moderators" tab of [ModToolsScreen] — lets mods view, add, and
/// remove moderators of the community.
class ModModeratorsTab extends ConsumerStatefulWidget {
  const ModModeratorsTab({
    super.key,
    required this.community,
    required this.communityName,
  });

  final Community community;
  final String communityName;

  @override
  ConsumerState<ModModeratorsTab> createState() => _ModModeratorsTabState();
}

class _ModModeratorsTabState extends ConsumerState<ModModeratorsTab> {
  late List<User> _mods;

  @override
  void initState() {
    super.initState();
    _mods = widget.community.mods;
  }

  @override
  void didUpdateWidget(ModModeratorsTab old) {
    super.didUpdateWidget(old);
    if (old.community.mods != widget.community.mods) {
      setState(() => _mods = widget.community.mods);
    }
  }

  void _pushMods(List<User> mods) {
    ref
        .read(communityDetailProvider(widget.communityName).notifier)
        .replace(widget.community.copyWith(mods: mods));
  }

  Future<void> _removeMod(User mod) async {
    final l10n = context.l10n;
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(l10n.modToolsModeratorsRemoveTitle),
        content: Text(l10n.modToolsModeratorsRemoveConfirm(mod.username)),
        actions: [
          AdaptiveDialogAction(
            onPressed: () => ctx.pop(false),
            child: Text(l10n.cancelButton),
          ),
          AdaptiveDialogAction(
            isDefault: true,
            isDestructive: true,
            onPressed: () => ctx.pop(true),
            child: Text(l10n.modToolsModeratorsRemove),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      await ref
          .read(apiClientProvider)
          .delete('communities/${widget.community.id}/mods/${mod.username}');
      final updated = _mods.where((m) => m.id != mod.id).toList();
      setState(() => _mods = updated);
      _pushMods(updated);
    } catch (e) {
      if (mounted) {
        showPlatformSnackBar(context, apiErrorMessage(e));
      }
    }
  }

  void _showAddModeratorSheet() {
    showPlatformSheet<void>(
      context: context,
      builder: (_) => _AddModeratorSheet(
        communityId: widget.community.id,
        onAdded: (mods) {
          setState(() => _mods = mods);
          _pushMods(mods);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (_mods.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              l10n.modToolsModeratorsEmpty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            AdaptiveFilledButton(
              onPressed: _showAddModeratorSheet,
              icon: const Icon(Icons.add),
              child: Text(l10n.modToolsAddModerator),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(bottom: 88),
          itemCount: _mods.length,
          itemBuilder: (context, index) {
            final mod = _mods[index];
            return AdaptiveListTile(
              onTap: () => context.push('/u/${mod.username}'),
              leadingSize: 40,
              leading: Avatar(
                fallback: mod.username,
                radius: 20,
                imageUrl: mod.proPic?.fullUrl,
              ),
              title: Text('@${mod.username}'),
              trailing: AdaptiveTextButton(
                onPressed: () => _removeMod(mod),
                child: Text(l10n.modToolsModeratorsRemove),
              ),
              isLast: index == _mods.length - 1,
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: AdaptiveFab(
            onPressed: _showAddModeratorSheet,
            icon: Icons.add,
            heroTag: 'mod-tools-add-moderator',
          ),
        ),
      ],
    );
  }
}

// ── Add moderator sheet ──────────────────────────────────────────────────────

class _AddModeratorSheet extends ConsumerStatefulWidget {
  const _AddModeratorSheet({required this.communityId, required this.onAdded});

  final String communityId;
  final void Function(List<User> mods) onAdded;

  @override
  ConsumerState<_AddModeratorSheet> createState() => _AddModeratorSheetState();
}

class _AddModeratorSheetState extends ConsumerState<_AddModeratorSheet> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    try {
      final response = await ref
          .read(apiClientProvider)
          .post(
            'communities/${widget.communityId}/mods',
            data: {'username': _usernameCtrl.text.trim()},
          );
      final mods = ((response.data as List?) ?? const [])
          .cast<Map<String, dynamic>>()
          .map(User.fromJson)
          .toList();
      widget.onAdded(mods);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        showPlatformSnackBar(context, apiErrorMessage(e));
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
          AdaptiveSheetHeader(title: l10n.modToolsAddModeratorTitle),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.modToolsModeratorUsernameLabel,
                    ),
                    autofocus: true,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.modToolsModeratorUsernameRequired
                        : null,
                  ),
                  const SizedBox(height: 16),
                  AdaptiveFilledButton(
                    onPressed: _saving ? null : _submit,
                    child: _saving
                        ? const SizedBox.square(
                            dimension: 20,
                            child: AdaptiveProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.modToolsAddModerator),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
