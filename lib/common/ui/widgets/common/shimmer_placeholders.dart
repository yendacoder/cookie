import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';


class ShimmerAvatar extends StatelessWidget {
  const ShimmerAvatar({super.key, this.radius = kUserIconSize / 2});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

class ShimmerIcon extends StatelessWidget {
  const ShimmerIcon({super.key, this.size = 32.0, this.padding});

  final double? size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        margin: padding,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(4.0)));
  }
}

class ShimmerText extends StatelessWidget {
  const ShimmerText(
      {super.key,
        this.textSize = 16.0,
        this.lineSpacing = 8.0,
        this.lines,
        this.padding});

  final double textSize;
  final double lineSpacing;
  final int? lines;
  final EdgeInsets? padding;

  Widget _buildLines(BuildContext context, int lines) {
    final column = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < lines; i++) ...[
            if (i > 0)
              SizedBox(
                height: lineSpacing,
              ),
            Container(
              height: textSize,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
            )
          ]
        ]);
    if (padding != null) {
      return Padding(padding: padding!, child: column);
    } else {
      return column;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (lines != null) {
      return _buildLines(context, lines!);
    }
    return LayoutBuilder(builder: (context, constraints) {
      final lines =
      ((constraints.maxHeight + lineSpacing - (padding?.vertical ?? 0)) /
          (textSize + lineSpacing))
          .floor();
      return _buildLines(context, lines);
    });
  }
}

