// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comment {

 String get id; String get postId; String get postPublicId; String get communityId; String get communityName; String? get userId; String get username; String? get userGhostId; String get userGroup; bool get userDeleted; String? get parentId; int get depth; int get noReplies; int? get noDirectReplies; List<String>? get ancestors; String get body; int get upvotes; int get downvotes; DateTime get createdAt; DateTime? get editedAt; bool? get contentStripped; bool get locked; String? get lockedBy; String? get lockedByGroup; DateTime? get lockedAt; bool get deleted; DateTime? get deletedAt; String? get deletedAs; User? get author; bool? get isAuthorMuted; bool? get userVoted; bool? get userVotedUp; String? get postTitle; bool get postDeleted; String? get postDeletedAs;
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCopyWith<Comment> get copyWith => _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.postPublicId, postPublicId) || other.postPublicId == postPublicId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.userGhostId, userGhostId) || other.userGhostId == userGhostId)&&(identical(other.userGroup, userGroup) || other.userGroup == userGroup)&&(identical(other.userDeleted, userDeleted) || other.userDeleted == userDeleted)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.noReplies, noReplies) || other.noReplies == noReplies)&&(identical(other.noDirectReplies, noDirectReplies) || other.noDirectReplies == noDirectReplies)&&const DeepCollectionEquality().equals(other.ancestors, ancestors)&&(identical(other.body, body) || other.body == body)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.contentStripped, contentStripped) || other.contentStripped == contentStripped)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedByGroup, lockedByGroup) || other.lockedByGroup == lockedByGroup)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.deletedAs, deletedAs) || other.deletedAs == deletedAs)&&(identical(other.author, author) || other.author == author)&&(identical(other.isAuthorMuted, isAuthorMuted) || other.isAuthorMuted == isAuthorMuted)&&(identical(other.userVoted, userVoted) || other.userVoted == userVoted)&&(identical(other.userVotedUp, userVotedUp) || other.userVotedUp == userVotedUp)&&(identical(other.postTitle, postTitle) || other.postTitle == postTitle)&&(identical(other.postDeleted, postDeleted) || other.postDeleted == postDeleted)&&(identical(other.postDeletedAs, postDeletedAs) || other.postDeletedAs == postDeletedAs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,postId,postPublicId,communityId,communityName,userId,username,userGhostId,userGroup,userDeleted,parentId,depth,noReplies,noDirectReplies,const DeepCollectionEquality().hash(ancestors),body,upvotes,downvotes,createdAt,editedAt,contentStripped,locked,lockedBy,lockedByGroup,lockedAt,deleted,deletedAt,deletedAs,author,isAuthorMuted,userVoted,userVotedUp,postTitle,postDeleted,postDeletedAs]);

@override
String toString() {
  return 'Comment(id: $id, postId: $postId, postPublicId: $postPublicId, communityId: $communityId, communityName: $communityName, userId: $userId, username: $username, userGhostId: $userGhostId, userGroup: $userGroup, userDeleted: $userDeleted, parentId: $parentId, depth: $depth, noReplies: $noReplies, noDirectReplies: $noDirectReplies, ancestors: $ancestors, body: $body, upvotes: $upvotes, downvotes: $downvotes, createdAt: $createdAt, editedAt: $editedAt, contentStripped: $contentStripped, locked: $locked, lockedBy: $lockedBy, lockedByGroup: $lockedByGroup, lockedAt: $lockedAt, deleted: $deleted, deletedAt: $deletedAt, deletedAs: $deletedAs, author: $author, isAuthorMuted: $isAuthorMuted, userVoted: $userVoted, userVotedUp: $userVotedUp, postTitle: $postTitle, postDeleted: $postDeleted, postDeletedAs: $postDeletedAs)';
}


}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res>  {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) = _$CommentCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String postPublicId, String communityId, String communityName, String? userId, String username, String? userGhostId, String userGroup, bool userDeleted, String? parentId, int depth, int noReplies, int? noDirectReplies, List<String>? ancestors, String body, int upvotes, int downvotes, DateTime createdAt, DateTime? editedAt, bool? contentStripped, bool locked, String? lockedBy, String? lockedByGroup, DateTime? lockedAt, bool deleted, DateTime? deletedAt, String? deletedAs, User? author, bool? isAuthorMuted, bool? userVoted, bool? userVotedUp, String? postTitle, bool postDeleted, String? postDeletedAs
});


