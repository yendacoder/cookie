import 'package:cookie/api/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment(
      this.id,
      this.postId,
      this.postPublicId,
      this.postTitle,
      this.communityId,
      this.communityName,
      this.userId,
      this.username,
      this.userGroup,
      this.author,
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
  String? postTitle;
  String? communityId;
  String? communityName;
  String userId;
  String username;
  String userGroup;
  User? author;
  bool userDeleted;
  String? parentId;
  int depth;
  int noReplies;
  int? noDirectReplies;
  List<String>? ancestors;
  String body;
  int upvotes;
  int downvotes;
  DateTime createdAt;
  DateTime? editedAt;
  DateTime? deletedAt;
  String? deletedBy;
  String? deletedAs;
  bool? userVoted;
  bool? userVotedUp;
  bool postDeleted;
  String? postDeletedAs;

  String get upvotePercentage {
    final total = upvotes + downvotes;
    if (total == 0) {
      return '0.0';
    }
    return (upvotes / total * 100).toStringAsFixed(1);
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
