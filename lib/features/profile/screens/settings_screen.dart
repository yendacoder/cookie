import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../shell/providers/text_scale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textScale = ref.watch(textScaleProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(context.l10n.textScaleSetting, style: textTheme.titleMedium),
          SegmentedButton<double>(
            multiSelectionEnabled: false,
            emptySelectionAllowed: false,
            showSelectedIcon: false,
            segments: [
              for (final (label, scale) in [
                ('A', 1.0),
                ('A', 1.15),
                ('A', 1.3),
                ('A', 1.5),
              ])
                ButtonSegment(
                  value: scale,
                  label: Container(
                    alignment: .center,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          label,
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
