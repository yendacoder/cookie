import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:cookie/core/providers/platform_style_provider.dart';

/// A single segment for [AdaptiveSegmentedButton].
///
/// [label] is always used on iOS (as a [GlassSegmentedControl] string).
/// On Android [androidWidget] is used as the button label if provided,
/// otherwise [Text(label)] is used. [androidIcon] adds a leading icon on
/// Android only.
class AdaptiveButtonSegment<T extends Object> {
  const AdaptiveButtonSegment({
    required this.value,
    required this.label,
    this.androidWidget,
    this.androidIcon,
  });

  final T value;
  final String label;
  final Widget? androidWidget;
  final Widget? androidIcon;
}

/// Platform-adaptive segmented control.
///
/// * **iOS** – [GlassSegmentedControl] using each segment's [label] string.
/// * **Android** – [SegmentedButton] with full widget/icon support.
class AdaptiveSegmentedButton<T extends Object> extends StatelessWidget {
  const AdaptiveSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
    this.showSelectedIcon = true,
    this.multiSelectionEnabled = false,
    this.emptySelectionAllowed = false,
  });

  final List<AdaptiveButtonSegment<T>> segments;
  final Set<T> selected;
  final void Function(Set<T>) onSelectionChanged;
  final bool showSelectedIcon;
  final bool multiSelectionEnabled;
  final bool emptySelectionAllowed;

  @override
  Widget build(BuildContext context) {
    if (context.useIos) {
      final selectedIndex = segments.indexWhere(
        (s) => selected.contains(s.value),
      );
      return GlassSegmentedControl(
        segments: segments.map((s) => s.label).toList(),
        selectedIndex: selectedIndex.clamp(0, segments.length - 1),
        onSegmentSelected: (i) => onSelectionChanged({segments[i].value}),
      );
    }
    return SegmentedButton<T>(
      segments: segments
          .map(
            (s) => ButtonSegment<T>(
              value: s.value,
              label: s.androidWidget ?? Text(s.label),
              icon: s.androidIcon,
            ),
          )
          .toList(),
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      showSelectedIcon: showSelectedIcon,
      multiSelectionEnabled: multiSelectionEnabled,
      emptySelectionAllowed: emptySelectionAllowed,
    );
  }
}
