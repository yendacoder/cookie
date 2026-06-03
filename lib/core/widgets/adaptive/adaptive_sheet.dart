import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../providers/platform_style_provider.dart';

Future<T?> showPlatformSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  if (context.useIos) {
    return GlassModalSheet.show<T>(
      context: context,
      builder: builder,
      initialState: SheetState.half,
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    isScrollControlled: true,
  );
}
