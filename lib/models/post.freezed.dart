// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

 String get id; String get type; String get publicId; String get userId; String get username; String? get userGhostId; String get userGroup; bool get userDeleted; bool get isPinned; bool get isPinnedSite; String get communityId; String get communityName; DiscuitImage? get communityProPic; DiscuitImage? get communityBannerImage; String get title; String? get body; DiscuitImage? get image; List<DiscuitImage> get images; PostLink? get link; bool get locked; String? get lockedBy; String? get lockedByGroup; DateTime? get lockedAt; int get upvotes; int get downvotes; int get hotness; DateTime get createdAt; DateTime? get editedAt; DateTime get lastActivityAt; bool get deleted; DateTime? get deletedAt; String? get deletedBy; String? get deletedAs; bool get deletedContent; String? get deletedContentAs; int get noComments; bool? get userVoted; bool? get userVotedUp; bool get isAuthorMuted; bool get isCommunityMuted; Community? get community; User? get author; List<Comment>? get comments; String? get commentsNext;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.userGhostId, userGhostId) || other.userGhostId == userGhostId)&&(identical(other.userGroup, userGroup) || other.userGroup == userGroup)&&(identical(other.userDeleted, userDeleted) || other.userDeleted == userDeleted)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isPinnedSite, isPinnedSite) || other.isPinnedSite == isPinnedSite)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.communityProPic, communityProPic) || other.communityProPic == communityProPic)&&(identical(other.communityBannerImage, communityBannerImage) || other.communityBannerImage == communityBannerImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.link, link) || other.link == link)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedByGroup, lockedByGroup) || other.lockedByGroup == lockedByGroup)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&(identical(other.hotness, hotness) || other.hotness == hotness)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.deletedBy, deletedBy) || other.deletedBy == deletedBy)&&(identical(other.deletedAs, deletedAs) || other.deletedAs == deletedAs)&&(identical(other.deletedContent, deletedContent) || other.deletedContent == deletedContent)&&(identical(other.deletedContentAs, deletedContentAs) || other.deletedContentAs == deletedContentAs)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.userVoted, userVoted) || other.userVoted == userVoted)&&(identical(other.userVotedUp, userVotedUp) || other.userVotedUp == userVotedUp)&&(identical(other.isAuthorMuted, isAuthorMuted) || other.isAuthorMuted == isAuthorMuted)&&(identical(other.isCommunityMuted, isCommunityMuted) || other.isCommunityMuted == isCommunityMuted)&&(identical(other.community, community) || other.community == community)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.commentsNext, commentsNext) || other.commentsNext == commentsNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,publicId,userId,username,userGhostId,userGroup,userDeleted,isPinned,isPinnedSite,communityId,communityName,communityProPic,communityBannerImage,title,body,image,const DeepCollectionEquality().hash(images),link,locked,lockedBy,lockedByGroup,lockedAt,upvotes,downvotes,hotness,createdAt,editedAt,lastActivityAt,deleted,deletedAt,deletedBy,deletedAs,deletedContent,deletedContentAs,noComments,userVoted,userVotedUp,isAuthorMuted,isCommunityMuted,community,author,const DeepCollectionEquality().hash(comments),commentsNext]);

