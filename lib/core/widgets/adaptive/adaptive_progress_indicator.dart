import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  const AdaptiveProgressIndicator({super.key, this.strokeWidth, this.color});

  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      return CupertinoActivityIndicator(color: color);
    }
    return CircularProgressIndicator(strokeWidth: strokeWidth, color: color);
  }
}
