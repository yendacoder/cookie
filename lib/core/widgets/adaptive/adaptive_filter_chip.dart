import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AdaptiveFilterChip extends StatelessWidget {
  const AdaptiveFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      final onSurface = Theme.of(context).colorScheme.onSurface;
      return GlassChip(
        label: label,
        selected: selected,
        onTap: () => onSelected(!selected),
        iconColor: onSurface,
        selectedColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.25),
        labelStyle: TextStyle(color: onSurface),
      );
    }
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: onSelected,
    );
  }
}
