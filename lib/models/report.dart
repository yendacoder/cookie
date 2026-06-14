import 'package:freezed_annotation/freezed_annotation.dart';

import 'comment.dart';
import 'post.dart';

part 'report.freezed.dart';

part 'report.g.dart';

@freezed
abstract class Report with _$Report {
  const factory Report({
    required int id,
    required String communityId,
    String? postId,
    required String reason,
    String? description,
    required int reasonId,
    required String type, // "post" or "comment"
    required String targetId,
    String? actionTaken,
    DateTime? dealtAt,
    String? dealtBy,
    required DateTime createdAt,
    Map<String, dynamic>? target,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}

extension ReportExt on Report {
  Post? get targetPost =>
      type == 'post' && target != null ? Post.fromJson(target!) : null;

  Comment? get targetComment =>
      type == 'comment' && target != null ? Comment.fromJson(target!) : null;
}

/// Summary counts returned alongside a community's reports.
@freezed
abstract class CommunityReportsDetails with _$CommunityReportsDetails {
  const factory CommunityReportsDetails({
    @JsonKey(name: 'noReports') required int numReports,
    @JsonKey(name: 'noPostReports') required int numPostReports,
    @JsonKey(name: 'noCommentReports') required int numCommentReports,
  }) = _CommunityReportsDetails;

  factory CommunityReportsDetails.fromJson(Map<String, dynamic> json) =>
      _$CommunityReportsDetailsFromJson(json);
}
