import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProgressIconButton extends StatelessWidget {
  const ProgressIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.color,
      this.isRunning = false});

  final IconData icon;
  final Color? color;
  final bool isRunning;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PlatformTextButton(
      padding: EdgeInsets.zero,
      material: (_, __) => MaterialTextButtonData(
          style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(0.0, 0.0)),
        padding: WidgetStateProperty.all(const EdgeInsets.all(0.0)),
            visualDensity: VisualDensity.compact,
      )),
      onPressed: isRunning ? null : onPressed,
      child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: isRunning
              ? PlatformCircularProgressIndicator()
              : Icon(
                  icon,
                  size: 18.0,
                  color: color ??
                      (onPressed == null
                          ? theme.disabledColor
                          : theme.colorScheme.onSurface),
                )),
    );
  }
}
