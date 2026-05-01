// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Community {

 String get id; String get userId; String get name; bool get nsfw; String? get about; int get noMembers; DiscuitImage? get proPic; DiscuitImage? get bannerImage; bool get postingRestricted; DateTime get createdAt; DateTime? get deletedAt; bool? get isDefault; bool? get userJoined; bool? get userMod; List<User> get mods; List<CommunityRule> get rules;
/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityCopyWith<Community> get copyWith => _$CommunityCopyWithImpl<Community>(this as Community, _$identity);

  /// Serializes this Community to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Community&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.about, about) || other.about == about)&&(identical(other.noMembers, noMembers) || other.noMembers == noMembers)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.postingRestricted, postingRestricted) || other.postingRestricted == postingRestricted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.userJoined, userJoined) || other.userJoined == userJoined)&&(identical(other.userMod, userMod) || other.userMod == userMod)&&const DeepCollectionEquality().equals(other.mods, mods)&&const DeepCollectionEquality().equals(other.rules, rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,nsfw,about,noMembers,proPic,bannerImage,postingRestricted,createdAt,deletedAt,isDefault,userJoined,userMod,const DeepCollectionEquality().hash(mods),const DeepCollectionEquality().hash(rules));

@override
String toString() {
  return 'Community(id: $id, userId: $userId, name: $name, nsfw: $nsfw, about: $about, noMembers: $noMembers, proPic: $proPic, bannerImage: $bannerImage, postingRestricted: $postingRestricted, createdAt: $createdAt, deletedAt: $deletedAt, isDefault: $isDefault, userJoined: $userJoined, userMod: $userMod, mods: $mods, rules: $rules)';
}


}

/// @nodoc
abstract mixin class $CommunityCopyWith<$Res>  {
  factory $CommunityCopyWith(Community value, $Res Function(Community) _then) = _$CommunityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, bool nsfw, String? about, int noMembers, DiscuitImage? proPic, DiscuitImage? bannerImage, bool postingRestricted, DateTime createdAt, DateTime? deletedAt, bool? isDefault, bool? userJoined, bool? userMod, List<User> mods, List<CommunityRule> rules
});


$DiscuitImageCopyWith<$Res>? get proPic;$DiscuitImageCopyWith<$Res>? get bannerImage;

}
/// @nodoc
class _$CommunityCopyWithImpl<$Res>
    implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._self, this._then);

  final Community _self;
  final $Res Function(Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? nsfw = null,Object? about = freezed,Object? noMembers = null,Object? proPic = freezed,Object? bannerImage = freezed,Object? postingRestricted = null,Object? createdAt = null,Object? deletedAt = freezed,Object? isDefault = freezed,Object? userJoined = freezed,Object? userMod = freezed,Object? mods = null,Object? rules = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,noMembers: null == noMembers ? _self.noMembers : noMembers // ignore: cast_nullable_to_non_nullable
as int,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,bannerImage: freezed == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,postingRestricted: null == postingRestricted ? _self.postingRestricted : postingRestricted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,userJoined: freezed == userJoined ? _self.userJoined : userJoined // ignore: cast_nullable_to_non_nullable
as bool?,userMod: freezed == userMod ? _self.userMod : userMod // ignore: cast_nullable_to_non_nullable
as bool?,mods: null == mods ? _self.mods : mods // ignore: cast_nullable_to_non_nullable
as List<User>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<CommunityRule>,
  ));
}
/// Create a copy of Community
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
}/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get bannerImage {
    if (_self.bannerImage == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.bannerImage!, (value) {
    return _then(_self.copyWith(bannerImage: value));
  });
}
}


