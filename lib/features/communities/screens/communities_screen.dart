import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_segmented_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/utils/markdown_utils.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/models/community.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/communities/providers/communities_list_provider.dart';

enum _Tab { all, joined }

class CommunitiesScreen extends ConsumerStatefulWidget {
  const CommunitiesScreen({super.key, this.selectMode = false});

  final bool selectMode;

  @override
  ConsumerState<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends ConsumerState<CommunitiesScreen> {
  late _Tab _tab;
  final _searchController = TextEditingController();
  var _filter = '';

  @override
  void initState() {
    super.initState();
    final isAuthenticated = ref.read(authProvider).value != null;
    _tab = isAuthenticated ? _Tab.joined : _Tab.all;
    _searchController.addListener(
      () =>
          setState(() => _filter = _searchController.text.trim().toLowerCase()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Community> _applyFilter(List<Community> list) {
    if (_filter.isEmpty) return list;
    return list.where((c) => c.name.toLowerCase().contains(_filter)).toList();
  }

  Future<void> _onRefresh() {
    if (_tab == _Tab.all) {
      ref.invalidate(allCommunitiesProvider);
      return ref.read(allCommunitiesProvider.future);
    }
    ref.invalidate(subscribedCommunitiesProvider);
    return ref.read(subscribedCommunitiesProvider.future);
  }

  void _onRetry() {
    if (_tab == _Tab.all) {
      ref.invalidate(allCommunitiesProvider);
    } else {
      ref.invalidate(subscribedCommunitiesProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isAuthenticated = ref.watch(authProvider).value != null;

    final feedState = _tab == _Tab.all
        ? ref.watch(allCommunitiesProvider)
        : ref.watch(subscribedCommunitiesProvider);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(
          widget.selectMode
              ? l10n.communitiesSelectTitle
              : l10n.communitiesScreenTitle,
        ),
      ),
      body: Column(
        children: [
          if (isAuthenticated)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: AdaptiveSegmentedButton<_Tab>(
                segments: [
                  AdaptiveButtonSegment(
                    value: _Tab.all,
                    label: l10n.communitiesTabAll,
                  ),
                  AdaptiveButtonSegment(
                    value: _Tab.joined,
                    label: l10n.communitiesTabJoined,
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (selected) => setState(() {
                  _tab = selected.first;
                  _searchController.clear();
                }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.communitiesSearchHint,
                prefixIcon: Icon(context.searchIcon),
                suffixIcon: _filter.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _searchController.clear,
                      )
                    : null,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: switch (feedState) {
              AsyncLoading() => const Center(
                child: AdaptiveProgressIndicator(),
              ),
              AsyncError(:final error) => ErrorView(
                error: error,
                onRetry: _onRetry,
              ),
              AsyncData(:final value) => _CommunitiesList(
                communities: _applyFilter(value),
                tab: _tab,
                selectMode: widget.selectMode,
                onRefresh: _onRefresh,
              ),
            },
          ),
        ],
      ),
    );
  }
}

// ── List ──────────────────────────────────────────────────────────────────────

class _CommunitiesList extends StatelessWidget {
  const _CommunitiesList({
    required this.communities,
    required this.tab,
    required this.selectMode,
    required this.onRefresh,
  });

  final List<Community> communities;
  final _Tab tab;
  final bool selectMode;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (communities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            tab == _Tab.joined
                ? context.l10n.communitiesJoinedEmpty
                : context.l10n.communitiesEmpty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return AdaptiveRefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverList.separated(
            itemCount: communities.length,
            separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
            itemBuilder: (context, index) => _CommunityTile(
              community: communities[index],
              selectMode: selectMode,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _CommunityTile extends StatelessWidget {
  const _CommunityTile({required this.community, required this.selectMode});

  final Community community;
  final bool selectMode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveInkWell(
      onTap: () {
        if (selectMode) {
          context.pop(community);
        } else {
          context.push('/c/${community.name}');
        }
      },
      child: Row(
        children: [
          SizedBox(width: 16),
          CircleAvatar(
            backgroundColor: colorScheme.secondaryContainer,
            child: community.proPic != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: community.proPic!.fullUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    community.name.isNotEmpty
                        ? community.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(color: colorScheme.onSecondaryContainer),
                  ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(community.name, style: textTheme.titleMedium),
                  if (community.about?.isNotEmpty ?? false)
                    Text(
                      markdownToPlainText(community.about!),
                      maxLines: 4,
                      overflow: .ellipsis,
                    ),
                  SizedBox(height: 8),
                  Text(
                    context.l10n.membersLabel(community.noMembers),
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          if (!selectMode)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(context.chevronRightIcon),
            ),
        ],
      ),
    );
  }
}
