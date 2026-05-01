// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String get id; String get username; String? get email; DateTime? get emailConfirmedAt; String? get aboutMe; int get points; bool get isAdmin; DiscuitImage? get proPic; List<Badge> get badges; int get noPosts; int get noComments; DateTime get createdAt; bool get deleted; DateTime? get deletedAt; bool get upvoteNotificationsOff; bool get replyNotificationsOff; String get homeFeed; bool get rememberFeedSort; bool get embedsOff; bool get hideUserProfilePictures; DateTime? get bannedAt; bool get isBanned; int get notificationsNewCount;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailConfirmedAt, emailConfirmedAt) || other.emailConfirmedAt == emailConfirmedAt)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.points, points) || other.points == points)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&const DeepCollectionEquality().equals(other.badges, badges)&&(identical(other.noPosts, noPosts) || other.noPosts == noPosts)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.upvoteNotificationsOff, upvoteNotificationsOff) || other.upvoteNotificationsOff == upvoteNotificationsOff)&&(identical(other.replyNotificationsOff, replyNotificationsOff) || other.replyNotificationsOff == replyNotificationsOff)&&(identical(other.homeFeed, homeFeed) || other.homeFeed == homeFeed)&&(identical(other.rememberFeedSort, rememberFeedSort) || other.rememberFeedSort == rememberFeedSort)&&(identical(other.embedsOff, embedsOff) || other.embedsOff == embedsOff)&&(identical(other.hideUserProfilePictures, hideUserProfilePictures) || other.hideUserProfilePictures == hideUserProfilePictures)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned)&&(identical(other.notificationsNewCount, notificationsNewCount) || other.notificationsNewCount == notificationsNewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,email,emailConfirmedAt,aboutMe,points,isAdmin,proPic,const DeepCollectionEquality().hash(badges),noPosts,noComments,createdAt,deleted,deletedAt,upvoteNotificationsOff,replyNotificationsOff,homeFeed,rememberFeedSort,embedsOff,hideUserProfilePictures,bannedAt,isBanned,notificationsNewCount]);

@override
String toString() {
  return 'User(id: $id, username: $username, email: $email, emailConfirmedAt: $emailConfirmedAt, aboutMe: $aboutMe, points: $points, isAdmin: $isAdmin, proPic: $proPic, badges: $badges, noPosts: $noPosts, noComments: $noComments, createdAt: $createdAt, deleted: $deleted, deletedAt: $deletedAt, upvoteNotificationsOff: $upvoteNotificationsOff, replyNotificationsOff: $replyNotificationsOff, homeFeed: $homeFeed, rememberFeedSort: $rememberFeedSort, embedsOff: $embedsOff, hideUserProfilePictures: $hideUserProfilePictures, bannedAt: $bannedAt, isBanned: $isBanned, notificationsNewCount: $notificationsNewCount)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? email, DateTime? emailConfirmedAt, String? aboutMe, int points, bool isAdmin, DiscuitImage? proPic, List<Badge> badges, int noPosts, int noComments, DateTime createdAt, bool deleted, DateTime? deletedAt, bool upvoteNotificationsOff, bool replyNotificationsOff, String homeFeed, bool rememberFeedSort, bool embedsOff, bool hideUserProfilePictures, DateTime? bannedAt, bool isBanned, int notificationsNewCount
});


