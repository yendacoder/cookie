import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