/// Adds pattern-matching-related methods to [Community].
extension CommunityPatterns on Community {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Community value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Community value)  $default,){
final _that = this;
switch (_that) {
case _Community():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Community value)?  $default,){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  bool nsfw,  String? about,  int noMembers,  DiscuitImage? proPic,  DiscuitImage? bannerImage,  bool postingRestricted,  DateTime createdAt,  DateTime? deletedAt,  bool? isDefault,  bool? userJoined,  bool? userMod,  List<User> mods,  List<CommunityRule> rules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.nsfw,_that.about,_that.noMembers,_that.proPic,_that.bannerImage,_that.postingRestricted,_that.createdAt,_that.deletedAt,_that.isDefault,_that.userJoined,_that.userMod,_that.mods,_that.rules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  bool nsfw,  String? about,  int noMembers,  DiscuitImage? proPic,  DiscuitImage? bannerImage,  bool postingRestricted,  DateTime createdAt,  DateTime? deletedAt,  bool? isDefault,  bool? userJoined,  bool? userMod,  List<User> mods,  List<CommunityRule> rules)  $default,) {final _that = this;
switch (_that) {
case _Community():
return $default(_that.id,_that.userId,_that.name,_that.nsfw,_that.about,_that.noMembers,_that.proPic,_that.bannerImage,_that.postingRestricted,_that.createdAt,_that.deletedAt,_that.isDefault,_that.userJoined,_that.userMod,_that.mods,_that.rules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  bool nsfw,  String? about,  int noMembers,  DiscuitImage? proPic,  DiscuitImage? bannerImage,  bool postingRestricted,  DateTime createdAt,  DateTime? deletedAt,  bool? isDefault,  bool? userJoined,  bool? userMod,  List<User> mods,  List<CommunityRule> rules)?  $default,) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.nsfw,_that.about,_that.noMembers,_that.proPic,_that.bannerImage,_that.postingRestricted,_that.createdAt,_that.deletedAt,_that.isDefault,_that.userJoined,_that.userMod,_that.mods,_that.rules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Community implements Community {
  const _Community({required this.id, required this.userId, required this.name, required this.nsfw, this.about, required this.noMembers, this.proPic, this.bannerImage, required this.postingRestricted, required this.createdAt, this.deletedAt, this.isDefault, this.userJoined, this.userMod, final  List<User> mods = const [], final  List<CommunityRule> rules = const []}): _mods = mods,_rules = rules;
  factory _Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  bool nsfw;
@override final  String? about;
@override final  int noMembers;
@override final  DiscuitImage? proPic;
@override final  DiscuitImage? bannerImage;
@override final  bool postingRestricted;
@override final  DateTime createdAt;
@override final  DateTime? deletedAt;
@override final  bool? isDefault;
@override final  bool? userJoined;
@override final  bool? userMod;
 final  List<User> _mods;
@override@JsonKey() List<User> get mods {
  if (_mods is EqualUnmodifiableListView) return _mods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mods);
}

 final  List<CommunityRule> _rules;
@override@JsonKey() List<CommunityRule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}


/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityCopyWith<_Community> get copyWith => __$CommunityCopyWithImpl<_Community>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Community&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.about, about) || other.about == about)&&(identical(other.noMembers, noMembers) || other.noMembers == noMembers)&&(identical(other.proPic, proPic) || other.proPic == proPic)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.postingRestricted, postingRestricted) || other.postingRestricted == postingRestricted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.userJoined, userJoined) || other.userJoined == userJoined)&&(identical(other.userMod, userMod) || other.userMod == userMod)&&const DeepCollectionEquality().equals(other._mods, _mods)&&const DeepCollectionEquality().equals(other._rules, _rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,nsfw,about,noMembers,proPic,bannerImage,postingRestricted,createdAt,deletedAt,isDefault,userJoined,userMod,const DeepCollectionEquality().hash(_mods),const DeepCollectionEquality().hash(_rules));

@override
String toString() {
  return 'Community(id: $id, userId: $userId, name: $name, nsfw: $nsfw, about: $about, noMembers: $noMembers, proPic: $proPic, bannerImage: $bannerImage, postingRestricted: $postingRestricted, createdAt: $createdAt, deletedAt: $deletedAt, isDefault: $isDefault, userJoined: $userJoined, userMod: $userMod, mods: $mods, rules: $rules)';
}


}

/// @nodoc
abstract mixin class _$CommunityCopyWith<$Res> implements $CommunityCopyWith<$Res> {
  factory _$CommunityCopyWith(_Community value, $Res Function(_Community) _then) = __$CommunityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, bool nsfw, String? about, int noMembers, DiscuitImage? proPic, DiscuitImage? bannerImage, bool postingRestricted, DateTime createdAt, DateTime? deletedAt, bool? isDefault, bool? userJoined, bool? userMod, List<User> mods, List<CommunityRule> rules
});


@override $DiscuitImageCopyWith<$Res>? get proPic;@override $DiscuitImageCopyWith<$Res>? get bannerImage;

}
/// @nodoc
class __$CommunityCopyWithImpl<$Res>
    implements _$CommunityCopyWith<$Res> {
  __$CommunityCopyWithImpl(this._self, this._then);

  final _Community _self;
  final $Res Function(_Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? nsfw = null,Object? about = freezed,Object? noMembers = null,Object? proPic = freezed,Object? bannerImage = freezed,Object? postingRestricted = null,Object? createdAt = null,Object? deletedAt = freezed,Object? isDefault = freezed,Object? userJoined = freezed,Object? userMod = freezed,Object? mods = null,Object? rules = null,}) {
  return _then(_Community(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,noMembers: null == noMembers ? _self.noMembers : noMembers // ignore: cast_nullable_to_non_nullable
as int,proPic: freezed == proPic ? _self.proPic : proPic // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,bannerImage: freezed == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as DiscuitImage?,postingRestricted: null == postingRestricted ? _self.postingRestricted : postingRestricted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,userJoined: freezed == userJoined ? _self.userJoined : userJoined // ignore: cast_nullable_to_non_nullable
as bool?,userMod: freezed == userMod ? _self.userMod : userMod // ignore: cast_nullable_to_non_nullable
as bool?,mods: null == mods ? _self._mods : mods // ignore: cast_nullable_to_non_nullable
as List<User>,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<CommunityRule>,
  ));
}

