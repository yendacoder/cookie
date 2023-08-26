import 'package:flutter/material.dart';

class NestedIndicator extends StatelessWidget {
  const NestedIndicator(
      {super.key, this.size = 6.0, this.padding = 2.0, this.color});

  final double size;
  final double padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomPaint(
        size: Size(size + padding, size + padding),
        painter: CircleIndicatorPainter(
          color ?? theme.disabledColor,
          padding,
        ));
  }
}

class CircleIndicatorPainter extends CustomPainter {
  CircleIndicatorPainter(Color indicatorColor, this._padding) {
    indicatorPaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;
  }

  late final Paint indicatorPaint;
  final double _padding;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(_padding, _padding, size.width - _padding * 2,
          size.height - _padding * 2),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      oldDelegate is! CircleIndicatorPainter ||
      oldDelegate.indicatorPaint.color != indicatorPaint.color;
}
