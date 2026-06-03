import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../providers/platform_style_provider.dart';

class AdaptiveListTile extends StatelessWidget {
  const AdaptiveListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
    this.dense,
    this.isLast = false,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;
  final bool? dense;

  /// Hides the bottom divider on iOS — set true on the last item in a group.
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return GlassListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        isLast: isLast,
        showDivider: !isLast,
      );
    }
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: contentPadding,
      dense: dense,
    );
  }
}

class AdaptiveSwitchListTile extends StatelessWidget {
  const AdaptiveSwitchListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final Widget title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return GlassListTile(
        title: title,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: Theme.of(context).colorScheme.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      );
    }
    return SwitchListTile(
      title: title,
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}
