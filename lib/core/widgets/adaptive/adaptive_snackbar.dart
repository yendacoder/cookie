import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

void showPlatformSnackBar(BuildContext context, String message) {
  if (context.useIos) {
    GlassSnackBar.show(
      context,
      message: message,
      position: GlassToastPosition.top,
    );
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
