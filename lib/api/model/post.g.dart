// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as String,
      json['publicId'] as String,
      json['type'] as String,
      json['userId'] as String,
      json['username'] as String,
      json['userGroup'] as String,
      json['userDeleted'] as bool,
      json['isPinned'] as bool,
      json['communityId'] as String,
      json['communityName'] as String,
      json['title'] as String,
      json['body'] as String?,
      json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      json['link'] == null
          ? null
          : Link.fromJson(json['link'] as Map<String, dynamic>),
      json['communityProPic'] == null
          ? null
          : Image.fromJson(json['communityProPic'] as Map<String, dynamic>),
      json['communityBannerImage'] == null
          ? null
          : Image.fromJson(
              json['communityBannerImage'] as Map<String, dynamic>),
      json['locked'] as bool,
      json['lockedBy'] as String?,
      json['lockedByGroup'] as String?,
      json['lockedAt'] as String?,
      json['upvotes'] as int,
      json['downvotes'] as int,
      json['hotness'] as int,
      json['createdAt'] as String,
      json['editedAt'] as String?,
      json['lastActivityAt'] as String?,
      json['deleted'] as bool,
      json['deletedAt'] as String?,
      json['deletedBy'] as String?,
      json['deletedAs'] as String?,
      json['deletedContent'] as bool,
      json['deletedContentAs'] as String?,
      json['noComments'] as int,
      (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['commentsNext'] as String?,
      json['userVoted'] as bool?,
      json['userVotedUp'] as bool?,
      json['community'] == null
          ? null
          : Community.fromJson(json['community'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'publicId': instance.publicId,
      'type': instance.type,
      'userId': instance.userId,
      'username': instance.username,
      'userGroup': instance.userGroup,
      'userDeleted': instance.userDeleted,
      'isPinned': instance.isPinned,
      'communityId': instance.communityId,
      'communityName': instance.communityName,
      'title': instance.title,
      'image': instance.image,
      'body': instance.body,
      'link': instance.link,
      'communityProPic': instance.communityProPic,
      'communityBannerImage': instance.communityBannerImage,
      'locked': instance.locked,
      'lockedBy': instance.lockedBy,
      'lockedByGroup': instance.lockedByGroup,
      'lockedAt': instance.lockedAt,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'hotness': instance.hotness,
      'createdAt': instance.createdAt,
      'editedAt': instance.editedAt,
      'lastActivityAt': instance.lastActivityAt,
      'deleted': instance.deleted,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
      'deletedAs': instance.deletedAs,
      'deletedContent': instance.deletedContent,
      'deletedContentAs': instance.deletedContentAs,
      'noComments': instance.noComments,
      'comments': instance.comments,
      'commentsNext': instance.commentsNext,
      'userVoted': instance.userVoted,
      'userVotedUp': instance.userVotedUp,
      'community': instance.community,
    };
