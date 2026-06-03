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
/// * **iOS** – renders a [GlassPullDownButton] (iOS 14+ pull-down menu).
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
    this.androidPadding,
    this.androidStyle,
    this.iosButtonSize = 44,
  });

  final List<AdaptiveMenuItem<T>> items;
  final void Function(T value) onSelected;

  /// Icon widget shown on Android. Defaults to [Icons.more_horiz].
  final Widget? androidIcon;
  final double? iconSize;
  final EdgeInsetsGeometry? androidPadding;

  /// Button style passed to [PopupMenuButton] on Android only.
  final ButtonStyle? androidStyle;

  /// Size of the glass trigger button on iOS (width and height).
  final double iosButtonSize;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return GlassPullDownButton(
        buttonWidth: iosButtonSize,
        buttonHeight: iosButtonSize,
        icon: Icon(
          CupertinoIcons.ellipsis_circle,
          size: iconSize,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        quality: .premium,
        items: items
            .map(
              (item) => GlassMenuItem(
                title: item.label,
                isDestructive: item.isDestructive,
                onTap: () => onSelected(item.value),
                titleStyle: item.isDestructive
                    ? null
                    : TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
              ),
            )
            .toList(),
      );
    }
    return PopupMenuButton<T>(
      icon: androidIcon ?? const Icon(Icons.more_horiz),
      iconSize: iconSize,
      padding: androidPadding ?? EdgeInsets.zero,
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
