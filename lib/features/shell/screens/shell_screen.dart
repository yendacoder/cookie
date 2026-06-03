import 'package:cookie/features/home/providers/home_feed_provider.dart';
import 'package:cookie/features/subscriptions/providers/subscriptions_feed_provider.dart';
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

  void _onTabSelected(int index, WidgetRef ref) {
    if (index == navigationShell.currentIndex) {
      switch (index) {
        case 0:
          ref.invalidate(homeFeedProvider, asReload: true);
        case 1:
          ref.invalidate(subscriptionsFeedProvider, asReload: true);
      }
    }
    ref.read(navBarVisibilityProvider.notifier).show();
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    // do not save profile tab as last as it feels unexpected
    if (index < 2) ref.read(lastTabProvider.notifier).set(index);
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

    if (navigationShell.currentIndex >= 2 && !isNavBarVisible) {
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
      selectedIndex: navigationShell.currentIndex,
      labelBehavior: .alwaysHide,
      onDestinationSelected: (index) => _onTabSelected(index, ref),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: context.l10n.navHome,
        ),
        NavigationDestination(
          icon: const Icon(Icons.dynamic_feed_outlined),
          selectedIcon: const Icon(Icons.dynamic_feed),
          label: context.l10n.navSubscriptions,
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
      selectedIndex: navigationShell.currentIndex,
      onTabSelected: (index) => _onTabSelected(index, ref),
      extraButton: isAuthenticated
          ? GlassBottomBarExtraButton(
              icon: const Icon(CupertinoIcons.square_pencil),
              onTap: () => context.push('/compose'),
              label: context.l10n.navPost,
            )
          : null,
      tabs: [
        GlassBottomBarTab(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: context.l10n.navHome,
        ),
        GlassBottomBarTab(
          icon: const Icon(Icons.dynamic_feed_outlined),
          activeIcon: const Icon(Icons.dynamic_feed),
          label: context.l10n.navSubscriptions,
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
