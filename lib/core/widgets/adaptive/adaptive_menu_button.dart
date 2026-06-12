import 'package:cookie/core/widgets/adaptive/adaptive_ink_well.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

/// A single item in an [AdaptiveMenuButton].
class AdaptiveMenuItem<T extends Object> {
  const AdaptiveMenuItem({
    required this.value,
    required this.label,
    this.isDestructive = false,
  });

  final T value;
  final String label;
  final bool isDestructive;
}

/// Platform-adaptive contextual action button.
///
/// * **iOS** – renders a plain icon button that opens a [GlassMenu].
/// * **Android** – renders a [PopupMenuButton].
///
/// Build [items] with the same conditional logic you previously used in
/// [PopupMenuButton.itemBuilder]; pass a single [onSelected] callback that
/// receives the chosen item's [AdaptiveMenuItem.value].
class AdaptiveMenuButton<T extends Object> extends StatelessWidget {
  const AdaptiveMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.androidIcon,
    this.iconSize,
    this.androidStyle,
    this.iosButtonSize = 44,
  });

  final List<AdaptiveMenuItem<T>> items;
  final void Function(T value) onSelected;

  /// Icon widget shown on Android. Defaults to [Icons.more_horiz].
  final Widget? androidIcon;
  final double? iconSize;

  /// Button style passed to [PopupMenuButton] on Android only.
  final ButtonStyle? androidStyle;

  /// Size of the glass trigger button on iOS (width and height).
  final double iosButtonSize;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      final colorScheme = Theme.of(context).colorScheme;
      // GlassPullDownButton doesn't expose glassSettings for its menu, and
      // the default ~12% opaque glassColor leaves item labels unreadable
      // over busy backgrounds. Build the trigger + menu directly (this is
      // all GlassPullDownButton does internally) so we can pass a near-opaque,
      // theme-matched glassColor to the menu.
      const menuGlassDefaults = LiquidGlassSettings(
        blur: 10,
        thickness: 10,
        lightAngle: GlassDefaults.lightAngle,
        lightIntensity: 0.7,
        ambientStrength: 0.4,
        saturation: 1.2,
        refractiveIndex: 0.7,
        chromaticAberration: 0.0,
      );
      return GlassMenu(
        glassSettings: LiquidGlassSettings(
          blur: menuGlassDefaults.blur,
          thickness: menuGlassDefaults.thickness,
          glassColor: colorScheme.surface.withValues(alpha: 0.92),
          lightAngle: menuGlassDefaults.lightAngle,
          lightIntensity: menuGlassDefaults.lightIntensity,
          ambientStrength: menuGlassDefaults.ambientStrength,
          saturation: menuGlassDefaults.saturation,
          refractiveIndex: menuGlassDefaults.refractiveIndex,
          chromaticAberration: menuGlassDefaults.chromaticAberration,
        ),
        triggerBuilder: (context, toggleMenu) => AdaptiveInkWell(
          onTap: toggleMenu,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              CupertinoIcons.ellipsis_circle,
              size: iconSize,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        items: items
            .map(
              (item) => GlassMenuItem(
                title: item.label,
                isDestructive: item.isDestructive,
                onTap: () => onSelected(item.value),
                titleStyle: item.isDestructive
                    ? null
                    : TextStyle(color: colorScheme.onSurface),
              ),
            )
            .toList(),
      );
    }
    return PopupMenuButton<T>(
      icon: androidIcon ?? const Icon(Icons.more_horiz),
      iconSize: iconSize,
      padding: EdgeInsets.zero,
      style: androidStyle,
      onSelected: onSelected,
      itemBuilder: (_) => items
          .map(
            (item) => PopupMenuItem<T>(
              value: item.value,
              child: Text(
                item.label,
                style: item.isDestructive
                    ? TextStyle(color: Theme.of(context).colorScheme.error)
                    : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
