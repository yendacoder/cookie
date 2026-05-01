import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../auth/providers/auth_provider.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: IgnorePointer(
        ignoring: isAuthLoading,
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
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
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: context.l10n.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
