import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_fab.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/core/widgets/avatar.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/features/communities/providers/community_banned_provider.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The "Banned" tab of [ModToolsScreen] — lets mods view, ban, and unban
/// users in the community.
class ModBannedTab extends ConsumerWidget {
  const ModBannedTab({super.key, required this.communityId});

  final String communityId;

  void _showBanSheet(BuildContext context) {
    showPlatformSheet<void>(
      context: context,
      builder: (_) => _BanUserSheet(communityId: communityId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final usersAsync = ref.watch(communityBannedUsersProvider(communityId));

    return Stack(
      children: [
        switch (usersAsync) {
          AsyncData(:final value) when value.isEmpty => Center(
            child: Text(
              l10n.modToolsBannedEmpty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          AsyncData(:final value) => ListView.builder(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: value.length,
            itemBuilder: (context, index) => _BannedUserTile(
              user: value[index],
              communityId: communityId,
              isLast: index == value.length - 1,
            ),
          ),
          AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () =>
                ref.invalidate(communityBannedUsersProvider(communityId)),
          ),
          _ => const Center(child: AdaptiveProgressIndicator()),
        },
        Positioned(
          bottom: 16,
          right: 16,
          child: AdaptiveFab(
            onPressed: () => _showBanSheet(context),
            icon: Icons.add,
            heroTag: 'mod-tools-ban-user',
          ),
        ),
      ],
    );
  }
}

// ── Banned user tile ────────────────────────────────────────────────────────

class _BannedUserTile extends ConsumerWidget {
  const _BannedUserTile({
    required this.user,
    required this.communityId,
    required this.isLast,
  });

  final User user;
  final String communityId;
  final bool isLast;

  Future<void> _unban(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(communityBannedUsersProvider(communityId).notifier)
          .unban(user.username);
    } catch (e) {
      if (context.mounted) {
        showPlatformSnackBar(context, apiErrorMessage(e));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveListTile(
      onTap: () => context.push('/u/${user.username}'),
      leadingSize: 40,
      leading: Avatar(
        fallback: user.username,
        radius: 20,
        imageUrl: user.proPic?.fullUrl,
      ),
      title: Text('@${user.username}'),
      trailing: AdaptiveTextButton(
        onPressed: () => _unban(context, ref),
        child: Text(context.l10n.modToolsBannedUnban),
      ),
      isLast: isLast,
    );
  }
}

// ── Ban user sheet ───────────────────────────────────────────────────────────

class _BanUserSheet extends ConsumerStatefulWidget {
  const _BanUserSheet({required this.communityId});

  final String communityId;

  @override
  ConsumerState<_BanUserSheet> createState() => _BanUserSheetState();
}

class _BanUserSheetState extends ConsumerState<_BanUserSheet> {
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
      await ref
          .read(communityBannedUsersProvider(widget.communityId).notifier)
          .ban(_usernameCtrl.text.trim());
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
          AdaptiveSheetHeader(title: l10n.modToolsBanUserTitle),
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
                      labelText: l10n.modToolsBanUsernameLabel,
                    ),
                    autofocus: true,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.modToolsBanUsernameRequired
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
                        : Text(l10n.modToolsBanSubmit),
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
