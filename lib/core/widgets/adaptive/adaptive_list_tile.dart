import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

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
    this.leadingSize,
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

  /// When set, constrains [leading] to a square of this size on Android.
  /// On iOS the leading is always constrained to 32 pt to match GlassListTile's
  /// fixed column width and prevent non-square avatars from being squeezed.
  final double? leadingSize;

  Widget? _sizedLeading(Widget? w, double size) =>
      w == null ? null : SizedBox.square(dimension: size, child: w);

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      final cs = Theme.of(context).colorScheme;
      return GlassListTile(
        title: title,
        subtitle: subtitle,
        leading: _sizedLeading(leading, 32),
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        isLast: isLast,
        showDivider: !isLast,
        leadingIconColor: cs.onSurface,
        titleStyle: TextStyle(color: cs.onSurface),
        subtitleStyle: TextStyle(color: cs.onSurfaceVariant),
      );
    }
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leadingSize != null
          ? _sizedLeading(leading, leadingSize!)
          : leading,
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
      final cs = Theme.of(context).colorScheme;
      return GlassListTile(
        title: title,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: cs.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        titleStyle: TextStyle(color: cs.onSurface),
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
