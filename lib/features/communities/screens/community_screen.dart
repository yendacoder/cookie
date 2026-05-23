import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/markdown_text.dart';
import '../../../models/community.dart';
import '../../../models/discuit_image.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/home_feed_provider.dart';
import '../../posts/widgets/post_card.dart';
import '../../posts/widgets/post_card_skeleton.dart';
import '../../home/providers/home_feed_provider.dart'
    show PostFeedState, PostSort;
import '../providers/community_mutes_provider.dart';
import '../providers/community_provider.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key, required this.communityName});

  final String communityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityState = ref.watch(communityDetailProvider(communityName));

    return communityState.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(communityName)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: Text(communityName)),
        body: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(communityDetailProvider(communityName)),
        ),
      ),
      data: (community) => _CommunityLoaded(community: community),
    );
  }
}

// ── Loaded state ──────────────────────────────────────────────────────────────

class _CommunityLoaded extends ConsumerWidget {
  const _CommunityLoaded({required this.community});

  final Community community;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(
      communityFeedProvider(community.name, community.id),
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(communityDetailProvider(community.name));
          ref.invalidate(communityFeedProvider(community.name, community.id));
          await ref.read(communityDetailProvider(community.name).future);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Pinned app bar shows the community name once header scrolls away.
            SliverAppBar(pinned: true, title: Text(community.name)),
            SliverToBoxAdapter(child: _CommunityHeader(community: community)),
            SliverToBoxAdapter(
              child: _SortChips(communityName: community.name),
            ),
            _FeedSliver(community: community, feedState: feedState),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

// ── Community header ──────────────────────────────────────────────────────────

class _CommunityHeader extends ConsumerWidget {
  const _CommunityHeader({required this.community});

  final Community community;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Banner + overlapping avatar
        SizedBox(
          height: 160,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Banner
              Positioned.fill(
                child: community.bannerImage != null
                    ? CachedNetworkImage(
                        imageUrl: community.bannerImage!.fullUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => ColoredBox(
                          color: colorScheme.surfaceContainerHighest,
                        ),
                      )
                    : ColoredBox(color: colorScheme.surfaceContainerHighest),
              ),
              // Community avatar overlapping the bottom of the banner
              Positioned(
                bottom: -32,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: colorScheme.primaryContainer,
                    child: community.proPic != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: community.proPic!.fullUrl,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            community.name[0].toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          context.l10n.membersLabel(community.noMembers),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  if (user != null) ...[
                    const SizedBox(width: 8),
                    _JoinButton(community: community),
                  ],
                ],
              ),
              if (community.about case final String about
                  when about.isNotEmpty) ...[
                const SizedBox(height: 12),
                MarkdownText(
                  about,
                  baseStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (user != null)
                    FilledButton.icon(
                      onPressed: () =>
                          context.push('/compose', extra: community),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: Text(context.l10n.communityCreatePost),
                    ),
                  if (community.rules.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () =>
                          _showRulesDialog(context, community.rules),
                      icon: const Icon(Icons.gavel_outlined, size: 18),
                      label: Text(context.l10n.communityRulesTitle),
                    ),
                  if (community.mods.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () => _showModsDialog(context, community.mods),
                      icon: const Icon(Icons.shield_outlined, size: 18),
                      label: Text(context.l10n.communityModeratorsTitle),
                    ),
                  if (community.userMod == true)
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.push('/c/${community.name}/mod-tools'),
                      icon: const Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 18,
                      ),
                      label: Text(context.l10n.communityModTools),
                    ),
                  if (user != null) _MuteButton(community: community),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  void _showRulesDialog(BuildContext context, List<CommunityRule> rules) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.communityRulesTitle),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: rules.length,
            separatorBuilder: (_, _) => const Divider(height: 16),
            itemBuilder: (_, i) {
              final rule = rules[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ${rule.rule}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  if (rule.description case final String desc
                      when desc.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(desc, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.confirmButton),
          ),
        ],
      ),
    );
  }

  void _showModsDialog(BuildContext context, List<dynamic> mods) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.communityModeratorsTitle),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: mods.length,
            itemBuilder: (_, i) {
              final mod = mods[i];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: mod.proPic != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: (mod.proPic as DiscuitImage).fullUrl,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          (mod.username as String)[0].toUpperCase(),
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                ),
                title: Text(
                  mod.username as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.confirmButton),
          ),
        ],
      ),
    );
  }
}

