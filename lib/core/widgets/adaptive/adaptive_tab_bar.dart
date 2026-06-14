import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A single tab definition for [AdaptiveTabBar].
class AdaptiveTab {
  const AdaptiveTab({required this.label, this.icon});

  final String label;
  final IconData? icon;
}

/// Platform-adaptive tab bar for use alongside a [TabController] /
/// [TabBarView].
///
/// * **iOS** – [GlassTabBar] with liquid glass styling.
/// * **Android** – Material [TabBar].
///
/// Place below [AdaptiveAppBar] in the body (e.g. in a [Column] with the
/// [TabBarView] in an [Expanded]) — [GlassAppBar] has no `bottom` slot.
class AdaptiveTabBar extends StatelessWidget {
  const AdaptiveTabBar({super.key, this.controller, required this.tabs});

  /// Defaults to [DefaultTabController.of] when omitted.
  final TabController? controller;
  final List<AdaptiveTab> tabs;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? DefaultTabController.of(context);

    if (context.useIos) {
      final cs = Theme.of(context).colorScheme;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, _) => GlassTabBar(
            tabs: [
              for (final tab in tabs)
                GlassTab(
                  label: tab.label,
                  icon: tab.icon != null ? Icon(tab.icon) : null,
                ),
            ],
            selectedIndex: controller.index,
            onTabSelected: (i) => controller.animateTo(i),
            isScrollable: tabs.length > 3,
            selectedLabelStyle: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              color: cs.onSurface.withValues(alpha: 0.6),
            ),
            backgroundColor: cs.onSurface.withValues(alpha: 0.08),
            indicatorColor: cs.primary.withValues(alpha: 0.25),
          ),
        ),
      );
    }

    return TabBar(
      controller: controller,
      isScrollable: tabs.length > 3,
      tabs: [
        for (final tab in tabs)
          Tab(text: tab.label, icon: tab.icon != null ? Icon(tab.icon) : null),
      ],
    );
  }
}
