import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../models/discuit_image.dart';
import '../../auth/providers/auth_provider.dart';
import '../../communities/providers/muted_communities_list_provider.dart';
import '../../shell/providers/package_info_provider.dart';
import '../../user/providers/muted_users_list_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profileScreenTitle),
        actions: [
          if (user != null) ...[
            IconButton(
              icon: const Icon(Icons.edit_outlined),
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
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                // Auth section
                authState.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) =>
                      _SignInTile(message: context.l10n.errorGeneric),
                  data: (u) => u != null
                      ? _UserTile(
                          username: u.username,
                          points: u.points,
                          proPic: u.proPic,
                          onTap: () => context.push('/u/${u.username}'),
                        )
                      : _SignInTile(
                          message: context.l10n.errorAuthRequiredBody,
                        ),
                ),
                const Divider(height: 1),
                // Navigation
                ListTile(
                  leading: const Icon(Icons.explore_outlined),
                  title: Text(context.l10n.communitiesScreenTitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/communities'),
                ),
                if (user != null) ...[
                  ListTile(
                    leading: const Icon(Icons.bookmark_outline),
                    title: Text(context.l10n.listsScreenTitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/lists'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(context.l10n.viewMyProfile),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/u/${user.username}'),
                  ),
                  ListTile(
                    leading: Badge(
                      isLabelVisible: user.notificationsNewCount > 0,
                      child: const Icon(Icons.notifications_outlined),
                    ),
                    title: Text(
                      user.notificationsNewCount > 0
                          ? '${context.l10n.notificationsScreenTitle} [${user.notificationsNewCount}]'
                          : context.l10n.notificationsScreenTitle,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/notifications'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.voice_over_off_outlined),
                    title: Text(
                      '${context.l10n.mutedUsersScreenTitle} [${ref.watch(mutedUsersListProvider).length}]',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/muted-users'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.comments_disabled_outlined),
                    title: Text(
                      '${context.l10n.mutedCommunitiesScreenTitle} [${ref.watch(mutedCommunitiesListProvider).length}]',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/muted-communities'),
                  ),
                ],
              ],
            ),
          ),
          Container(
            alignment: .bottomRight,
            padding: EdgeInsets.all(16),
            child: Text(
              context.l10n.appNameVersion(packageInfo.version),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.logoutConfirmTitle),
        content: Text(ctx.l10n.logoutConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancelButton),
          ),
          FilledButton(
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

    return InkWell(
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
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
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
          FilledButton.tonal(
            onPressed: () => context.push('/login'),
            child: Text(context.l10n.signInButton),
          ),
        ],
      ),
    );
  }
}
