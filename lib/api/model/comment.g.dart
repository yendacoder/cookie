// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as String,
      json['postId'] as String,
      json['postPublicId'] as String,
      json['communityId'] as String?,
      json['communityName'] as String?,
      json['userId'] as String,
      json['username'] as String,
      json['userGroup'] as String,
      json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      json['userDeleted'] as bool,
      json['parentId'] as String?,
      json['depth'] as int,
      json['noReplies'] as int,
      json['noDirectReplies'] as int?,
      (json['ancestors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['body'] as String,
      json['upvotes'] as int,
      json['downvotes'] as int,
      json['createdAt'] as String,
      json['editedAt'] as String?,
      json['deletedAt'] as String?,
      json['deletedBy'] as String?,
      json['deletedAs'] as String?,
      json['userVoted'] as bool?,
      json['userVotedUp'] as bool?,
      json['postDeleted'] as bool,
      json['postDeletedAs'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'postPublicId': instance.postPublicId,
      'communityId': instance.communityId,
      'communityName': instance.communityName,
      'userId': instance.userId,
      'username': instance.username,
      'userGroup': instance.userGroup,
      'author': instance.author,
      'userDeleted': instance.userDeleted,
      'parentId': instance.parentId,
      'depth': instance.depth,
      'noReplies': instance.noReplies,
      'noDirectReplies': instance.noDirectReplies,
      'ancestors': instance.ancestors,
      'body': instance.body,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'createdAt': instance.createdAt,
      'editedAt': instance.editedAt,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
      'deletedAs': instance.deletedAs,
      'userVoted': instance.userVoted,
      'userVotedUp': instance.userVotedUp,
      'postDeleted': instance.postDeleted,
      'postDeletedAs': instance.postDeletedAs,
    };