@override
String toString() {
  return 'Post(id: $id, type: $type, publicId: $publicId, userId: $userId, username: $username, userGhostId: $userGhostId, userGroup: $userGroup, userDeleted: $userDeleted, isPinned: $isPinned, isPinnedSite: $isPinnedSite, communityId: $communityId, communityName: $communityName, communityProPic: $communityProPic, communityBannerImage: $communityBannerImage, title: $title, body: $body, image: $image, images: $images, link: $link, locked: $locked, lockedBy: $lockedBy, lockedByGroup: $lockedByGroup, lockedAt: $lockedAt, upvotes: $upvotes, downvotes: $downvotes, hotness: $hotness, createdAt: $createdAt, editedAt: $editedAt, lastActivityAt: $lastActivityAt, deleted: $deleted, deletedAt: $deletedAt, deletedBy: $deletedBy, deletedAs: $deletedAs, deletedContent: $deletedContent, deletedContentAs: $deletedContentAs, noComments: $noComments, userVoted: $userVoted, userVotedUp: $userVotedUp, isAuthorMuted: $isAuthorMuted, isCommunityMuted: $isCommunityMuted, community: $community, author: $author, comments: $comments, commentsNext: $commentsNext)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String id, String type, String publicId, String userId, String username, String? userGhostId, String userGroup, bool userDeleted, bool isPinned, bool isPinnedSite, String communityId, String communityName, DiscuitImage? communityProPic, DiscuitImage? communityBannerImage, String title, String? body, DiscuitImage? image, List<DiscuitImage> images, PostLink? link, bool locked, String? lockedBy, String? lockedByGroup, DateTime? lockedAt, int upvotes, int downvotes, int hotness, DateTime createdAt, DateTime? editedAt, DateTime lastActivityAt, bool deleted, DateTime? deletedAt, String? deletedBy, String? deletedAs, bool deletedContent, String? deletedContentAs, int noComments, bool? userVoted, bool? userVotedUp, bool isAuthorMuted, bool isCommunityMuted, Community? community, User? author, List<Comment>? comments, String? commentsNext
});


