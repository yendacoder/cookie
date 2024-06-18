import 'package:cookie/api/model/comment.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/image.dart';
import 'package:cookie/api/model/link.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/common/util/common_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post(
      this.id,
      this.publicId,
      this.type,
      this.userId,
      this.username,
      this.author,
      this.userGroup,
      this.userDeleted,
      this.isPinned,
      this.communityId,
      this.communityName,
      this.title,
      this.body,
      this.image,
      this.link,
      this.communityProPic,
      this.communityBannerImage,
      this.locked,
      this.lockedBy,
      this.lockedByGroup,
      this.lockedAt,
      this.upvotes,
      this.downvotes,
      this.hotness,
      this.createdAt,
      this.editedAt,
      this.lastActivityAt,
      this.deleted,
      this.deletedAt,
      this.deletedBy,
      this.deletedAs,
      this.deletedContent,
      this.deletedContentAs,
      this.noComments,
      this.comments,
      this.commentsNext,
      this.userVoted,
      this.userVotedUp,
      this.community);

  String id;
  String publicId;
  String type;

  PostType get postType => type.toEnum(PostType.values);
  String userId;
  String username;
  User author;
  String userGroup;

  UserGroup get userGroupType => userGroup.toEnum(UserGroup.values);
  bool userDeleted;
  bool isPinned;
  String communityId;
  String communityName;
  String title;
  Image? image;
  String? body;
  Link? link;
  Image? communityProPic;
  Image? communityBannerImage;
  bool locked;
  String? lockedBy;
  String? lockedByGroup;

  UserGroup? get lockedByGroupType => lockedByGroup?.toEnum(UserGroup.values);
  String? lockedAt;

  int upvotes;
  int downvotes;
  int hotness;

  DateTime createdAt;
  DateTime? editedAt;
  DateTime? lastActivityAt;

  bool deleted;
  DateTime? deletedAt;

  String? deletedBy;
  String? deletedAs;

  UserGroup? get deletedAsType => deletedAs?.toEnum(UserGroup.values);

  bool deletedContent;
  String? deletedContentAs;

  UserGroup? get deletedContentAsType =>
      deletedContentAs?.toEnum(UserGroup.values);

  int noComments;
  List<Comment>? comments;
  String? commentsNext;

  bool? userVoted;
  bool? userVotedUp;

  Community? community;

  @JsonKey(includeFromJson: false)
  dynamic youtubeMeta;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