// ── Mute / Unmute button ──────────────────────────────────────────────────────

class _MuteButton extends ConsumerWidget {
  const _MuteButton({required this.community});

  final Community community;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muted = ref.watch(communityMutesProvider).contains(community.id);

    return OutlinedButton.icon(
      onPressed: () {
        final notifier = ref.read(communityMutesProvider.notifier);
        if (muted) {
          notifier.unmute(community.id);
        } else {
          notifier.mute(community.id, community.name);
        }
      },
      icon: Icon(
        muted ? Icons.volume_up_outlined : Icons.volume_off_outlined,
        size: 18,
      ),
      label: Text(
        muted ? context.l10n.communityUnmute : context.l10n.communityMute,
      ),
    );
  }
}

// ── Join / Leave button ───────────────────────────────────────────────────────

class _JoinButton extends ConsumerWidget {
  const _JoinButton({required this.community});

  final Community community;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isJoined = community.userJoined == true;

    return isJoined
        ? OutlinedButton(
            onPressed: () => ref
                .read(communityDetailProvider(community.name).notifier)
                .toggleJoin(),
            child: Text(context.l10n.leaveButton),
          )
        : FilledButton(
            onPressed: () => ref
                .read(communityDetailProvider(community.name).notifier)
                .toggleJoin(),
            child: Text(context.l10n.joinButton),
          );
  }
}

// ── Sort chips ────────────────────────────────────────────────────────────────

class _SortChips extends ConsumerWidget {
  const _SortChips({required this.communityName});

  final String communityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current =
        ref.watch(communityFeedSortProvider(communityName)).value ??
        PostSort.hot;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        spacing: 8,
        children: [
          for (final sort in PostSort.values)
            FilterChip(
              label: Text(sort.label(context.l10n)),
              selected: sort == current,
              showCheckmark: false,
              onSelected: (_) => ref
                  .read(communityFeedSortProvider(communityName).notifier)
                  .setSort(sort),
            ),
        ],
      ),
    );
  }
}

// ── Post feed sliver ──────────────────────────────────────────────────────────

class _FeedSliver extends ConsumerWidget {
  const _FeedSliver({required this.community, required this.feedState});

  final Community community;
  final AsyncValue<PostFeedState> feedState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return feedState.when(
      loading: () => const SliverToBoxAdapter(
        child: PostFeedSkeleton(showCommunity: false),
      ),
      error: (error, _) => SliverToBoxAdapter(
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(
            communityFeedProvider(community.name, community.id),
          ),
        ),
      ),
      data: (feed) => SliverMainAxisGroup(
        slivers: [
          SliverList.separated(
            itemCount: feed.posts.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 32),
            itemBuilder: (context, index) {
              if (index == feed.posts.length) {
                return _FeedFooter(
                  feed: feed,
                  communityName: community.name,
                  communityId: community.id,
                );
              }
              final post = feed.posts[index];
              return PostCard(
                post: post,
                showCommunity: false,
                checkMutedCommunity: false,
                onTap: () => context.push(
                  '/c/${post.communityName}/post/${post.publicId}',
                  extra: post,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Feed footer ───────────────────────────────────────────────────────────────

class _FeedFooter extends ConsumerWidget {
  const _FeedFooter({
    required this.feed,
    required this.communityName,
    required this.communityId,
  });

  final PostFeedState feed;
  final String communityName;
  final String communityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!feed.isLoadingMore && feed.hasMore && feed.loadMoreError == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref
              .read(communityFeedProvider(communityName, communityId).notifier)
              .loadMore();
        }
      });
    }

    if (feed.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (feed.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.feedLoadMoreError,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            TextButton(
              onPressed: () => ref
                  .read(
                    communityFeedProvider(communityName, communityId).notifier,
                  )
                  .loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (!feed.hasMore) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            context.l10n.feedEndOfContent,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
