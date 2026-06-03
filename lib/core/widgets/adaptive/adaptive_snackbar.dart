import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../providers/platform_style_provider.dart';

void showPlatformSnackBar(BuildContext context, String message) {
  if (context.useIos) {
    GlassSnackBar.show(context, message: message);
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
