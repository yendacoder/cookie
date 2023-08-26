import 'package:flutter/material.dart';

class PlatformOutlinedButton extends StatelessWidget {
  const PlatformOutlinedButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.padding,
      this.style,
      this.color,
      this.contentColor,
      this.alignment,
      this.thickness = 2.0});

  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final TextStyle? style;
  final Color? contentColor;
  final Color? color;
  final Alignment? alignment;

  /// only applicable if color is set
  final double thickness;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButtonTheme.of(context).style;
    return OutlinedButton(
      onPressed: onPressed,
      style: color == null && padding == null && alignment == null
          ? null
          : OutlinedButton.styleFrom(
              padding: padding,
              alignment: alignment,
              side: color == null
                  ? null
                  : BorderSide(color: color!, width: thickness),
            ),
      child: DefaultTextStyle.merge(
          style: buttonStyle?.textStyle
              ?.resolve({})
              ?.merge(style)
              .merge(TextStyle(color: contentColor)),
          child: IconTheme.merge(
              data: IconThemeData(color: contentColor), child: child)),
    );
  }
}
