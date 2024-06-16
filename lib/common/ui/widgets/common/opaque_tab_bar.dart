import 'dart:math' as math;
import 'package:flutter/material.dart';

const double _kTabHeight = 46.0;

class OpaqueTabBar extends StatelessWidget implements PreferredSizeWidget {
  const OpaqueTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.indicatorWeight = 2.0,
  });

  final List<Widget> tabs;
  final double indicatorWeight;
  final TabController? controller;

  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
          controller: controller,
          dividerHeight: 0.0,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: tabs,
        ));
  }
}
