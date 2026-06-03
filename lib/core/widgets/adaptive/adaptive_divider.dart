import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../providers/platform_style_provider.dart';

class AdaptiveDivider extends StatelessWidget {
  const AdaptiveDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return GlassDivider(
        height: height,
        thickness: thickness ?? 0.5,
        indent: indent ?? 0,
        endIndent: endIndent ?? 0,
      );
    }
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
