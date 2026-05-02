import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String postId,
    required String postPublicId,
    required String communityId,
    required String communityName,
    String? userId,
    required String username,
    String? userGhostId,
    required String userGroup,
    required bool userDeleted,
    String? parentId,
    required int depth,
    required int noReplies,
    int? noDirectReplies,
    List<String>? ancestors,
    required String body,
    required int upvotes,
    required int downvotes,
    required DateTime createdAt,
    DateTime? editedAt,
    bool? contentStripped,
    required bool deleted,
    DateTime? deletedAt,
    String? deletedAs,
    required User author,
    bool? isAuthorMuted,
    bool? userVoted,
    bool? userVotedUp,
    String? postTitle,
    required bool postDeleted,
    String? postDeletedAs,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
