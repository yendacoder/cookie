// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Post', json, ($checkedConvert) {
  final val = _Post(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert('type', (v) => v as String),
    publicId: $checkedConvert('publicId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
    userGhostId: $checkedConvert('userGhostId', (v) => v as String?),
    userGroup: $checkedConvert('userGroup', (v) => v as String),
    userDeleted: $checkedConvert('userDeleted', (v) => v as bool),
    isPinned: $checkedConvert('isPinned', (v) => v as bool),
    isPinnedSite: $checkedConvert('isPinnedSite', (v) => v as bool),
    communityId: $checkedConvert('communityId', (v) => v as String),
    communityName: $checkedConvert('communityName', (v) => v as String),
    communityProPic: $checkedConvert(
      'communityProPic',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    communityBannerImage: $checkedConvert(
      'communityBannerImage',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    title: $checkedConvert('title', (v) => v as String),
    body: $checkedConvert('body', (v) => v as String?),
    image: $checkedConvert(
      'image',
      (v) =>
          v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
    ),
    images: $checkedConvert(
      'images',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => DiscuitImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    link: $checkedConvert(
      'link',
      (v) => v == null ? null : PostLink.fromJson(v as Map<String, dynamic>),
    ),
    locked: $checkedConvert('locked', (v) => v as bool),
    lockedBy: $checkedConvert('lockedBy', (v) => v as String?),
    lockedByGroup: $checkedConvert('lockedByGroup', (v) => v as String?),
    lockedAt: $checkedConvert(
      'lockedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    upvotes: $checkedConvert('upvotes', (v) => (v as num).toInt()),
    downvotes: $checkedConvert('downvotes', (v) => (v as num).toInt()),
    hotness: $checkedConvert('hotness', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    editedAt: $checkedConvert(
      'editedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    lastActivityAt: $checkedConvert(
      'lastActivityAt',
      (v) => DateTime.parse(v as String),
    ),
    lastVisitAt: $checkedConvert(
      'lastVisitAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    deleted: $checkedConvert('deleted', (v) => v as bool),
    deletedAt: $checkedConvert(
      'deletedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    deletedBy: $checkedConvert('deletedBy', (v) => v as String?),
    deletedAs: $checkedConvert('deletedAs', (v) => v as String?),
    deletedContent: $checkedConvert('deletedContent', (v) => v as bool),
    deletedContentAs: $checkedConvert('deletedContentAs', (v) => v as String?),
    noComments: $checkedConvert('noComments', (v) => (v as num).toInt()),
    userVoted: $checkedConvert('userVoted', (v) => v as bool?),
    userVotedUp: $checkedConvert('userVotedUp', (v) => v as bool?),
    isAuthorMuted: $checkedConvert('isAuthorMuted', (v) => v as bool),
    isCommunityMuted: $checkedConvert('isCommunityMuted', (v) => v as bool),
    community: $checkedConvert(
      'community',
      (v) => v == null ? null : Community.fromJson(v as Map<String, dynamic>),
    ),
    author: $checkedConvert(
      'author',
      (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
    ),
    comments: $checkedConvert(
      'comments',
      (v) => (v as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    newComments: $checkedConvert('newComments', (v) => (v as num?)?.toInt()),
    commentsNext: $checkedConvert('commentsNext', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'publicId': instance.publicId,
  'userId': instance.userId,
  'username': instance.username,
  'userGhostId': instance.userGhostId,
  'userGroup': instance.userGroup,
  'userDeleted': instance.userDeleted,
  'isPinned': instance.isPinned,
  'isPinnedSite': instance.isPinnedSite,
  'communityId': instance.communityId,
  'communityName': instance.communityName,
  'communityProPic': instance.communityProPic,
  'communityBannerImage': instance.communityBannerImage,
  'title': instance.title,
  'body': instance.body,
  'image': instance.image,
  'images': instance.images,
  'link': instance.link,
  'locked': instance.locked,
  'lockedBy': instance.lockedBy,
  'lockedByGroup': instance.lockedByGroup,
  'lockedAt': instance.lockedAt?.toIso8601String(),
  'upvotes': instance.upvotes,
  'downvotes': instance.downvotes,
  'hotness': instance.hotness,
  'createdAt': instance.createdAt.toIso8601String(),
  'editedAt': instance.editedAt?.toIso8601String(),
  'lastActivityAt': instance.lastActivityAt.toIso8601String(),
  'lastVisitAt': instance.lastVisitAt?.toIso8601String(),
  'deleted': instance.deleted,
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'deletedBy': instance.deletedBy,
  'deletedAs': instance.deletedAs,
  'deletedContent': instance.deletedContent,
  'deletedContentAs': instance.deletedContentAs,
  'noComments': instance.noComments,
  'userVoted': instance.userVoted,
  'userVotedUp': instance.userVotedUp,
  'isAuthorMuted': instance.isAuthorMuted,
  'isCommunityMuted': instance.isCommunityMuted,
  'community': instance.community,
  'author': instance.author,
  'comments': instance.comments,
  'newComments': instance.newComments,
  'commentsNext': instance.commentsNext,
};

_PostLink _$PostLinkFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_PostLink',
  json,
  ($checkedConvert) {
    final val = _PostLink(
      url: $checkedConvert('url', (v) => v as String),
      hostname: $checkedConvert('hostname', (v) => v as String),
      image: $checkedConvert(
        'image',
        (v) =>
            v == null ? null : DiscuitImage.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$PostLinkToJson(_PostLink instance) => <String, dynamic>{
  'url': instance.url,
  'hostname': instance.hostname,
  'image': instance.image,
};
