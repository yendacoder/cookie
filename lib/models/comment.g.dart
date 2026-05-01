// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Comment', json, ($checkedConvert) {
      final val = _Comment(
        id: $checkedConvert('id', (v) => v as String),
        postId: $checkedConvert('postId', (v) => v as String),
        postPublicId: $checkedConvert('postPublicId', (v) => v as String),
        communityId: $checkedConvert('communityId', (v) => v as String),
        communityName: $checkedConvert('communityName', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String?),
        username: $checkedConvert('username', (v) => v as String),
        userGhostId: $checkedConvert('userGhostId', (v) => v as String?),
        userGroup: $checkedConvert('userGroup', (v) => v as String),
        userDeleted: $checkedConvert('userDeleted', (v) => v as bool),
        parentId: $checkedConvert('parentId', (v) => v as String?),
        depth: $checkedConvert('depth', (v) => (v as num).toInt()),
        noReplies: $checkedConvert('noReplies', (v) => (v as num).toInt()),
        noDirectReplies: $checkedConvert(
          'noDirectReplies',
          (v) => (v as num).toInt(),
        ),
        ancestors: $checkedConvert(
          'ancestors',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        body: $checkedConvert('body', (v) => v as String),
        upvotes: $checkedConvert('upvotes', (v) => (v as num).toInt()),
        downvotes: $checkedConvert('downvotes', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        editedAt: $checkedConvert(
          'editedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        contentStripped: $checkedConvert('contentStripped', (v) => v as bool?),
        deleted: $checkedConvert('deleted', (v) => v as bool),
        deletedAt: $checkedConvert(
          'deletedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        deletedAs: $checkedConvert('deletedAs', (v) => v as String?),
        author: $checkedConvert(
          'author',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
        isAuthorMuted: $checkedConvert('isAuthorMuted', (v) => v as bool?),
        userVoted: $checkedConvert('userVoted', (v) => v as bool?),
        userVotedUp: $checkedConvert('userVotedUp', (v) => v as bool?),
        postTitle: $checkedConvert('postTitle', (v) => v as String?),
        postDeleted: $checkedConvert('postDeleted', (v) => v as bool),
        postDeletedAs: $checkedConvert('postDeletedAs', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'postPublicId': instance.postPublicId,
  'communityId': instance.communityId,
  'communityName': instance.communityName,
  'userId': instance.userId,
  'username': instance.username,
  'userGhostId': instance.userGhostId,
  'userGroup': instance.userGroup,
  'userDeleted': instance.userDeleted,
  'parentId': instance.parentId,
  'depth': instance.depth,
  'noReplies': instance.noReplies,
  'noDirectReplies': instance.noDirectReplies,
  'ancestors': instance.ancestors,
  'body': instance.body,
  'upvotes': instance.upvotes,
  'downvotes': instance.downvotes,
  'createdAt': instance.createdAt.toIso8601String(),
  'editedAt': instance.editedAt?.toIso8601String(),
  'contentStripped': instance.contentStripped,
  'deleted': instance.deleted,
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'deletedAs': instance.deletedAs,
  'author': instance.author,
  'isAuthorMuted': instance.isAuthorMuted,
  'userVoted': instance.userVoted,
  'userVotedUp': instance.userVotedUp,
  'postTitle': instance.postTitle,
  'postDeleted': instance.postDeleted,
  'postDeletedAs': instance.postDeletedAs,
};