$UserCopyWith<$Res>? get author;

}
/// @nodoc
class _$CommentCopyWithImpl<$Res>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? postPublicId = null,Object? communityId = null,Object? communityName = null,Object? userId = freezed,Object? username = null,Object? userGhostId = freezed,Object? userGroup = null,Object? userDeleted = null,Object? parentId = freezed,Object? depth = null,Object? noReplies = null,Object? noDirectReplies = freezed,Object? ancestors = freezed,Object? body = null,Object? upvotes = null,Object? downvotes = null,Object? createdAt = null,Object? editedAt = freezed,Object? contentStripped = freezed,Object? locked = null,Object? lockedBy = freezed,Object? lockedByGroup = freezed,Object? lockedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? deletedAs = freezed,Object? author = freezed,Object? isAuthorMuted = freezed,Object? userVoted = freezed,Object? userVotedUp = freezed,Object? postTitle = freezed,Object? postDeleted = null,Object? postDeletedAs = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,postPublicId: null == postPublicId ? _self.postPublicId : postPublicId // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userGhostId: freezed == userGhostId ? _self.userGhostId : userGhostId // ignore: cast_nullable_to_non_nullable
as String?,userGroup: null == userGroup ? _self.userGroup : userGroup // ignore: cast_nullable_to_non_nullable
as String,userDeleted: null == userDeleted ? _self.userDeleted : userDeleted // ignore: cast_nullable_to_non_nullable
as bool,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,noReplies: null == noReplies ? _self.noReplies : noReplies // ignore: cast_nullable_to_non_nullable
as int,noDirectReplies: freezed == noDirectReplies ? _self.noDirectReplies : noDirectReplies // ignore: cast_nullable_to_non_nullable
as int?,ancestors: freezed == ancestors ? _self.ancestors : ancestors // ignore: cast_nullable_to_non_nullable
as List<String>?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,contentStripped: freezed == contentStripped ? _self.contentStripped : contentStripped // ignore: cast_nullable_to_non_nullable
as bool?,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedByGroup: freezed == lockedByGroup ? _self.lockedByGroup : lockedByGroup // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAs: freezed == deletedAs ? _self.deletedAs : deletedAs // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User?,isAuthorMuted: freezed == isAuthorMuted ? _self.isAuthorMuted : isAuthorMuted // ignore: cast_nullable_to_non_nullable
as bool?,userVoted: freezed == userVoted ? _self.userVoted : userVoted // ignore: cast_nullable_to_non_nullable
as bool?,userVotedUp: freezed == userVotedUp ? _self.userVotedUp : userVotedUp // ignore: cast_nullable_to_non_nullable
as bool?,postTitle: freezed == postTitle ? _self.postTitle : postTitle // ignore: cast_nullable_to_non_nullable
as String?,postDeleted: null == postDeleted ? _self.postDeleted : postDeleted // ignore: cast_nullable_to_non_nullable
as bool,postDeletedAs: freezed == postDeletedAs ? _self.postDeletedAs : postDeletedAs // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Comment
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


