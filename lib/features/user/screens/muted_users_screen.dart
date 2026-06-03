import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/features/user/providers/muted_users_list_provider.dart';
import 'package:cookie/features/user/providers/user_mutes_provider.dart';

class MutedUsersScreen extends ConsumerWidget {
  const MutedUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutes = ref.watch(mutedUsersListProvider);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: Text(context.l10n.mutedUsersScreenTitle)),
      body: mutes.isEmpty
          ? Center(
              child: Text(
                context.l10n.mutedUsersEmpty,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : ListView.separated(
              itemCount: mutes.length,
              separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
              itemBuilder: (context, index) {
                final mute = mutes[index];
                final user = mute.mutedUser;
                return _MutedUserTile(
                  userId: mute.mutedUserId,
                  username: user?.username,
                  proPicUrl: user?.proPic?.fullUrl,
                  onUnmute: () {
                    ref
                        .read(userMutesProvider.notifier)
                        .unmute(mute.mutedUserId);
                  },
                );
              },
            ),
    );
  }
}

class _MutedUserTile extends StatelessWidget {
  const _MutedUserTile({
    required this.userId,
    required this.username,
    required this.proPicUrl,
    required this.onUnmute,
  });

  final String userId;
  final String? username;
  final String? proPicUrl;
  final VoidCallback onUnmute;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveListTile(
      onTap: () => context.push('/u/$username'),
      leadingSize: 40,
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        child: proPicUrl != null
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: proPicUrl!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            : Text(
                username != null && username!.isNotEmpty
                    ? username![0].toUpperCase()
                    : '?',
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
      ),
      title: Text(username != null ? '@$username' : userId),
      trailing: AdaptiveTextButton(
        onPressed: onUnmute,
        child: Text(context.l10n.userUnmute),
      ),
    );
  }
}