$DiscuitImageCopyWith<$Res>? get communityProPic;$DiscuitImageCopyWith<$Res>? get communityBannerImage;$DiscuitImageCopyWith<$Res>? get image;$PostLinkCopyWith<$Res>? get link;$CommunityCopyWith<$Res>? get community;$UserCopyWith<$Res>? get author;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? publicId = null,Object? userId = null,Object? username = null,Object? userGhostId = freezed,Object? userGroup = null,Object? userDeleted = null,Object? isPinned = null,Object? isPinnedSite = null,Object? communityId = null,Object? communityName = null,Object? communityProPic = freezed,Object? communityBannerImage = freezed,Object? title = null,Object? body = freezed,Object? image = freezed,Object? images = null,Object? link = freezed,Object? locked = null,Object? lockedBy = freezed,Object? lockedByGroup = freezed,Object? lockedAt = freezed,Object? upvotes = null,Object? downvotes = null,Object? hotness = null,Object? createdAt = null,Object? editedAt = freezed,Object? lastActivityAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? deletedBy = freezed,Object? deletedAs = freezed,Object? deletedContent = null,Object? deletedContentAs = freezed,Object? noComments = null,Object? userVoted = freezed,Object? userVotedUp = freezed,Object? isAuthorMuted = null,Object? isCommunityMuted = null,Object? community = freezed,Object? author = freezed,Object? comments = freezed,Object? commentsNext = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,publicId: null == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userGhostId: freezed == userGhostId ? _self.userGhostId : userGhostId // ignore: cast_nullable_to_non_nullable
as String?,userGroup: null == userGroup ? _self.userGroup : userGroup // ignore: cast_nullable_to_non_nullable
as String,userDeleted: null == userDeleted ? _self.userDeleted : userDeleted // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isPinnedSite: null == isPinnedSite ? _self.isPinnedSite : isPinnedSite // ignore: cast_nullable_to_non_nullable
as bool,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,communityProPic: freezed == communityProPic ? _self.communityProPic : communityProPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,communityBannerImage: freezed == communityBannerImage ? _self.communityBannerImage : communityBannerImage // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<DiscuitImage>,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as PostLink?,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedByGroup: freezed == lockedByGroup ? _self.lockedByGroup : lockedByGroup // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,hotness: null == hotness ? _self.hotness : hotness // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActivityAt: null == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedBy: freezed == deletedBy ? _self.deletedBy : deletedBy // ignore: cast_nullable_to_non_nullable
as String?,deletedAs: freezed == deletedAs ? _self.deletedAs : deletedAs // ignore: cast_nullable_to_non_nullable
as String?,deletedContent: null == deletedContent ? _self.deletedContent : deletedContent // ignore: cast_nullable_to_non_nullable
as bool,deletedContentAs: freezed == deletedContentAs ? _self.deletedContentAs : deletedContentAs // ignore: cast_nullable_to_non_nullable
as String?,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,userVoted: freezed == userVoted ? _self.userVoted : userVoted // ignore: cast_nullable_to_non_nullable
as bool?,userVotedUp: freezed == userVotedUp ? _self.userVotedUp : userVotedUp // ignore: cast_nullable_to_non_nullable
as bool?,isAuthorMuted: null == isAuthorMuted ? _self.isAuthorMuted : isAuthorMuted // ignore: cast_nullable_to_non_nullable
as bool,isCommunityMuted: null == isCommunityMuted ? _self.isCommunityMuted : isCommunityMuted // ignore: cast_nullable_to_non_nullable
as bool,community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as Community?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>?,commentsNext: freezed == commentsNext ? _self.commentsNext : commentsNext // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get communityProPic {
    if (_self.communityProPic == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.communityProPic!, (value) {
    return _then(_self.copyWith(communityProPic: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get communityBannerImage {
    if (_self.communityBannerImage == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.communityBannerImage!, (value) {
    return _then(_self.copyWith(communityBannerImage: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $PostLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityCopyWith<$Res>? get community {
    if (_self.community == null) {
    return null;
  }

  return $CommunityCopyWith<$Res>(_self.community!, (value) {
    return _then(_self.copyWith(community: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String publicId,  String userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  bool isPinned,  bool isPinnedSite,  String communityId,  String communityName,  DiscuitImage? communityProPic,  DiscuitImage? communityBannerImage,  String title,  String? body,  DiscuitImage? image,  List<DiscuitImage> images,  PostLink? link,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  int upvotes,  int downvotes,  int hotness,  DateTime createdAt,  DateTime? editedAt,  DateTime lastActivityAt,  bool deleted,  DateTime? deletedAt,  String? deletedBy,  String? deletedAs,  bool deletedContent,  String? deletedContentAs,  int noComments,  bool? userVoted,  bool? userVotedUp,  bool isAuthorMuted,  bool isCommunityMuted,  Community? community,  User? author,  List<Comment>? comments,  String? commentsNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.type,_that.publicId,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.isPinned,_that.isPinnedSite,_that.communityId,_that.communityName,_that.communityProPic,_that.communityBannerImage,_that.title,_that.body,_that.image,_that.images,_that.link,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.upvotes,_that.downvotes,_that.hotness,_that.createdAt,_that.editedAt,_that.lastActivityAt,_that.deleted,_that.deletedAt,_that.deletedBy,_that.deletedAs,_that.deletedContent,_that.deletedContentAs,_that.noComments,_that.userVoted,_that.userVotedUp,_that.isAuthorMuted,_that.isCommunityMuted,_that.community,_that.author,_that.comments,_that.commentsNext);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String publicId,  String userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  bool isPinned,  bool isPinnedSite,  String communityId,  String communityName,  DiscuitImage? communityProPic,  DiscuitImage? communityBannerImage,  String title,  String? body,  DiscuitImage? image,  List<DiscuitImage> images,  PostLink? link,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  int upvotes,  int downvotes,  int hotness,  DateTime createdAt,  DateTime? editedAt,  DateTime lastActivityAt,  bool deleted,  DateTime? deletedAt,  String? deletedBy,  String? deletedAs,  bool deletedContent,  String? deletedContentAs,  int noComments,  bool? userVoted,  bool? userVotedUp,  bool isAuthorMuted,  bool isCommunityMuted,  Community? community,  User? author,  List<Comment>? comments,  String? commentsNext)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.type,_that.publicId,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.isPinned,_that.isPinnedSite,_that.communityId,_that.communityName,_that.communityProPic,_that.communityBannerImage,_that.title,_that.body,_that.image,_that.images,_that.link,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.upvotes,_that.downvotes,_that.hotness,_that.createdAt,_that.editedAt,_that.lastActivityAt,_that.deleted,_that.deletedAt,_that.deletedBy,_that.deletedAs,_that.deletedContent,_that.deletedContentAs,_that.noComments,_that.userVoted,_that.userVotedUp,_that.isAuthorMuted,_that.isCommunityMuted,_that.community,_that.author,_that.comments,_that.commentsNext);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String publicId,  String userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  bool isPinned,  bool isPinnedSite,  String communityId,  String communityName,  DiscuitImage? communityProPic,  DiscuitImage? communityBannerImage,  String title,  String? body,  DiscuitImage? image,  List<DiscuitImage> images,  PostLink? link,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  int upvotes,  int downvotes,  int hotness,  DateTime createdAt,  DateTime? editedAt,  DateTime lastActivityAt,  bool deleted,  DateTime? deletedAt,  String? deletedBy,  String? deletedAs,  bool deletedContent,  String? deletedContentAs,  int noComments,  bool? userVoted,  bool? userVotedUp,  bool isAuthorMuted,  bool isCommunityMuted,  Community? community,  User? author,  List<Comment>? comments,  String? commentsNext)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.type,_that.publicId,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.isPinned,_that.isPinnedSite,_that.communityId,_that.communityName,_that.communityProPic,_that.communityBannerImage,_that.title,_that.body,_that.image,_that.images,_that.link,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.upvotes,_that.downvotes,_that.hotness,_that.createdAt,_that.editedAt,_that.lastActivityAt,_that.deleted,_that.deletedAt,_that.deletedBy,_that.deletedAs,_that.deletedContent,_that.deletedContentAs,_that.noComments,_that.userVoted,_that.userVotedUp,_that.isAuthorMuted,_that.isCommunityMuted,_that.community,_that.author,_that.comments,_that.commentsNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({required this.id, required this.type, required this.publicId, required this.userId, required this.username, this.userGhostId, required this.userGroup, required this.userDeleted, required this.isPinned, required this.isPinnedSite, required this.communityId, required this.communityName, this.communityProPic, this.communityBannerImage, required this.title, this.body, this.image, final  List<DiscuitImage> images = const [], this.link, required this.locked, this.lockedBy, this.lockedByGroup, this.lockedAt, required this.upvotes, required this.downvotes, required this.hotness, required this.createdAt, this.editedAt, required this.lastActivityAt, required this.deleted, this.deletedAt, this.deletedBy, this.deletedAs, required this.deletedContent, this.deletedContentAs, required this.noComments, this.userVoted, this.userVotedUp, required this.isAuthorMuted, required this.isCommunityMuted, this.community, this.author, final  List<Comment>? comments, this.commentsNext}): _images = images,_comments = comments;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String id;
@override final  String type;
@override final  String publicId;
@override final  String userId;
@override final  String username;
@override final  String? userGhostId;
@override final  String userGroup;
@override final  bool userDeleted;
@override final  bool isPinned;
@override final  bool isPinnedSite;
@override final  String communityId;
@override final  String communityName;
@override final  DiscuitImage? communityProPic;
@override final  DiscuitImage? communityBannerImage;
@override final  String title;
@override final  String? body;
@override final  DiscuitImage? image;
 final  List<DiscuitImage> _images;
@override@JsonKey() List<DiscuitImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  PostLink? link;
@override final  bool locked;
@override final  String? lockedBy;
@override final  String? lockedByGroup;
@override final  DateTime? lockedAt;
@override final  int upvotes;
@override final  int downvotes;
@override final  int hotness;
@override final  DateTime createdAt;
@override final  DateTime? editedAt;
@override final  DateTime lastActivityAt;
@override final  bool deleted;
@override final  DateTime? deletedAt;
@override final  String? deletedBy;
@override final  String? deletedAs;
@override final  bool deletedContent;
@override final  String? deletedContentAs;
@override final  int noComments;
@override final  bool? userVoted;
@override final  bool? userVotedUp;
@override final  bool isAuthorMuted;
@override final  bool isCommunityMuted;
@override final  Community? community;
@override final  User? author;
 final  List<Comment>? _comments;
@override List<Comment>? get comments {
  final value = _comments;
  if (value == null) return null;
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? commentsNext;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.userGhostId, userGhostId) || other.userGhostId == userGhostId)&&(identical(other.userGroup, userGroup) || other.userGroup == userGroup)&&(identical(other.userDeleted, userDeleted) || other.userDeleted == userDeleted)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isPinnedSite, isPinnedSite) || other.isPinnedSite == isPinnedSite)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.communityProPic, communityProPic) || other.communityProPic == communityProPic)&&(identical(other.communityBannerImage, communityBannerImage) || other.communityBannerImage == communityBannerImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.link, link) || other.link == link)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedByGroup, lockedByGroup) || other.lockedByGroup == lockedByGroup)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&(identical(other.hotness, hotness) || other.hotness == hotness)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.deletedBy, deletedBy) || other.deletedBy == deletedBy)&&(identical(other.deletedAs, deletedAs) || other.deletedAs == deletedAs)&&(identical(other.deletedContent, deletedContent) || other.deletedContent == deletedContent)&&(identical(other.deletedContentAs, deletedContentAs) || other.deletedContentAs == deletedContentAs)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.userVoted, userVoted) || other.userVoted == userVoted)&&(identical(other.userVotedUp, userVotedUp) || other.userVotedUp == userVotedUp)&&(identical(other.isAuthorMuted, isAuthorMuted) || other.isAuthorMuted == isAuthorMuted)&&(identical(other.isCommunityMuted, isCommunityMuted) || other.isCommunityMuted == isCommunityMuted)&&(identical(other.community, community) || other.community == community)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.commentsNext, commentsNext) || other.commentsNext == commentsNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,publicId,userId,username,userGhostId,userGroup,userDeleted,isPinned,isPinnedSite,communityId,communityName,communityProPic,communityBannerImage,title,body,image,const DeepCollectionEquality().hash(_images),link,locked,lockedBy,lockedByGroup,lockedAt,upvotes,downvotes,hotness,createdAt,editedAt,lastActivityAt,deleted,deletedAt,deletedBy,deletedAs,deletedContent,deletedContentAs,noComments,userVoted,userVotedUp,isAuthorMuted,isCommunityMuted,community,author,const DeepCollectionEquality().hash(_comments),commentsNext]);

