import 'package:flutter/material.dart';

class TappableItem extends StatelessWidget {
  const TappableItem(
      {Key? key,
      required this.child,
      this.onTap,
      this.onLongPress,
      this.padding})
      : super(key: key);

  final Widget child;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final EdgeInsets? padding;

  Widget _buildMaterialWithPadding(BuildContext context) {
    if (padding != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: padding!,
          child: child,
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      if (padding != null) {
        return Padding(
          padding: padding!,
          child: child,
        );
      }
      return child;
    }
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      if (padding != null) {
        return Container(
          padding: padding,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            onLongPress: onLongPress,
            child: child,
          ),
        );
      }
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          onLongPress: onLongPress,
          child: child);
    }
    return _buildMaterialWithPadding(context);
  }
}
