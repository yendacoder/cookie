import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    this.icon,
    this.text,
    this.style,
    this.iconColor,
    this.iconSize = 16.0,
    this.iconPadding = 8.0,
    this.isInverted = false,
  });

  final String? text;
  final IconData? icon;
  final double iconSize;
  final double iconPadding;
  final Color? iconColor;
  final TextStyle? style;
  final bool isInverted;

  Widget _buildText(BuildContext context) {
    return Text(
      text!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      icon,
      color: iconColor ?? Theme.of(context).colorScheme.onBackground,
      size: iconSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      if (text != null) {
        return _buildText(context);
      }
      return const SizedBox.shrink();
    }
    if (text == null) {
      return _buildIcon(context);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isInverted) _buildText(context) else _buildIcon(context),
        SizedBox(width: iconPadding),
        if (isInverted) _buildIcon(context) else _buildText(context),
      ],
    );
  }
}
