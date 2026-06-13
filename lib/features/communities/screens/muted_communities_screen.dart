import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/features/communities/providers/community_mutes_provider.dart';
import 'package:cookie/features/communities/providers/muted_communities_list_provider.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MutedCommunitiesScreen extends ConsumerWidget {
  const MutedCommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutes = ref.watch(mutedCommunitiesListProvider);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(context.l10n.mutedCommunitiesScreenTitle),
      ),
      body: mutes.isEmpty
          ? Center(
              child: Text(
                context.l10n.mutedCommunitiesEmpty,
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
                final community = mute.mutedCommunity;
                return _MutedCommunityTile(
                  communityId: mute.mutedCommunityId,
                  name: community?.name,
                  noMembers: community?.noMembers,
                  proPicUrl: community?.proPic?.fullUrl,
                  onUnmute: () {
                    ref
                        .read(mutedCommunitiesListProvider.notifier)
                        .remove(mute.mutedCommunityId);
                    ref
                        .read(communityMutesProvider.notifier)
                        .unmute(mute.mutedCommunityId);
                  },
                );
              },
            ),
    );
  }
}

class _MutedCommunityTile extends StatelessWidget {
  const _MutedCommunityTile({
    required this.communityId,
    required this.name,
    required this.noMembers,
    required this.proPicUrl,
    required this.onUnmute,
  });

  final String communityId;
  final String? name;
  final int? noMembers;
  final String? proPicUrl;
  final VoidCallback onUnmute;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveListTile(
      onTap: () => context.push('/c/$name'),
      leadingSize: 40,
      leading: CircleAvatar(
        backgroundColor: colorScheme.secondaryContainer,
        child: proPicUrl != null
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: proPicUrl!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.group_outlined,
                color: colorScheme.onSecondaryContainer,
              ),
      ),
      title: Text(name ?? communityId),
      // members count can be set to 0 when the community record is
      // temporary before server sync
      subtitle: (noMembers ?? 0) > 0
          ? Text(context.l10n.membersLabel(noMembers!))
          : null,
      trailing: AdaptiveTextButton(
        onPressed: onUnmute,
        child: Text(context.l10n.communityUnmute),
      ),
    );
  }
}
