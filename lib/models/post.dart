import 'package:freezed_annotation/freezed_annotation.dart';

import 'community.dart';
import 'discuit_image.dart';
import 'user.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String type,
    required String publicId,
    required String userId,
    required String username,
    String? userGhostId,
    required String userGroup,
    required bool userDeleted,
    required bool isPinned,
    required bool isPinnedSite,
    required String communityId,
    required String communityName,
    required DiscuitImage communityProPic,
    required DiscuitImage communityBannerImage,
    required String title,
    String? body,
    DiscuitImage? image,
    @Default([]) List<DiscuitImage> images,
    PostLink? link,
    required bool locked,
    String? lockedBy,
    String? lockedByGroup,
    DateTime? lockedAt,
    required int upvotes,
    required int downvotes,
    required int hotness,
    required DateTime createdAt,
    DateTime? editedAt,
    required DateTime lastActivityAt,
    required bool deleted,
    DateTime? deletedAt,
    String? deletedBy,
    String? deletedAs,
    required bool deletedContent,
    String? deletedContentAs,
    required int noComments,
    bool? userVoted,
    bool? userVotedUp,
    required bool isAuthorMuted,
    required bool isCommunityMuted,
    Community? community,
    User? author,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
abstract class PostLink with _$PostLink {
  const factory PostLink({
    required String url,
    required String hostname,
    DiscuitImage? image,
  }) = _PostLink;

  factory PostLink.fromJson(Map<String, dynamic> json) =>
      _$PostLinkFromJson(json);
}