$DiscuitImageCopyWith<$Res>? get proPic;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? email = freezed,Object? emailConfirmedAt = freezed,Object? aboutMe = freezed,Object? points = null,Object? isAdmin = null,Object? proPic = freezed,Object? badges = null,Object? noPosts = null,Object? noComments = null,Object? createdAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? upvoteNotificationsOff = null,Object? replyNotificationsOff = null,Object? homeFeed = null,Object? rememberFeedSort = null,Object? embedsOff = null,Object? hideUserProfilePictures = null,Object? bannedAt = freezed,Object? isBanned = null,Object? notificationsNewCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailConfirmedAt: freezed == emailConfirmedAt ? _self.emailConfirmedAt : emailConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,noPosts: null == noPosts ? _self.noPosts : noPosts // ignore: cast_nullable_to_non_nullable
as int,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,upvoteNotificationsOff: null == upvoteNotificationsOff ? _self.upvoteNotificationsOff : upvoteNotificationsOff // ignore: cast_nullable_to_non_nullable
as bool,replyNotificationsOff: null == replyNotificationsOff ? _self.replyNotificationsOff : replyNotificationsOff // ignore: cast_nullable_to_non_nullable
as bool,homeFeed: null == homeFeed ? _self.homeFeed : homeFeed // ignore: cast_nullable_to_non_nullable
as String,rememberFeedSort: null == rememberFeedSort ? _self.rememberFeedSort : rememberFeedSort // ignore: cast_nullable_to_non_nullable
as bool,embedsOff: null == embedsOff ? _self.embedsOff : embedsOff // ignore: cast_nullable_to_non_nullable
as bool,hideUserProfilePictures: null == hideUserProfilePictures ? _self.hideUserProfilePictures : hideUserProfilePictures // ignore: cast_nullable_to_non_nullable
as bool,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,notificationsNewCount: null == notificationsNewCount ? _self.notificationsNewCount : notificationsNewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get proPic {
    if (_self.proPic == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.proPic!, (value) {
    return _then(_self.copyWith(proPic: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? email,  DateTime? emailConfirmedAt,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  bool upvoteNotificationsOff,  bool replyNotificationsOff,  String homeFeed,  bool rememberFeedSort,  bool embedsOff,  bool hideUserProfilePictures,  DateTime? bannedAt,  bool isBanned,  int notificationsNewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.emailConfirmedAt,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.upvoteNotificationsOff,_that.replyNotificationsOff,_that.homeFeed,_that.rememberFeedSort,_that.embedsOff,_that.hideUserProfilePictures,_that.bannedAt,_that.isBanned,_that.notificationsNewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? email,  DateTime? emailConfirmedAt,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  bool upvoteNotificationsOff,  bool replyNotificationsOff,  String homeFeed,  bool rememberFeedSort,  bool embedsOff,  bool hideUserProfilePictures,  DateTime? bannedAt,  bool isBanned,  int notificationsNewCount)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.username,_that.email,_that.emailConfirmedAt,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.upvoteNotificationsOff,_that.replyNotificationsOff,_that.homeFeed,_that.rememberFeedSort,_that.embedsOff,_that.hideUserProfilePictures,_that.bannedAt,_that.isBanned,_that.notificationsNewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? email,  DateTime? emailConfirmedAt,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  bool upvoteNotificationsOff,  bool replyNotificationsOff,  String homeFeed,  bool rememberFeedSort,  bool embedsOff,  bool hideUserProfilePictures,  DateTime? bannedAt,  bool isBanned,  int notificationsNewCount)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.emailConfirmedAt,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.upvoteNotificationsOff,_that.replyNotificationsOff,_that.homeFeed,_that.rememberFeedSort,_that.embedsOff,_that.hideUserProfilePictures,_that.bannedAt,_that.isBanned,_that.notificationsNewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({required this.id, required this.username, this.email, this.emailConfirmedAt, this.aboutMe, required this.points, required this.isAdmin, this.proPic, final  List<Badge> badges = const [], required this.noPosts, required this.noComments, required this.createdAt, required this.deleted, this.deletedAt, required this.upvoteNotificationsOff, required this.replyNotificationsOff, required this.homeFeed, required this.rememberFeedSort, required this.embedsOff, required this.hideUserProfilePictures, this.bannedAt, required this.isBanned, required this.notificationsNewCount}): _badges = badges;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? email;
@override final  DateTime? emailConfirmedAt;
@override final  String? aboutMe;
@override final  int points;
@override final  bool isAdmin;
@override final  DiscuitImage? proPic;
 final  List<Badge> _badges;
@override@JsonKey() List<Badge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override final  int noPosts;
@override final  int noComments;
@override final  DateTime createdAt;
@override final  bool deleted;
@override final  DateTime? deletedAt;
@override final  bool upvoteNotificationsOff;
@override final  bool replyNotificationsOff;
@override final  String homeFeed;
@override final  bool rememberFeedSort;
@override final  bool embedsOff;
@override final  bool hideUserProfilePictures;
@override final  DateTime? bannedAt;
@override final  bool isBanned;
@override final  int notificationsNewCount;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailConfirmedAt, emailConfirmedAt) || other.emailConfirmedAt == emailConfirmedAt)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.points, points) || other.points == points)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&const DeepCollectionEquality().equals(other._badges, _badges)&&(identical(other.noPosts, noPosts) || other.noPosts == noPosts)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.upvoteNotificationsOff, upvoteNotificationsOff) || other.upvoteNotificationsOff == upvoteNotificationsOff)&&(identical(other.replyNotificationsOff, replyNotificationsOff) || other.replyNotificationsOff == replyNotificationsOff)&&(identical(other.homeFeed, homeFeed) || other.homeFeed == homeFeed)&&(identical(other.rememberFeedSort, rememberFeedSort) || other.rememberFeedSort == rememberFeedSort)&&(identical(other.embedsOff, embedsOff) || other.embedsOff == embedsOff)&&(identical(other.hideUserProfilePictures, hideUserProfilePictures) || other.hideUserProfilePictures == hideUserProfilePictures)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned)&&(identical(other.notificationsNewCount, notificationsNewCount) || other.notificationsNewCount == notificationsNewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,email,emailConfirmedAt,aboutMe,points,isAdmin,proPic,const DeepCollectionEquality().hash(_badges),noPosts,noComments,createdAt,deleted,deletedAt,upvoteNotificationsOff,replyNotificationsOff,homeFeed,rememberFeedSort,embedsOff,hideUserProfilePictures,bannedAt,isBanned,notificationsNewCount]);