/// Create a copy of Community
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
}/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<$Res>? get bannerImage {
    if (_self.bannerImage == null) {
    return null;
  }

  return $DiscuitImageCopyWith<$Res>(_self.bannerImage!, (value) {
    return _then(_self.copyWith(bannerImage: value));
  });
}
}


/// @nodoc
mixin _$CommunityRule {

 int get id; String get rule; String? get description; String get communityId; int get zIndex; String get createdBy; DateTime get createdAt;
/// Create a copy of CommunityRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityRuleCopyWith<CommunityRule> get copyWith => _$CommunityRuleCopyWithImpl<CommunityRule>(this as CommunityRule, _$identity);

  /// Serializes this CommunityRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityRule&&(identical(other.id, id) || other.id == id)&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.description, description) || other.description == description)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.zIndex, zIndex) || other.zIndex == zIndex)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rule,description,communityId,zIndex,createdBy,createdAt);

@override
String toString() {
  return 'CommunityRule(id: $id, rule: $rule, description: $description, communityId: $communityId, zIndex: $zIndex, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommunityRuleCopyWith<$Res>  {
  factory $CommunityRuleCopyWith(CommunityRule value, $Res Function(CommunityRule) _then) = _$CommunityRuleCopyWithImpl;
@useResult
$Res call({
 int id, String rule, String? description, String communityId, int zIndex, String createdBy, DateTime createdAt
});




}
/// @nodoc
class _$CommunityRuleCopyWithImpl<$Res>
    implements $CommunityRuleCopyWith<$Res> {
  _$CommunityRuleCopyWithImpl(this._self, this._then);

  final CommunityRule _self;
  final $Res Function(CommunityRule) _then;

/// Create a copy of CommunityRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rule = null,Object? description = freezed,Object? communityId = null,Object? zIndex = null,Object? createdBy = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,zIndex: null == zIndex ? _self.zIndex : zIndex // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityRule].
extension CommunityRulePatterns on CommunityRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityRule value)  $default,){
final _that = this;
switch (_that) {
case _CommunityRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityRule value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String rule,  String? description,  String communityId,  int zIndex,  String createdBy,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityRule() when $default != null:
return $default(_that.id,_that.rule,_that.description,_that.communityId,_that.zIndex,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String rule,  String? description,  String communityId,  int zIndex,  String createdBy,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityRule():
return $default(_that.id,_that.rule,_that.description,_that.communityId,_that.zIndex,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String rule,  String? description,  String communityId,  int zIndex,  String createdBy,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityRule() when $default != null:
return $default(_that.id,_that.rule,_that.description,_that.communityId,_that.zIndex,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityRule implements CommunityRule {
  const _CommunityRule({required this.id, required this.rule, this.description, required this.communityId, required this.zIndex, required this.createdBy, required this.createdAt});
  factory _CommunityRule.fromJson(Map<String, dynamic> json) => _$CommunityRuleFromJson(json);

@override final  int id;
@override final  String rule;
@override final  String? description;
@override final  String communityId;
@override final  int zIndex;
@override final  String createdBy;
@override final  DateTime createdAt;

/// Create a copy of CommunityRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityRuleCopyWith<_CommunityRule> get copyWith => __$CommunityRuleCopyWithImpl<_CommunityRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityRule&&(identical(other.id, id) || other.id == id)&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.description, description) || other.description == description)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.zIndex, zIndex) || other.zIndex == zIndex)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rule,description,communityId,zIndex,createdBy,createdAt);

@override
String toString() {
  return 'CommunityRule(id: $id, rule: $rule, description: $description, communityId: $communityId, zIndex: $zIndex, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityRuleCopyWith<$Res> implements $CommunityRuleCopyWith<$Res> {
  factory _$CommunityRuleCopyWith(_CommunityRule value, $Res Function(_CommunityRule) _then) = __$CommunityRuleCopyWithImpl;
@override @useResult
$Res call({
 int id, String rule, String? description, String communityId, int zIndex, String createdBy, DateTime createdAt
});




}
/// @nodoc
class __$CommunityRuleCopyWithImpl<$Res>
    implements _$CommunityRuleCopyWith<$Res> {
  __$CommunityRuleCopyWithImpl(this._self, this._then);

  final _CommunityRule _self;
  final $Res Function(_CommunityRule) _then;

/// Create a copy of CommunityRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rule = null,Object? description = freezed,Object? communityId = null,Object? zIndex = null,Object? createdBy = null,Object? createdAt = null,}) {
  return _then(_CommunityRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,zIndex: null == zIndex ? _self.zIndex : zIndex // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
