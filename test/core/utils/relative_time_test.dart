import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockL10n extends Mock implements AppLocalizations {}

void main() {
  late _MockL10n l10n;

  setUp(() {
    l10n = _MockL10n();

    // Stub each relative-time method with a predictable format so tests can
    // assert both which branch was taken AND what count was passed.
    when(() => l10n.timeJustNow).thenReturn('just now');
    when(
      () => l10n.timeMinutesAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}m');
    when(
      () => l10n.timeHoursAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}h');
    when(
      () => l10n.timeDaysAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}d');
    when(
      () => l10n.timeWeeksAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}w');
    when(
      () => l10n.timeMonthsAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}mo');
    when(
      () => l10n.timeYearsAgo(any()),
    ).thenAnswer((i) => '${i.positionalArguments[0]}y');
  });

  DateTime ago(Duration d) => DateTime.now().subtract(d);

  group('RelativeTime.toRelativeString — branch selection', () {
    test('< 1 minute → just now', () {
      expect(
        ago(const Duration(seconds: 30)).toRelativeString(l10n),
        'just now',
      );
    });

    test('≥ 1 minute, < 1 hour → minutes branch', () {
      expect(ago(const Duration(minutes: 5)).toRelativeString(l10n), '5m');
    });

    test('≥ 1 hour, < 1 day → hours branch', () {
      expect(ago(const Duration(hours: 3)).toRelativeString(l10n), '3h');
    });

    test('≥ 1 day, < 7 days → days branch', () {
      expect(ago(const Duration(days: 3)).toRelativeString(l10n), '3d');
    });

    test('≥ 7 days, < 30 days → weeks branch', () {
      expect(ago(const Duration(days: 14)).toRelativeString(l10n), '2w');
    });

    test('≥ 30 days, < 365 days → months branch', () {
      expect(ago(const Duration(days: 60)).toRelativeString(l10n), '2mo');
    });

    test('≥ 365 days → years branch', () {
      expect(ago(const Duration(days: 400)).toRelativeString(l10n), '1y');
    });
  });

  group('RelativeTime.toRelativeString — integer division', () {
    test('week count floors correctly (20 days → 2 weeks)', () {
      expect(ago(const Duration(days: 20)).toRelativeString(l10n), '2w');
    });

    test('month count floors correctly (90 days → 3 months)', () {
      expect(ago(const Duration(days: 90)).toRelativeString(l10n), '3mo');
    });

    test('year count floors correctly (730 days → 2 years)', () {
      expect(ago(const Duration(days: 730)).toRelativeString(l10n), '2y');
    });
  });
}
