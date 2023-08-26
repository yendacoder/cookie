import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextUtil on BuildContext {
  AppLocalizations get l {
    return AppLocalizations.of(this)!;
  }

  String displayElapsedTime(DateTime time, {bool short = false}) {
    Duration diff = DateTime.now().difference(time);
    if (short) {
      if (diff.inMinutes < 1) {
        return '**1**${l.elapsedMinutesShort}';
      }
      if (diff.inMinutes <= 59) {
        return '**${diff.inMinutes}**${l.elapsedMinutesShort}';
      }
      if (diff.inHours <= 23) {
        return '**${diff.inHours}**${l.elapsedHoursShort}';
      }
      return '**${diff.inDays}**${l.elapsedDaysShort}';
    } else {
      if (diff.inMinutes < 1) {
        return l.elapsedMinutes(1);
      }
      if (diff.inMinutes <= 59) {
        return l.elapsedMinutes(diff.inMinutes);
      }
      if (diff.inHours <= 23) {
        return l.elapsedHours(diff.inHours);
      }
      return l.elapsedDays(diff.inDays);
    }
  }
}