/// Adds pattern-matching-related methods to [Comment].
extension CommentPatterns on Comment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comment value)  $default,){
final _that = this;
switch (_that) {
case _Comment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comment value)?  $default,){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String postPublicId,  String communityId,  String communityName,  String? userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  String? parentId,  int depth,  int noReplies,  int? noDirectReplies,  List<String>? ancestors,  String body,  int upvotes,  int downvotes,  DateTime createdAt,  DateTime? editedAt,  bool? contentStripped,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  bool deleted,  DateTime? deletedAt,  String? deletedAs,  User? author,  bool? isAuthorMuted,  bool? userVoted,  bool? userVotedUp,  String? postTitle,  bool postDeleted,  String? postDeletedAs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.postId,_that.postPublicId,_that.communityId,_that.communityName,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.parentId,_that.depth,_that.noReplies,_that.noDirectReplies,_that.ancestors,_that.body,_that.upvotes,_that.downvotes,_that.createdAt,_that.editedAt,_that.contentStripped,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.deleted,_that.deletedAt,_that.deletedAs,_that.author,_that.isAuthorMuted,_that.userVoted,_that.userVotedUp,_that.postTitle,_that.postDeleted,_that.postDeletedAs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String postPublicId,  String communityId,  String communityName,  String? userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  String? parentId,  int depth,  int noReplies,  int? noDirectReplies,  List<String>? ancestors,  String body,  int upvotes,  int downvotes,  DateTime createdAt,  DateTime? editedAt,  bool? contentStripped,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  bool deleted,  DateTime? deletedAt,  String? deletedAs,  User? author,  bool? isAuthorMuted,  bool? userVoted,  bool? userVotedUp,  String? postTitle,  bool postDeleted,  String? postDeletedAs)  $default,) {final _that = this;
switch (_that) {
case _Comment():
return $default(_that.id,_that.postId,_that.postPublicId,_that.communityId,_that.communityName,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.parentId,_that.depth,_that.noReplies,_that.noDirectReplies,_that.ancestors,_that.body,_that.upvotes,_that.downvotes,_that.createdAt,_that.editedAt,_that.contentStripped,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.deleted,_that.deletedAt,_that.deletedAs,_that.author,_that.isAuthorMuted,_that.userVoted,_that.userVotedUp,_that.postTitle,_that.postDeleted,_that.postDeletedAs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String postPublicId,  String communityId,  String communityName,  String? userId,  String username,  String? userGhostId,  String userGroup,  bool userDeleted,  String? parentId,  int depth,  int noReplies,  int? noDirectReplies,  List<String>? ancestors,  String body,  int upvotes,  int downvotes,  DateTime createdAt,  DateTime? editedAt,  bool? contentStripped,  bool locked,  String? lockedBy,  String? lockedByGroup,  DateTime? lockedAt,  bool deleted,  DateTime? deletedAt,  String? deletedAs,  User? author,  bool? isAuthorMuted,  bool? userVoted,  bool? userVotedUp,  String? postTitle,  bool postDeleted,  String? postDeletedAs)?  $default,) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.postId,_that.postPublicId,_that.communityId,_that.communityName,_that.userId,_that.username,_that.userGhostId,_that.userGroup,_that.userDeleted,_that.parentId,_that.depth,_that.noReplies,_that.noDirectReplies,_that.ancestors,_that.body,_that.upvotes,_that.downvotes,_that.createdAt,_that.editedAt,_that.contentStripped,_that.locked,_that.lockedBy,_that.lockedByGroup,_that.lockedAt,_that.deleted,_that.deletedAt,_that.deletedAs,_that.author,_that.isAuthorMuted,_that.userVoted,_that.userVotedUp,_that.postTitle,_that.postDeleted,_that.postDeletedAs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comment implements Comment {
  const _Comment({required this.id, required this.postId, required this.postPublicId, required this.communityId, required this.communityName, this.userId, required this.username, this.userGhostId, required this.userGroup, required this.userDeleted, this.parentId, required this.depth, required this.noReplies, this.noDirectReplies, final  List<String>? ancestors, required this.body, required this.upvotes, required this.downvotes, required this.createdAt, this.editedAt, this.contentStripped, required this.locked, this.lockedBy, this.lockedByGroup, this.lockedAt, required this.deleted, this.deletedAt, this.deletedAs, this.author, this.isAuthorMuted, this.userVoted, this.userVotedUp, this.postTitle, required this.postDeleted, this.postDeletedAs}): _ancestors = ancestors;
  factory _Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

@override final  String id;
@override final  String postId;
@override final  String postPublicId;
@override final  String communityId;
@override final  String communityName;
@override final  String? userId;
@override final  String username;
@override final  String? userGhostId;
@override final  String userGroup;
@override final  bool userDeleted;
@override final  String? parentId;
@override final  int depth;
@override final  int noReplies;
@override final  int? noDirectReplies;
 final  List<String>? _ancestors;
@override List<String>? get ancestors {
  final value = _ancestors;
  if (value == null) return null;
  if (_ancestors is EqualUnmodifiableListView) return _ancestors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String body;
@override final  int upvotes;
@override final  int downvotes;
@override final  DateTime createdAt;
@override final  DateTime? editedAt;
@override final  bool? contentStripped;
@override final  bool locked;
@override final  String? lockedBy;
@override final  String? lockedByGroup;
@override final  DateTime? lockedAt;
@override final  bool deleted;
@override final  DateTime? deletedAt;
@override final  String? deletedAs;
@override final  User? author;
@override final  bool? isAuthorMuted;
@override final  bool? userVoted;
@override final  bool? userVotedUp;
@override final  String? postTitle;
@override final  bool postDeleted;
@override final  String? postDeletedAs;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCopyWith<_Comment> get copyWith => __$CommentCopyWithImpl<_Comment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.postPublicId, postPublicId) || other.postPublicId == postPublicId)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.userGhostId, userGhostId) || other.userGhostId == userGhostId)&&(identical(other.userGroup, userGroup) || other.userGroup == userGroup)&&(identical(other.userDeleted, userDeleted) || other.userDeleted == userDeleted)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.noReplies, noReplies) || other.noReplies == noReplies)&&(identical(other.noDirectReplies, noDirectReplies) || other.noDirectReplies == noDirectReplies)&&const DeepCollectionEquality().equals(other._ancestors, _ancestors)&&(identical(other.body, body) || other.body == body)&&(identical(other.upvotes, upvotes) || other.upvotes == upvotes)&&(identical(other.downvotes, downvotes) || other.downvotes == downvotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.contentStripped, contentStripped) || other.contentStripped == contentStripped)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedByGroup, lockedByGroup) || other.lockedByGroup == lockedByGroup)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.deletedAs, deletedAs) || other.deletedAs == deletedAs)&&(identical(other.author, author) || other.author == author)&&(identical(other.isAuthorMuted, isAuthorMuted) || other.isAuthorMuted == isAuthorMuted)&&(identical(other.userVoted, userVoted) || other.userVoted == userVoted)&&(identical(other.userVotedUp, userVotedUp) || other.userVotedUp == userVotedUp)&&(identical(other.postTitle, postTitle) || other.postTitle == postTitle)&&(identical(other.postDeleted, postDeleted) || other.postDeleted == postDeleted)&&(identical(other.postDeletedAs, postDeletedAs) || other.postDeletedAs == postDeletedAs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,postId,postPublicId,communityId,communityName,userId,username,userGhostId,userGroup,userDeleted,parentId,depth,noReplies,noDirectReplies,const DeepCollectionEquality().hash(_ancestors),body,upvotes,downvotes,createdAt,editedAt,contentStripped,locked,lockedBy,lockedByGroup,lockedAt,deleted,deletedAt,deletedAs,author,isAuthorMuted,userVoted,userVotedUp,postTitle,postDeleted,postDeletedAs]);

