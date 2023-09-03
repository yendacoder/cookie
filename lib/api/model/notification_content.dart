import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_content.g.dart';

@JsonSerializable()
class NotificationContent {
  NotificationContent(
      this.addedBy,
      this.commentAuthor,
      this.postId,
      this.post,
      this.communityId,
      this.community,
      this.commentId,
      );

  final String? addedBy;
  final String? commentAuthor;
  final String? postId;
  final Post? post;
  final String? communityId;
  final Community? community;
  final String? commentId;

  factory NotificationContent.fromJson(Map<String, dynamic> json) => _$NotificationContentFromJson(json);
}