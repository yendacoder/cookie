import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment(
      this.id,
      this.postId,
      this.postPublicId,
      this.communityId,
      this.communityName,
      this.userId,
      this.username,
      this.userGroup,
      this.userDeleted,
      this.parentId,
      this.depth,
      this.noReplies,
      this.noDirectReplies,
      this.ancestors,
      this.body,
      this.upvotes,
      this.downvotes,
      this.createdAt,
      this.editedAt,
      this.deletedAt,
      this.deletedBy,
      this.deletedAs,
      this.userVoted,
      this.userVotedUp,
      this.postDeleted,
      this.postDeletedAs);

  String id;
  String postId;
  String postPublicId;
  String? communityId;
  String? communityName;
  String userId;
  String username;
  String userGroup;
  bool userDeleted;
  String? parentId;
  int depth;
  int noReplies;
  int? noDirectReplies;
  List<String>? ancestors;
  String body;
  int upvotes;
  int downvotes;
  String createdAt;
  DateTime createdAtDate() => DateTime.parse(createdAt);
  String? editedAt;
  String? deletedAt;
  String? deletedBy;
  String? deletedAs;
  bool? userVoted;
  bool? userVotedUp;
  bool postDeleted;
  String? postDeletedAs;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
