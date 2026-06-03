import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/communities/providers/muted_communities_list_provider.dart';
import 'package:cookie/features/shell/providers/package_info_provider.dart';
import 'package:cookie/features/update/providers/update_check_provider.dart';
import 'package:cookie/features/user/providers/muted_users_list_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;
    final packageInfo = ref.watch(packageInfoProvider);
    final update = ref.watch(updateCheckProvider).value;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(context.l10n.profileScreenTitle),
        actions: [
          if (user != null) ...[
            IconButton(
              icon: Icon(context.editIcon),
              tooltip: context.l10n.editProfileTitle,
              onPressed: () => context.push('/profile/edit'),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: context.l10n.logoutButton,
              onPressed: () => _confirmLogout(context, ref),
            ),
          ],
        ],
      ),
      body: ListView(
        children: [
          // Auth section
          authState.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
            error: (_, _) => _SignInTile(message: context.l10n.errorGeneric),
            data: (u) => u != null
                ? _UserTile(
                    username: u.username,
                    points: u.points,
                    proPic: u.proPic,
                    onTap: () => context.push('/u/${u.username}'),
                  )
                : _SignInTile(message: context.l10n.errorAuthRequiredBody),
          ),
          const AdaptiveDivider(height: 1),
          // Navigation
          AdaptiveListTile(
            leading: const Icon(Icons.explore_outlined),
            title: Text(context.l10n.communitiesScreenTitle),
            trailing: Icon(context.chevronRightIcon),
            onTap: () => context.push('/communities'),
          ),
          if (user != null) ...[
            AdaptiveListTile(
              leading: Icon(context.bookmarkIcon),
              title: Text(context.l10n.listsScreenTitle),
              trailing: Icon(context.chevronRightIcon),
              onTap: () => context.push('/lists'),
            ),
            AdaptiveListTile(
              leading: Badge(
                isLabelVisible: user.notificationsNewCount > 0,
                child: Icon(context.notificationsIcon),
              ),
              title: Text(
                user.notificationsNewCount > 0
                    ? '${context.l10n.notificationsScreenTitle} [${user.notificationsNewCount}]'
                    : context.l10n.notificationsScreenTitle,
              ),
              trailing: Icon(context.chevronRightIcon),
              onTap: () => context.push('/notifications'),
            ),
            AdaptiveListTile(
              leading: const Icon(Icons.voice_over_off_outlined),
              title: Text(
                '${context.l10n.mutedUsersScreenTitle} [${ref.watch(mutedUsersListProvider).length}]',
              ),
              trailing: Icon(context.chevronRightIcon),
              onTap: () => context.push('/muted-users'),
            ),
            AdaptiveListTile(
              leading: const Icon(Icons.comments_disabled_outlined),
              title: Text(
                '${context.l10n.mutedCommunitiesScreenTitle} [${ref.watch(mutedCommunitiesListProvider).length}]',
              ),
              trailing: Icon(context.chevronRightIcon),
              onTap: () => context.push('/muted-communities'),
            ),
            AdaptiveListTile(
              leading: Icon(context.settingsIcon),
              title: Text(context.l10n.settingsScreenTitle),
              trailing: Icon(context.chevronRightIcon),
              onTap: () => context.push('/settings'),
            ),
          ],
          if (update != null) ...[
            AdaptiveListTile(
              leading: Badge(
                isLabelVisible: true,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: const Icon(Icons.download),
              ),
              title: Text(context.l10n.updateAvailableTitle),
              subtitle: Text(
                context.l10n.updateAvailableSubtitle(update.version),
              ),
              trailing: AdaptiveFilledButton(
                onPressed: () => launchUrl(
                  Uri.parse(update.downloadUrl),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text(context.l10n.updateDownloadButton),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: .centerRight,
              child: Text(
                context.l10n.appNameVersion(packageInfo.version),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(ctx.l10n.logoutConfirmTitle),
        content: Text(ctx.l10n.logoutConfirmBody),
        actions: [
          AdaptiveDialogAction(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancelButton),
          ),
          AdaptiveDialogAction(
            isDefault: true,
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.l10n.logoutButton),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authProvider.notifier).logout();
    }
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({
    required this.username,
    required this.points,
    required this.proPic,
    required this.onTap,
  });

  final String username;
  final int points;
  final DiscuitImage? proPic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveInkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primaryContainer,
              child: proPic != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: proPic!.fullUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      username[0].toUpperCase(),
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@$username', style: textTheme.titleMedium),
                  Text(
                    context.l10n.pointsLabel(points),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(context.chevronRightIcon, color: colorScheme.onSurfaceVariant),
            if (!context.useIos) SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _SignInTile extends StatelessWidget {
  const _SignInTile({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.person_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.errorAuthRequired,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AdaptiveFilledButton(
            onPressed: () => context.push('/login'),
            tonal: true,
            child: Text(context.l10n.signInButton),
          ),
        ],
      ),
    );
  }
}
