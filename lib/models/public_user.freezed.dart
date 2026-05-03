// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicUser {

 String get id; String get username; String? get aboutMe; int get points; bool get isAdmin; DiscuitImage? get proPic; List<Badge> get badges; int get noPosts; int get noComments; DateTime get createdAt; bool get deleted; DateTime? get deletedAt; DateTime? get bannedAt; bool get isBanned;
/// Create a copy of PublicUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicUserCopyWith<PublicUser> get copyWith => _$PublicUserCopyWithImpl<PublicUser>(this as PublicUser, _$identity);

  /// Serializes this PublicUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.points, points) || other.points == points)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&const DeepCollectionEquality().equals(other.badges, badges)&&(identical(other.noPosts, noPosts) || other.noPosts == noPosts)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,aboutMe,points,isAdmin,proPic,const DeepCollectionEquality().hash(badges),noPosts,noComments,createdAt,deleted,deletedAt,bannedAt,isBanned);

@override
String toString() {
  return 'PublicUser(id: $id, username: $username, aboutMe: $aboutMe, points: $points, isAdmin: $isAdmin, proPic: $proPic, badges: $badges, noPosts: $noPosts, noComments: $noComments, createdAt: $createdAt, deleted: $deleted, deletedAt: $deletedAt, bannedAt: $bannedAt, isBanned: $isBanned)';
}


}

/// @nodoc
abstract mixin class $PublicUserCopyWith<$Res>  {
  factory $PublicUserCopyWith(PublicUser value, $Res Function(PublicUser) _then) = _$PublicUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? aboutMe, int points, bool isAdmin, DiscuitImage? proPic, List<Badge> badges, int noPosts, int noComments, DateTime createdAt, bool deleted, DateTime? deletedAt, DateTime? bannedAt, bool isBanned
});


$DiscuitImageCopyWith<$Res>? get proPic;

}
/// @nodoc
class _$PublicUserCopyWithImpl<$Res>
    implements $PublicUserCopyWith<$Res> {
  _$PublicUserCopyWithImpl(this._self, this._then);

  final PublicUser _self;
  final $Res Function(PublicUser) _then;

/// Create a copy of PublicUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? aboutMe = freezed,Object? points = null,Object? isAdmin = null,Object? proPic = freezed,Object? badges = null,Object? noPosts = null,Object? noComments = null,Object? createdAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? bannedAt = freezed,Object? isBanned = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,noPosts: null == noPosts ? _self.noPosts : noPosts // ignore: cast_nullable_to_non_nullable
as int,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PublicUser
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


/// Adds pattern-matching-related methods to [PublicUser].
extension PublicUserPatterns on PublicUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicUser value)  $default,){
final _that = this;
switch (_that) {
case _PublicUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicUser value)?  $default,){
final _that = this;
switch (_that) {
case _PublicUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  DateTime? bannedAt,  bool isBanned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicUser() when $default != null:
return $default(_that.id,_that.username,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.bannedAt,_that.isBanned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  DateTime? bannedAt,  bool isBanned)  $default,) {final _that = this;
switch (_that) {
case _PublicUser():
return $default(_that.id,_that.username,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.bannedAt,_that.isBanned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? aboutMe,  int points,  bool isAdmin,  DiscuitImage? proPic,  List<Badge> badges,  int noPosts,  int noComments,  DateTime createdAt,  bool deleted,  DateTime? deletedAt,  DateTime? bannedAt,  bool isBanned)?  $default,) {final _that = this;
switch (_that) {
case _PublicUser() when $default != null:
return $default(_that.id,_that.username,_that.aboutMe,_that.points,_that.isAdmin,_that.proPic,_that.badges,_that.noPosts,_that.noComments,_that.createdAt,_that.deleted,_that.deletedAt,_that.bannedAt,_that.isBanned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicUser implements PublicUser {
  const _PublicUser({required this.id, required this.username, this.aboutMe, required this.points, required this.isAdmin, this.proPic, final  List<Badge> badges = const [], required this.noPosts, required this.noComments, required this.createdAt, required this.deleted, this.deletedAt, this.bannedAt, required this.isBanned}): _badges = badges;
  factory _PublicUser.fromJson(Map<String, dynamic> json) => _$PublicUserFromJson(json);

@override final  String id;
@override final  String username;
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
@override final  DateTime? bannedAt;
@override final  bool isBanned;

/// Create a copy of PublicUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicUserCopyWith<_PublicUser> get copyWith => __$PublicUserCopyWithImpl<_PublicUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.points, points) || other.points == points)&&(identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&const DeepCollectionEquality().equals(other._badges, _badges)&&(identical(other.noPosts, noPosts) || other.noPosts == noPosts)&&(identical(other.noComments, noComments) || other.noComments == noComments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.isBanned, isBanned) || other.isBanned == isBanned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,aboutMe,points,isAdmin,proPic,const DeepCollectionEquality().hash(_badges),noPosts,noComments,createdAt,deleted,deletedAt,bannedAt,isBanned);

@override
String toString() {
  return 'PublicUser(id: $id, username: $username, aboutMe: $aboutMe, points: $points, isAdmin: $isAdmin, proPic: $proPic, badges: $badges, noPosts: $noPosts, noComments: $noComments, createdAt: $createdAt, deleted: $deleted, deletedAt: $deletedAt, bannedAt: $bannedAt, isBanned: $isBanned)';
}


}

/// @nodoc
abstract mixin class _$PublicUserCopyWith<$Res> implements $PublicUserCopyWith<$Res> {
  factory _$PublicUserCopyWith(_PublicUser value, $Res Function(_PublicUser) _then) = __$PublicUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? aboutMe, int points, bool isAdmin, DiscuitImage? proPic, List<Badge> badges, int noPosts, int noComments, DateTime createdAt, bool deleted, DateTime? deletedAt, DateTime? bannedAt, bool isBanned
});


@override $DiscuitImageCopyWith<$Res>? get proPic;

}
/// @nodoc
class __$PublicUserCopyWithImpl<$Res>
    implements _$PublicUserCopyWith<$Res> {
  __$PublicUserCopyWithImpl(this._self, this._then);

  final _PublicUser _self;
  final $Res Function(_PublicUser) _then;

/// Create a copy of PublicUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? aboutMe = freezed,Object? points = null,Object? isAdmin = null,Object? proPic = freezed,Object? badges = null,Object? noPosts = null,Object? noComments = null,Object? createdAt = null,Object? deleted = null,Object? deletedAt = freezed,Object? bannedAt = freezed,Object? isBanned = null,}) {
  return _then(_PublicUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isAdmin: null == isAdmin ? _self.isAdmin : isAdmin // ignore: cast_nullable_to_non_nullable
as bool,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,noPosts: null == noPosts ? _self.noPosts : noPosts // ignore: cast_nullable_to_non_nullable
as int,noComments: null == noComments ? _self.noComments : noComments // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isBanned: null == isBanned ? _self.isBanned : isBanned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PublicUser
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

// dart format on
