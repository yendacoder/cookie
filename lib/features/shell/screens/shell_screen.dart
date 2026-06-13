import 'package:cookie/features/feed/models/feed_type.dart';
import 'package:cookie/features/feed/providers/feed_provider.dart';
import 'package:cookie/features/feed/providers/visible_feed_types_provider.dart';
import 'package:cookie/features/update/providers/update_check_provider.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/shell/providers/last_tab_provider.dart';
import 'package:cookie/features/shell/providers/nav_bar_visibility_provider.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTabSelected(
    int barPosition,
    List<int> visibleBranchIndices,
    WidgetRef ref,
  ) {
    final branchIndex = visibleBranchIndices[barPosition];
    if (branchIndex == navigationShell.currentIndex &&
        branchIndex < FeedType.values.length) {
      ref.invalidate(
        feedProvider(FeedType.values[branchIndex]),
        asReload: true,
      );
    }
    ref.read(navBarVisibilityProvider.notifier).show();
    navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == navigationShell.currentIndex,
    );
    // do not save profile tab as last as it feels unexpected
    if (branchIndex < FeedType.values.length) {
      ref.read(lastTabProvider.notifier).set(branchIndex);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthLoading = ref.watch(authProvider).isLoading;
    bool isNavBarVisible = ref.watch(navBarVisibilityProvider);
    final isAuthenticated = ref.watch(
      authProvider.select((s) => s.value != null),
    );
    final notifCount = ref.watch(
      authProvider.select((s) => s.value?.notificationsNewCount ?? 0),
    );
    final hasUpdate = ref.watch(
      updateCheckProvider.select((s) => s.value != null),
    );
    final colorScheme = Theme.of(context).colorScheme;
    final useIos = ref.useIos;
    final visibleFeedTypes = ref.watch(visibleFeedTypesProvider);

    final profileBranchIndex = FeedType.values.length;
    final visibleBranchIndices = [
      for (final type in FeedType.values)
        if (visibleFeedTypes.contains(type)) type.index,
      profileBranchIndex,
    ];

    var selectedPosition = visibleBranchIndices.indexOf(
      navigationShell.currentIndex,
    );
    if (selectedPosition == -1) {
      selectedPosition = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationShell.goBranch(visibleBranchIndices.first);
      });
    }

    if (navigationShell.currentIndex == profileBranchIndex &&
        !isNavBarVisible) {
      ref.read(navBarVisibilityProvider.notifier).hide();
      isNavBarVisible = true;
    }

    // iOS profile tab icon — GlassBadge for notifications + dot for update
    Widget iosProfileIcon() {
      Widget icon = const Icon(Icons.person_outline);
      icon = GlassBadge(count: notifCount, child: icon);
      if (hasUpdate) {
        icon = GlassBadge.dot(
          dotColor: colorScheme.tertiary,
          position: BadgePosition.bottomRight,
          child: icon,
        );
      }
      return icon;
    }

    final androidBar = NavigationBar(
      selectedIndex: selectedPosition,
      labelBehavior: .alwaysHide,
      onDestinationSelected: (position) =>
          _onTabSelected(position, visibleBranchIndices, ref),
      destinations: [
        for (final type in FeedType.values)
          if (visibleFeedTypes.contains(type))
            NavigationDestination(
              icon: Icon(type.navIcon),
              selectedIcon: Icon(type.navIconSelected),
              label: type.navLabel(context.l10n),
            ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: notifCount > 0 || hasUpdate,
            backgroundColor: notifCount > 0
                ? colorScheme.primary
                : colorScheme.tertiary,
            child: const Icon(Icons.person_outline),
          ),
          selectedIcon: Badge(
            isLabelVisible: notifCount > 0 || hasUpdate,
            backgroundColor: notifCount > 0
                ? colorScheme.primary
                : colorScheme.tertiary,
            child: const Icon(Icons.person),
          ),
          label: context.l10n.navProfile,
        ),
      ],
    );

    final iosBar = GlassBottomBar(
      selectedIndex: selectedPosition,
      onTabSelected: (position) =>
          _onTabSelected(position, visibleBranchIndices, ref),
      extraButton: isAuthenticated
          ? GlassBottomBarExtraButton(
              icon: const Icon(CupertinoIcons.square_pencil),
              onTap: () => context.push('/compose'),
              label: context.l10n.navPost,
            )
          : null,
      tabs: [
        for (final type in FeedType.values)
          if (visibleFeedTypes.contains(type))
            GlassBottomBarTab(
              icon: Icon(type.navIcon),
              activeIcon: Icon(type.navIconSelected),
              label: type.navLabel(context.l10n),
            ),
        GlassBottomBarTab(
          icon: iosProfileIcon(),
          label: context.l10n.navProfile,
          glowColor: (notifCount > 0 || hasUpdate) ? colorScheme.primary : null,
        ),
      ],
    );

    final animatedBar = AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: isNavBarVisible
          ? IgnorePointer(
              ignoring: isAuthLoading,
              child: useIos ? iosBar : androidBar,
            )
          : const SizedBox.shrink(),
    );

    return Scaffold(
      extendBody: useIos,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: MediaQuery.viewPaddingOf(context).copyWith(
            bottom: isNavBarVisible
                ? 0
                : MediaQuery.viewPaddingOf(context).bottom,
          ),
        ),
        child: navigationShell,
      ),
      bottomNavigationBar: useIos ? animatedBar : ClipRect(child: animatedBar),
    );
  }
}
