import 'dart:io';

import 'package:cookie/common/util/iterable_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_record.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthRecord {
  const AuthRecord(
    this.sessionToken,
    this.csrfToken,
    this.expires,
  );

  final String? sessionToken;
  final String? csrfToken;
  final String? expires;

  factory AuthRecord.empty() {
    return const AuthRecord(null, null, null);
  }

  factory AuthRecord.fromCookies(List<Cookie> cookies) {
    final sessionCookie =
        cookies.firstWhereOrNull((cookie) => cookie.name == 'SID');
    return AuthRecord(
        sessionCookie?.value,
        cookies.firstWhereOrNull((cookie) => cookie.name == 'csrftoken')?.value,
        sessionCookie?.expires?.toIso8601String());
  }

  Map<String, dynamic> toJson() => _$AuthRecordToJson(this);

  factory AuthRecord.fromJson(Map<String, dynamic> json) =>
      _$AuthRecordFromJson(json);
}
