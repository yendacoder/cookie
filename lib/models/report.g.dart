// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Report _$ReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Report', json, ($checkedConvert) {
      final val = _Report(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        communityId: $checkedConvert('communityId', (v) => v as String),
        postId: $checkedConvert('postId', (v) => v as String?),
        reason: $checkedConvert('reason', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        reasonId: $checkedConvert('reasonId', (v) => (v as num).toInt()),
        type: $checkedConvert('type', (v) => v as String),
        targetId: $checkedConvert('targetId', (v) => v as String),
        actionTaken: $checkedConvert('actionTaken', (v) => v as String?),
        dealtAt: $checkedConvert(
          'dealtAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        dealtBy: $checkedConvert('dealtBy', (v) => v as String?),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        target: $checkedConvert('target', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'postId': instance.postId,
  'reason': instance.reason,
  'description': instance.description,
  'reasonId': instance.reasonId,
  'type': instance.type,
  'targetId': instance.targetId,
  'actionTaken': instance.actionTaken,
  'dealtAt': instance.dealtAt?.toIso8601String(),
  'dealtBy': instance.dealtBy,
  'createdAt': instance.createdAt.toIso8601String(),
  'target': instance.target,
};

_CommunityReportsDetails _$CommunityReportsDetailsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CommunityReportsDetails',
  json,
  ($checkedConvert) {
    final val = _CommunityReportsDetails(
      numReports: $checkedConvert('noReports', (v) => (v as num).toInt()),
      numPostReports: $checkedConvert(
        'noPostReports',
        (v) => (v as num).toInt(),
      ),
      numCommentReports: $checkedConvert(
        'noCommentReports',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'numReports': 'noReports',
    'numPostReports': 'noPostReports',
    'numCommentReports': 'noCommentReports',
  },
);

Map<String, dynamic> _$CommunityReportsDetailsToJson(
  _CommunityReportsDetails instance,
) => <String, dynamic>{
  'noReports': instance.numReports,
  'noPostReports': instance.numPostReports,
  'noCommentReports': instance.numCommentReports,
};