@override
String toString() {
  return 'User(id: $id, username: $username, email: $email, emailConfirmedAt: $emailConfirmedAt, aboutMe: $aboutMe, points: $points, isAdmin: $isAdmin, proPic: $proPic, badges: $badges, noPosts: $noPosts, noComments: $noComments, createdAt: $createdAt, deleted: $deleted, deletedAt: $deletedAt, upvoteNotificationsOff: $upvoteNotificationsOff, replyNotificationsOff: $replyNotificationsOff, homeFeed: $homeFeed, rememberFeedSort: $rememberFeedSort, embedsOff: $embedsOff, hideUserProfilePictures: $hideUserProfilePictures, bannedAt: $bannedAt, isBanned: $isBanned, notificationsNewCount: $notificationsNewCount)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? email, DateTime? emailConfirmedAt, String? aboutMe, int points, bool isAdmin, DiscuitImage? proPic, List<Badge> badges, int noPosts, int noComments, DateTime createdAt, bool deleted, DateTime? deletedAt, bool upvoteNotificationsOff, bool replyNotificationsOff, String homeFeed, bool rememberFeedSort, bool embedsOff, bool hideUserProfilePictures, DateTime? bannedAt, bool isBanned, int notificationsNewCount
});


@override $DiscuitImageCopyWith<$Res>? get proPic;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? email = freezed,Object? emailConfirmedAt = freezed,Object? aboutMe = freezed,Object? points = null,Object? isAdmin = null,Object? proPic = freezed,Object? badges = null,Object? noPosts = null,Object? noComments = null,Object? createdAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? upvoteNotificationsOff = null,Object? replyNotificationsOff = null,Object? homeFeed = null,Object? rememberFeedSort = null,Object? embedsOff = null,Object? hideUserProfilePictures = null,Object? bannedAt = freezed,Object? isBanned = null,Object? notificationsNewCount = null,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailConfirmedAt: freezed == emailConfirmedAt ? _self.emailConfirmedAt : emailConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,noPosts: null == noPosts ? _self.noPosts : noPosts // ignore: cast_nullable_to_non_nullable
as int,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,upvoteNotificationsOff: null == upvoteNotificationsOff ? _self.upvoteNotificationsOff : upvoteNotificationsOff // ignore: cast_nullable_to_non_nullable
as bool,replyNotificationsOff: null == replyNotificationsOff ? _self.replyNotificationsOff : replyNotificationsOff // ignore: cast_nullable_to_non_nullable
as bool,homeFeed: null == homeFeed ? _self.homeFeed : homeFeed // ignore: cast_nullable_to_non_nullable
as String,rememberFeedSort: null == rememberFeedSort ? _self.rememberFeedSort : rememberFeedSort // ignore: cast_nullable_to_non_nullable
as bool,embedsOff: null == embedsOff ? _self.embedsOff : embedsOff // ignore: cast_nullable_to_non_nullable
as bool,hideUserProfilePictures: null == hideUserProfilePictures ? _self.hideUserProfilePictures : hideUserProfilePictures // ignore: cast_nullable_to_non_nullable
as bool,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,notificationsNewCount: null == notificationsNewCount ? _self.notificationsNewCount : notificationsNewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get proPic {
    if (_self.proPic == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.proPic!, (value) {
    return _then(_self.copyWith(proPic: value));
  });
}
}


/// @nodoc
mixin _$Badge {

 int get id; String get type;
/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgeCopyWith<Badge> get copyWith => _$BadgeCopyWithImpl<Badge>(this as Badge, _$identity);

  /// Serializes this Badge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Badge&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'Badge(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $BadgeCopyWith<$Res>  {
  factory $BadgeCopyWith(Badge value, $Res Function(Badge) _then) = _$BadgeCopyWithImpl;
@useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class _$BadgeCopyWithImpl<$Res>
    implements $BadgeCopyWith<$Res> {
  _$BadgeCopyWithImpl(this._self, this._then);

  final Badge _self;
  final $Res Function(Badge) _then;

/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Badge].
extension BadgePatterns on Badge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Badge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Badge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Badge value)  $default,){
final _that = this;
switch (_that) {
case _Badge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Badge value)?  $default,){
final _that = this;
switch (_that) {
case _Badge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Badge() when $default != null:
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _Badge():
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _Badge() when $default != null:
return $default(_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Badge implements Badge {
  const _Badge({required this.id, required this.type});
  factory _Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

@override final  int id;
@override final  String type;

/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgeCopyWith<_Badge> get copyWith => __$BadgeCopyWithImpl<_Badge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Badge&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'Badge(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$BadgeCopyWith<$Res> implements $BadgeCopyWith<$Res> {
  factory _$BadgeCopyWith(_Badge value, $Res Function(_Badge) _then) = __$BadgeCopyWithImpl;
@override @useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class __$BadgeCopyWithImpl<$Res>
    implements _$BadgeCopyWith<$Res> {
  __$BadgeCopyWithImpl(this._self, this._then);

  final _Badge _self;
  final $Res Function(_Badge) _then;

/// Create a copy of Badge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,}) {
  return _then(_Badge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