@override
String toString() {
  return 'Post(id: $id, type: $type, publicId: $publicId, userId: $userId, username: $username, userGhostId: $userGhostId, userGroup: $userGroup, userDeleted: $userDeleted, isPinned: $isPinned, isPinnedSite: $isPinnedSite, communityId: $communityId, communityName: $communityName, communityProPic: $communityProPic, communityBannerImage: $communityBannerImage, title: $title, body: $body, image: $image, images: $images, link: $link, locked: $locked, lockedBy: $lockedBy, lockedByGroup: $lockedByGroup, lockedAt: $lockedAt, upvotes: $upvotes, downvotes: $downvotes, hotness: $hotness, createdAt: $createdAt, editedAt: $editedAt, lastActivityAt: $lastActivityAt, deleted: $deleted, deletedAt: $deletedAt, deletedBy: $deletedBy, deletedAs: $deletedAs, deletedContent: $deletedContent, deletedContentAs: $deletedContentAs, noComments: $noComments, userVoted: $userVoted, userVotedUp: $userVotedUp, isAuthorMuted: $isAuthorMuted, isCommunityMuted: $isCommunityMuted, community: $community, author: $author, comments: $comments, commentsNext: $commentsNext)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String publicId, String userId, String username, String? userGhostId, String userGroup, bool userDeleted, bool isPinned, bool isPinnedSite, String communityId, String communityName, DiscuitImage? communityProPic, DiscuitImage? communityBannerImage, String title, String? body, DiscuitImage? image, List<DiscuitImage> images, PostLink? link, bool locked, String? lockedBy, String? lockedByGroup, DateTime? lockedAt, int upvotes, int downvotes, int hotness, DateTime createdAt, DateTime? editedAt, DateTime lastActivityAt, bool deleted, DateTime? deletedAt, String? deletedBy, String? deletedAs, bool deletedContent, String? deletedContentAs, int noComments, bool? userVoted, bool? userVotedUp, bool isAuthorMuted, bool isCommunityMuted, Community? community, User? author, List<Comment>? comments, String? commentsNext
});


