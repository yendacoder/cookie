import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

class AdaptiveFab extends StatelessWidget {
  const AdaptiveFab({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.heroTag,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return GlassButton(icon: Icon(icon), onTap: onPressed);
    }
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      heroTag: heroTag,
      child: Icon(icon),
    );
  }
}
