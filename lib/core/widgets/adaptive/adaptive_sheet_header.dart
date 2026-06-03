import 'package:flutter/material.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';
import 'adaptive_divider.dart';

/// Consistent title area for bottom sheets.
///
/// * **iOS** – centred title with enough top padding to clear
///   [GlassModalSheet]'s large corner radius; no divider (the glass
///   surface provides its own visual separation).
/// * **Android** – left-aligned title followed by a full-width divider,
///   matching the existing sheet layout.
class AdaptiveSheetHeader extends StatelessWidget {
  const AdaptiveSheetHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        const AdaptiveDivider(height: 1),
      ],
    );
  }
}