@override $DiscuitImageCopyWith<$Res>? get communityProPic;@override $DiscuitImageCopyWith<$Res>? get communityBannerImage;@override $DiscuitImageCopyWith<$Res>? get image;@override $PostLinkCopyWith<$Res>? get link;@override $CommunityCopyWith<$Res>? get community;@override $UserCopyWith<$Res>? get author;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? publicId = null,Object? userId = null,Object? username = null,Object? userGhostId = freezed,Object? userGroup = null,Object? userDeleted = null,Object? isPinned = null,Object? isPinnedSite = null,Object? communityId = null,Object? communityName = null,Object? communityProPic = freezed,Object? communityBannerImage = freezed,Object? title = null,Object? body = freezed,Object? image = freezed,Object? images = null,Object? link = freezed,Object? locked = null,Object? lockedBy = freezed,Object? lockedByGroup = freezed,Object? lockedAt = freezed,Object? upvotes = null,Object? downvotes = null,Object? hotness = null,Object? createdAt = null,Object? editedAt = freezed,Object? lastActivityAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? deletedBy = freezed,Object? deletedAs = freezed,Object? deletedContent = null,Object? deletedContentAs = freezed,Object? noComments = null,Object? userVoted = freezed,Object? userVotedUp = freezed,Object? isAuthorMuted = null,Object? isCommunityMuted = null,Object? community = freezed,Object? author = freezed,Object? comments = freezed,Object? commentsNext = freezed,}) {
  return _then(_Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,publicId: null == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userGhostId: freezed == userGhostId ? _self.userGhostId : userGhostId // ignore: cast_nullable_to_non_nullable
as String?,userGroup: null == userGroup ? _self.userGroup : userGroup // ignore: cast_nullable_to_non_nullable
as String,userDeleted: null == userDeleted ? _self.userDeleted : userDeleted // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isPinnedSite: null == isPinnedSite ? _self.isPinnedSite : isPinnedSite // ignore: cast_nullable_to_non_nullable
as bool,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,communityProPic: freezed == communityProPic ? _self.communityProPic : communityProPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,communityBannerImage: freezed == communityBannerImage ? _self.communityBannerImage : communityBannerImage // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<DiscuitImage>,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as PostLink?,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedByGroup: freezed == lockedByGroup ? _self.lockedByGroup : lockedByGroup // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,hotness: null == hotness ? _self.hotness : hotness // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActivityAt: null == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedBy: freezed == deletedBy ? _self.deletedBy : deletedBy // ignore: cast_nullable_to_non_nullable
as String?,deletedAs: freezed == deletedAs ? _self.deletedAs : deletedAs // ignore: cast_nullable_to_non_nullable
as String?,deletedContent: null == deletedContent ? _self.deletedContent : deletedContent // ignore: cast_nullable_to_non_nullable
as bool,deletedContentAs: freezed == deletedContentAs ? _self.deletedContentAs : deletedContentAs // ignore: cast_nullable_to_non_nullable
as String?,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,userVoted: freezed == userVoted ? _self.userVoted : userVoted // ignore: cast_nullable_to_non_nullable
as bool?,userVotedUp: freezed == userVotedUp ? _self.userVotedUp : userVotedUp // ignore: cast_nullable_to_non_nullable
as bool?,isAuthorMuted: null == isAuthorMuted ? _self.isAuthorMuted : isAuthorMuted // ignore: cast_nullable_to_non_nullable
as bool,isCommunityMuted: null == isCommunityMuted ? _self.isCommunityMuted : isCommunityMuted // ignore: cast_nullable_to_non_nullable
as bool,community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as Community?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User?,comments: freezed == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>?,commentsNext: freezed == commentsNext ? _self.commentsNext : commentsNext // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get communityProPic {
    if (_self.communityProPic == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.communityProPic!, (value) {
    return _then(_self.copyWith(communityProPic: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get communityBannerImage {
    if (_self.communityBannerImage == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.communityBannerImage!, (value) {
    return _then(_self.copyWith(communityBannerImage: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $PostLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityCopyWith<$Res>? get community {
    if (_self.community == null) {
    return null;
  }

  return $CommunityCopyWith<$Res>(_self.community!, (value) {
    return _then(_self.copyWith(community: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$PostLink {

 String get url; String get hostname; DiscuitImage? get image;
/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLinkCopyWith<PostLink> get copyWith => _$PostLinkCopyWithImpl<PostLink>(this as PostLink, _$identity);

  /// Serializes this PostLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLink&&(identical(other.url, url) || other.url == url)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,hostname,image);

@override
String toString() {
  return 'PostLink(url: $url, hostname: $hostname, image: $image)';
}


}

/// @nodoc
abstract mixin class $PostLinkCopyWith<$Res>  {
  factory $PostLinkCopyWith(PostLink value, $Res Function(PostLink) _then) = _$PostLinkCopyWithImpl;
@useResult
$Res call({
 String url, String hostname, DiscuitImage? image
});


$DiscuitImageCopyWith<$Res>? get image;

}
/// @nodoc
class _$PostLinkCopyWithImpl<$Res>
    implements $PostLinkCopyWith<$Res> {
  _$PostLinkCopyWithImpl(this._self, this._then);

  final PostLink _self;
  final $Res Function(PostLink) _then;

/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? hostname = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,
  ));
}
/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostLink].
extension PostLinkPatterns on PostLink {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostLink() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostLink value)  $default,){
final _that = this;
switch (_that) {
case _PostLink():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostLink value)?  $default,){
final _that = this;
switch (_that) {
case _PostLink() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String hostname,  DiscuitImage? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostLink() when $default != null:
return $default(_that.url,_that.hostname,_that.image);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String hostname,  DiscuitImage? image)  $default,) {final _that = this;
switch (_that) {
case _PostLink():
return $default(_that.url,_that.hostname,_that.image);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String hostname,  DiscuitImage? image)?  $default,) {final _that = this;
switch (_that) {
case _PostLink() when $default != null:
return $default(_that.url,_that.hostname,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostLink implements PostLink {
  const _PostLink({required this.url, required this.hostname, this.image});
  factory _PostLink.fromJson(Map<String, dynamic> json) => _$PostLinkFromJson(json);

@override final  String url;
@override final  String hostname;
@override final  DiscuitImage? image;

/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostLinkCopyWith<_PostLink> get copyWith => __$PostLinkCopyWithImpl<_PostLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostLink&&(identical(other.url, url) || other.url == url)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,hostname,image);

@override
String toString() {
  return 'PostLink(url: $url, hostname: $hostname, image: $image)';
}


}

/// @nodoc
abstract mixin class _$PostLinkCopyWith<$Res> implements $PostLinkCopyWith<$Res> {
  factory _$PostLinkCopyWith(_PostLink value, $Res Function(_PostLink) _then) = __$PostLinkCopyWithImpl;
@override @useResult
$Res call({
 String url, String hostname, DiscuitImage? image
});


@override $DiscuitImageCopyWith<$Res>? get image;

}
/// @nodoc
class __$PostLinkCopyWithImpl<$Res>
    implements _$PostLinkCopyWith<$Res> {
  __$PostLinkCopyWithImpl(this._self, this._then);

  final _PostLink _self;
  final $Res Function(_PostLink) _then;

/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? hostname = null,Object? image = freezed,}) {
  return _then(_PostLink(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,
  ));
}

/// Create a copy of PostLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}

// dart format on