@override
String toString() {
  return 'Comment(id: $id, postId: $postId, postPublicId: $postPublicId, communityId: $communityId, communityName: $communityName, userId: $userId, username: $username, userGhostId: $userGhostId, userGroup: $userGroup, userDeleted: $userDeleted, parentId: $parentId, depth: $depth, noReplies: $noReplies, noDirectReplies: $noDirectReplies, ancestors: $ancestors, body: $body, upvotes: $upvotes, downvotes: $downvotes, createdAt: $createdAt, editedAt: $editedAt, contentStripped: $contentStripped, locked: $locked, lockedBy: $lockedBy, lockedByGroup: $lockedByGroup, lockedAt: $lockedAt, deleted: $deleted, deletedAt: $deletedAt, deletedAs: $deletedAs, author: $author, isAuthorMuted: $isAuthorMuted, userVoted: $userVoted, userVotedUp: $userVotedUp, postTitle: $postTitle, postDeleted: $postDeleted, postDeletedAs: $postDeletedAs)';
}


}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) = __$CommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String postPublicId, String communityId, String communityName, String? userId, String username, String? userGhostId, String userGroup, bool userDeleted, String? parentId, int depth, int noReplies, int? noDirectReplies, List<String>? ancestors, String body, int upvotes, int downvotes, DateTime createdAt, DateTime? editedAt, bool? contentStripped, bool locked, String? lockedBy, String? lockedByGroup, DateTime? lockedAt, bool deleted, DateTime? deletedAt, String? deletedAs, User? author, bool? isAuthorMuted, bool? userVoted, bool? userVotedUp, String? postTitle, bool postDeleted, String? postDeletedAs
});


