import 'package:cookie/features/home/providers/home_feed_provider.dart';
import 'package:cookie/features/subscriptions/providers/subscriptions_feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/last_tab_provider.dart';
import '../providers/nav_bar_visibility_provider.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthLoading = ref.watch(authProvider).isLoading;
    final isNavBarVisible = ref.watch(navBarVisibilityProvider);
    final hasUnread = ref.watch(
      authProvider.select((s) => (s.value?.notificationsNewCount ?? 0) > 0),
    );

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ClipRect(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: isNavBarVisible
              ? IgnorePointer(
                  ignoring: isAuthLoading,
                  child: NavigationBar(
                    selectedIndex: navigationShell.currentIndex,
                    labelBehavior: .alwaysHide,
                    onDestinationSelected: (index) {
                      if (index == navigationShell.currentIndex) {
                        switch (index) {
                          case 0: ref.invalidate(homeFeedProvider, asReload: true);
                          case 1: ref.invalidate(subscriptionsFeedProvider, asReload: true);
                        }
                      }
                      ref.read(navBarVisibilityProvider.notifier).show();
                      navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      );
                      ref.read(lastTabProvider.notifier).set(index);
                      SharedPreferencesAsync().setInt('last_tab', index);
                    },
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
                          isLabelVisible: hasUnread,
                          child: const Icon(Icons.person_outline),
                        ),
                        selectedIcon: Badge(
                          isLabelVisible: hasUnread,
                          child: const Icon(Icons.person),
                        ),
                        label: context.l10n.navProfile,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
