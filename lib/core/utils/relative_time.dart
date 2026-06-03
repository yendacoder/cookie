import 'package:cookie/l10n/app_localizations.dart';

extension RelativeTime on DateTime {
  String toRelativeString(AppLocalizations l10n) {
    final diff = DateTime.now().difference(this);
    if (diff.inMinutes < 1) return l10n.timeJustNow;
    if (diff.inHours < 1) return l10n.timeMinutesAgo(diff.inMinutes);
    if (diff.inDays < 1) return l10n.timeHoursAgo(diff.inHours);
    if (diff.inDays < 7) return l10n.timeDaysAgo(diff.inDays);
    if (diff.inDays < 30) return l10n.timeWeeksAgo(diff.inDays ~/ 7);
    if (diff.inDays < 365) return l10n.timeMonthsAgo(diff.inDays ~/ 30);
    return l10n.timeYearsAgo(diff.inDays ~/ 365);
  }
}
