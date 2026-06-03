import 'package:flutter/material.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

/// On Android renders as a standard [InkWell] with ripple.
/// On iOS renders as a [GestureDetector] with a press-opacity animation
/// matching the native UIKit cell-highlight behaviour.
class AdaptiveInkWell extends StatefulWidget {
  const AdaptiveInkWell({
    super.key,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.customBorder,
    required this.child,
  });

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final Widget child;

  @override
  State<AdaptiveInkWell> createState() => _AdaptiveInkWellState();
}

class _AdaptiveInkWellState extends State<AdaptiveInkWell> {
  bool _pressed = false;

  bool get _interactive => widget.onTap != null || widget.onLongPress != null;

  void _onTapDown(TapDownDetails _) {
    if (_interactive) setState(() => _pressed = true);
  }

  void _onTapUp(TapUpDetails _) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    if (!context.useIos) {
      return InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        borderRadius: widget.borderRadius,
        customBorder: widget.customBorder,
        child: widget.child,
      );
    }
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedOpacity(
        opacity: _pressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: widget.child,
      ),
    );
  }
}
