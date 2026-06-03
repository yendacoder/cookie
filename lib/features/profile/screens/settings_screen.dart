import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/adaptive/adaptive_segmented_button.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/adaptive/adaptive_app_bar.dart';
import '../../../core/widgets/adaptive/adaptive_scaffold.dart';
import '../../shell/providers/text_scale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textScale = ref.watch(textScaleProvider);
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: Text(context.l10n.settingsScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(context.l10n.textScaleSetting, style: textTheme.titleMedium),
          AdaptiveSegmentedButton<double>(
            showSelectedIcon: false,
            emptySelectionAllowed: false,
            segments: [
              for (final (iosLabel, scale) in [
                ('100%', 1.0),
                ('115%', 1.15),
                ('130%', 1.3),
                ('150%', 1.5),
              ])
                AdaptiveButtonSegment(
                  value: scale,
                  label: iosLabel,
                  androidWidget: Container(
                    alignment: .center,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          'A',
                          textScaler: TextScaler.linear(1.0),
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: textTheme.bodyMedium!.fontSize! * scale,
                          ),
                        ),
                        Text(
                          '${(scale * 100).round().toInt()}%',
                          textScaler: TextScaler.linear(1.0),
                          style: textTheme.labelMedium!.copyWith(
                            fontSize: textTheme.labelMedium!.fontSize! * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            selected: {textScale},
            onSelectionChanged: (selected) =>
                ref.read(textScaleProvider.notifier).set(selected.first),
          ),
        ],
      ),
    );
  }
}
