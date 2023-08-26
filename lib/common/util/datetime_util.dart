import 'dart:io';

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toDisplayDateTime() {
    return DateFormat.yMd(Platform.localeName).add_jm().format(this);
  }

  String toDisplayDateTimeShort() {
    return DateFormat.MMMd(Platform.localeName).add_jm().format(this);
  }

  String toDisplayDate() {
    return DateFormat.yMd(Platform.localeName).format(this);
  }

  String toDisplayDateShort() {
    return DateFormat.MMMd(Platform.localeName).format(this);
  }

  String toDisplayTime() {
    return DateFormat.jm(Platform.localeName).format(this);
  }

  String toDisplayTimeWSeconds() {
    return DateFormat.jms(Platform.localeName).format(this);
  }

  DateTime truncateTime() {
    return copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
