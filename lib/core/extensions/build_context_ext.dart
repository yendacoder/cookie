import 'package:cookie/features/shell/models/content_text_size.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension ContentTextSizeStyleX on BuildContext {
  TextStyle? contentBodyStyle(ContentTextSize size) => switch (size) {
    .small => Theme.of(this).textTheme.bodySmall,
    .medium => Theme.of(this).textTheme.bodyMedium,
    .large => Theme.of(this).textTheme.bodyLarge,
  };

  TextStyle? contentLabelStyle(ContentTextSize size) => switch (size) {
    .small => Theme.of(this).textTheme.labelSmall,
    .medium => Theme.of(this).textTheme.labelMedium,
    .large => Theme.of(this).textTheme.labelLarge,
  };
}
