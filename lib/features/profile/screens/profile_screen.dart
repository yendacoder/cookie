import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profileScreenTitle),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: context.l10n.logoutButton,
              onPressed: () => _confirmLogout(context, ref),
            ),
        ],
      ),
      body: ListView(
        children: [
          // Auth section
          authState.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => _SignInTile(message: context.l10n.errorGeneric),
            data: (u) => u != null
                ? _UserTile(username: u.username, points: u.points)
                : _SignInTile(message: context.l10n.errorAuthRequiredBody),
          ),
          const Divider(height: 1),
          // Navigation
          ListTile(
            leading: const Icon(Icons.explore_outlined),
            title: Text(context.l10n.communitiesScreenTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/communities'),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: Text(context.l10n.listsScreenTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/lists'),
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
  const _UserTile({required this.username, required this.points});

  final String username;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              username[0].toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@$username',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                context.l10n.pointsLabel(points),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
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
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
