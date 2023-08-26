// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRecord _$AuthRecordFromJson(Map<String, dynamic> json) => AuthRecord(
      json['sessionToken'] as String?,
      json['csrfToken'] as String?,
      json['expires'] as String?,
    );

Map<String, dynamic> _$AuthRecordToJson(AuthRecord instance) =>
    <String, dynamic>{
      'sessionToken': instance.sessionToken,
      'csrfToken': instance.csrfToken,
      'expires': instance.expires,
    };
