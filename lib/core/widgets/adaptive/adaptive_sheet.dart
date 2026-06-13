import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

Future<T?> showPlatformSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  if (context.useIos) {
    final isDark = Theme.of(context).brightness == .dark;
    return GlassModalSheet.show<T>(
      context: context,
      builder: builder,
      initialState: .half,
      settings: isDark
          ? const LiquidGlassSettings()
          : const LiquidGlassSettings(
              blur: 20,
              thickness: 40,
              glassColor: Color.fromARGB(200, 255, 255, 255),
            ),
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    isScrollControlled: true,
  );
}