@override $UserCopyWith<$Res>? get author;

}
/// @nodoc
class __$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? postPublicId = null,Object? communityId = null,Object? communityName = null,Object? userId = freezed,Object? username = null,Object? userGhostId = freezed,Object? userGroup = null,Object? userDeleted = null,Object? parentId = freezed,Object? depth = null,Object? noReplies = null,Object? noDirectReplies = freezed,Object? ancestors = freezed,Object? body = null,Object? upvotes = null,Object? downvotes = null,Object? createdAt = null,Object? editedAt = freezed,Object? contentStripped = freezed,Object? locked = null,Object? lockedBy = freezed,Object? lockedByGroup = freezed,Object? lockedAt = freezed,Object? deleted = null,Object? deletedAt = freezed,Object? deletedAs = freezed,Object? author = freezed,Object? isAuthorMuted = freezed,Object? userVoted = freezed,Object? userVotedUp = freezed,Object? postTitle = freezed,Object? postDeleted = null,Object? postDeletedAs = freezed,}) {
  return _then(_Comment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,postPublicId: null == postPublicId ? _self.postPublicId : postPublicId // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userGhostId: freezed == userGhostId ? _self.userGhostId : userGhostId // ignore: cast_nullable_to_non_nullable
as String?,userGroup: null == userGroup ? _self.userGroup : userGroup // ignore: cast_nullable_to_non_nullable
as String,userDeleted: null == userDeleted ? _self.userDeleted : userDeleted // ignore: cast_nullable_to_non_nullable
as bool,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,noReplies: null == noReplies ? _self.noReplies : noReplies // ignore: cast_nullable_to_non_nullable
as int,noDirectReplies: freezed == noDirectReplies ? _self.noDirectReplies : noDirectReplies // ignore: cast_nullable_to_non_nullable
as int?,ancestors: freezed == ancestors ? _self._ancestors : ancestors // ignore: cast_nullable_to_non_nullable
as List<String>?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,upvotes: null == upvotes ? _self.upvotes : upvotes // ignore: cast_nullable_to_non_nullable
as int,downvotes: null == downvotes ? _self.downvotes : downvotes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,contentStripped: freezed == contentStripped ? _self.contentStripped : contentStripped // ignore: cast_nullable_to_non_nullable
as bool?,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedByGroup: freezed == lockedByGroup ? _self.lockedByGroup : lockedByGroup // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAs: freezed == deletedAs ? _self.deletedAs : deletedAs // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User?,isAuthorMuted: freezed == isAuthorMuted ? _self.isAuthorMuted : isAuthorMuted // ignore: cast_nullable_to_non_nullable
as bool?,userVoted: freezed == userVoted ? _self.userVoted : userVoted // ignore: cast_nullable_to_non_nullable
as bool?,userVotedUp: freezed == userVotedUp ? _self.userVotedUp : userVotedUp // ignore: cast_nullable_to_non_nullable
as bool?,postTitle: freezed == postTitle ? _self.postTitle : postTitle // ignore: cast_nullable_to_non_nullable
as String?,postDeleted: null == postDeleted ? _self.postDeleted : postDeleted // ignore: cast_nullable_to_non_nullable
as bool,postDeletedAs: freezed == postDeletedAs ? _self.postDeletedAs : postDeletedAs // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Comment
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

// dart format on
