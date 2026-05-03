// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initial_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InitialCommunityMute {

 String get id; String get mutedCommunityId;
/// Create a copy of InitialCommunityMute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCommunityMuteCopyWith<InitialCommunityMute> get copyWith => _$InitialCommunityMuteCopyWithImpl<InitialCommunityMute>(this as InitialCommunityMute, _$identity);

  /// Serializes this InitialCommunityMute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialCommunityMute&&(identical(other.id, id) || other.id == id)&&(identical(other.mutedCommunityId, mutedCommunityId) || other.mutedCommunityId == mutedCommunityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mutedCommunityId);

@override
String toString() {
  return 'InitialCommunityMute(id: $id, mutedCommunityId: $mutedCommunityId)';
}


}

/// @nodoc
abstract mixin class $InitialCommunityMuteCopyWith<$Res>  {
  factory $InitialCommunityMuteCopyWith(InitialCommunityMute value, $Res Function(InitialCommunityMute) _then) = _$InitialCommunityMuteCopyWithImpl;
@useResult
$Res call({
 String id, String mutedCommunityId
});




}
/// @nodoc
class _$InitialCommunityMuteCopyWithImpl<$Res>
    implements $InitialCommunityMuteCopyWith<$Res> {
  _$InitialCommunityMuteCopyWithImpl(this._self, this._then);

  final InitialCommunityMute _self;
  final $Res Function(InitialCommunityMute) _then;

/// Create a copy of InitialCommunityMute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mutedCommunityId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mutedCommunityId: null == mutedCommunityId ? _self.mutedCommunityId : mutedCommunityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialCommunityMute].
extension InitialCommunityMutePatterns on InitialCommunityMute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialCommunityMute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialCommunityMute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialCommunityMute value)  $default,){
final _that = this;
switch (_that) {
case _InitialCommunityMute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialCommunityMute value)?  $default,){
final _that = this;
switch (_that) {
case _InitialCommunityMute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mutedCommunityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialCommunityMute() when $default != null:
return $default(_that.id,_that.mutedCommunityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mutedCommunityId)  $default,) {final _that = this;
switch (_that) {
case _InitialCommunityMute():
return $default(_that.id,_that.mutedCommunityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mutedCommunityId)?  $default,) {final _that = this;
switch (_that) {
case _InitialCommunityMute() when $default != null:
return $default(_that.id,_that.mutedCommunityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialCommunityMute implements InitialCommunityMute {
  const _InitialCommunityMute({required this.id, required this.mutedCommunityId});
  factory _InitialCommunityMute.fromJson(Map<String, dynamic> json) => _$InitialCommunityMuteFromJson(json);

@override final  String id;
@override final  String mutedCommunityId;

/// Create a copy of InitialCommunityMute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCommunityMuteCopyWith<_InitialCommunityMute> get copyWith => __$InitialCommunityMuteCopyWithImpl<_InitialCommunityMute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitialCommunityMuteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialCommunityMute&&(identical(other.id, id) || other.id == id)&&(identical(other.mutedCommunityId, mutedCommunityId) || other.mutedCommunityId == mutedCommunityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mutedCommunityId);

@override
String toString() {
  return 'InitialCommunityMute(id: $id, mutedCommunityId: $mutedCommunityId)';
}


}

/// @nodoc
abstract mixin class _$InitialCommunityMuteCopyWith<$Res> implements $InitialCommunityMuteCopyWith<$Res> {
  factory _$InitialCommunityMuteCopyWith(_InitialCommunityMute value, $Res Function(_InitialCommunityMute) _then) = __$InitialCommunityMuteCopyWithImpl;
@override @useResult
$Res call({
 String id, String mutedCommunityId
});




}
/// @nodoc
class __$InitialCommunityMuteCopyWithImpl<$Res>
    implements _$InitialCommunityMuteCopyWith<$Res> {
  __$InitialCommunityMuteCopyWithImpl(this._self, this._then);

  final _InitialCommunityMute _self;
  final $Res Function(_InitialCommunityMute) _then;

/// Create a copy of InitialCommunityMute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mutedCommunityId = null,}) {
  return _then(_InitialCommunityMute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mutedCommunityId: null == mutedCommunityId ? _self.mutedCommunityId : mutedCommunityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InitialUserMute {

 String get id; String get mutedUserId;
/// Create a copy of InitialUserMute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialUserMuteCopyWith<InitialUserMute> get copyWith => _$InitialUserMuteCopyWithImpl<InitialUserMute>(this as InitialUserMute, _$identity);

  /// Serializes this InitialUserMute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialUserMute&&(identical(other.id, id) || other.id == id)&&(identical(other.mutedUserId, mutedUserId) || other.mutedUserId == mutedUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mutedUserId);

@override
String toString() {
  return 'InitialUserMute(id: $id, mutedUserId: $mutedUserId)';
}


}

/// @nodoc
abstract mixin class $InitialUserMuteCopyWith<$Res>  {
  factory $InitialUserMuteCopyWith(InitialUserMute value, $Res Function(InitialUserMute) _then) = _$InitialUserMuteCopyWithImpl;
@useResult
$Res call({
 String id, String mutedUserId
});




}
/// @nodoc
class _$InitialUserMuteCopyWithImpl<$Res>
    implements $InitialUserMuteCopyWith<$Res> {
  _$InitialUserMuteCopyWithImpl(this._self, this._then);

  final InitialUserMute _self;
  final $Res Function(InitialUserMute) _then;

/// Create a copy of InitialUserMute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mutedUserId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mutedUserId: null == mutedUserId ? _self.mutedUserId : mutedUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialUserMute].
extension InitialUserMutePatterns on InitialUserMute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialUserMute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialUserMute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialUserMute value)  $default,){
final _that = this;
switch (_that) {
case _InitialUserMute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialUserMute value)?  $default,){
final _that = this;
switch (_that) {
case _InitialUserMute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mutedUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialUserMute() when $default != null:
return $default(_that.id,_that.mutedUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mutedUserId)  $default,) {final _that = this;
switch (_that) {
case _InitialUserMute():
return $default(_that.id,_that.mutedUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mutedUserId)?  $default,) {final _that = this;
switch (_that) {
case _InitialUserMute() when $default != null:
return $default(_that.id,_that.mutedUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialUserMute implements InitialUserMute {
  const _InitialUserMute({required this.id, required this.mutedUserId});
  factory _InitialUserMute.fromJson(Map<String, dynamic> json) => _$InitialUserMuteFromJson(json);

@override final  String id;
@override final  String mutedUserId;

/// Create a copy of InitialUserMute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialUserMuteCopyWith<_InitialUserMute> get copyWith => __$InitialUserMuteCopyWithImpl<_InitialUserMute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitialUserMuteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialUserMute&&(identical(other.id, id) || other.id == id)&&(identical(other.mutedUserId, mutedUserId) || other.mutedUserId == mutedUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mutedUserId);

@override
String toString() {
  return 'InitialUserMute(id: $id, mutedUserId: $mutedUserId)';
}


}

/// @nodoc
abstract mixin class _$InitialUserMuteCopyWith<$Res> implements $InitialUserMuteCopyWith<$Res> {
  factory _$InitialUserMuteCopyWith(_InitialUserMute value, $Res Function(_InitialUserMute) _then) = __$InitialUserMuteCopyWithImpl;
@override @useResult
$Res call({
 String id, String mutedUserId
});




}
/// @nodoc
class __$InitialUserMuteCopyWithImpl<$Res>
    implements _$InitialUserMuteCopyWith<$Res> {
  __$InitialUserMuteCopyWithImpl(this._self, this._then);

  final _InitialUserMute _self;
  final $Res Function(_InitialUserMute) _then;

/// Create a copy of InitialUserMute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mutedUserId = null,}) {
  return _then(_InitialUserMute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mutedUserId: null == mutedUserId ? _self.mutedUserId : mutedUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InitialMutes {

 List<InitialCommunityMute> get communityMutes; List<InitialUserMute> get userMutes;
/// Create a copy of InitialMutes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialMutesCopyWith<InitialMutes> get copyWith => _$InitialMutesCopyWithImpl<InitialMutes>(this as InitialMutes, _$identity);

  /// Serializes this InitialMutes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialMutes&&const DeepCollectionEquality().equals(other.communityMutes, communityMutes)&&const DeepCollectionEquality().equals(other.userMutes, userMutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(communityMutes),const DeepCollectionEquality().hash(userMutes));

@override
String toString() {
  return 'InitialMutes(communityMutes: $communityMutes, userMutes: $userMutes)';
}


}

/// @nodoc
abstract mixin class $InitialMutesCopyWith<$Res>  {
  factory $InitialMutesCopyWith(InitialMutes value, $Res Function(InitialMutes) _then) = _$InitialMutesCopyWithImpl;
@useResult
$Res call({
 List<InitialCommunityMute> communityMutes, List<InitialUserMute> userMutes
});




}
/// @nodoc
class _$InitialMutesCopyWithImpl<$Res>
    implements $InitialMutesCopyWith<$Res> {
  _$InitialMutesCopyWithImpl(this._self, this._then);

  final InitialMutes _self;
  final $Res Function(InitialMutes) _then;

/// Create a copy of InitialMutes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communityMutes = null,Object? userMutes = null,}) {
  return _then(_self.copyWith(
communityMutes: null == communityMutes ? _self.communityMutes : communityMutes // ignore: cast_nullable_to_non_nullable
as List<InitialCommunityMute>,userMutes: null == userMutes ? _self.userMutes : userMutes // ignore: cast_nullable_to_non_nullable
as List<InitialUserMute>,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialMutes].
extension InitialMutesPatterns on InitialMutes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialMutes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialMutes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialMutes value)  $default,){
final _that = this;
switch (_that) {
case _InitialMutes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialMutes value)?  $default,){
final _that = this;
switch (_that) {
case _InitialMutes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InitialCommunityMute> communityMutes,  List<InitialUserMute> userMutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialMutes() when $default != null:
return $default(_that.communityMutes,_that.userMutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InitialCommunityMute> communityMutes,  List<InitialUserMute> userMutes)  $default,) {final _that = this;
switch (_that) {
case _InitialMutes():
return $default(_that.communityMutes,_that.userMutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InitialCommunityMute> communityMutes,  List<InitialUserMute> userMutes)?  $default,) {final _that = this;
switch (_that) {
case _InitialMutes() when $default != null:
return $default(_that.communityMutes,_that.userMutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialMutes implements InitialMutes {
  const _InitialMutes({final  List<InitialCommunityMute> communityMutes = const [], final  List<InitialUserMute> userMutes = const []}): _communityMutes = communityMutes,_userMutes = userMutes;
  factory _InitialMutes.fromJson(Map<String, dynamic> json) => _$InitialMutesFromJson(json);

 final  List<InitialCommunityMute> _communityMutes;
@override@JsonKey() List<InitialCommunityMute> get communityMutes {
  if (_communityMutes is EqualUnmodifiableListView) return _communityMutes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communityMutes);
}

 final  List<InitialUserMute> _userMutes;
@override@JsonKey() List<InitialUserMute> get userMutes {
  if (_userMutes is EqualUnmodifiableListView) return _userMutes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userMutes);
}


/// Create a copy of InitialMutes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialMutesCopyWith<_InitialMutes> get copyWith => __$InitialMutesCopyWithImpl<_InitialMutes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitialMutesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialMutes&&const DeepCollectionEquality().equals(other._communityMutes, _communityMutes)&&const DeepCollectionEquality().equals(other._userMutes, _userMutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_communityMutes),const DeepCollectionEquality().hash(_userMutes));

@override
String toString() {
  return 'InitialMutes(communityMutes: $communityMutes, userMutes: $userMutes)';
}


}

/// @nodoc
abstract mixin class _$InitialMutesCopyWith<$Res> implements $InitialMutesCopyWith<$Res> {
  factory _$InitialMutesCopyWith(_InitialMutes value, $Res Function(_InitialMutes) _then) = __$InitialMutesCopyWithImpl;
@override @useResult
$Res call({
 List<InitialCommunityMute> communityMutes, List<InitialUserMute> userMutes
});




}
/// @nodoc
class __$InitialMutesCopyWithImpl<$Res>
    implements _$InitialMutesCopyWith<$Res> {
  __$InitialMutesCopyWithImpl(this._self, this._then);

  final _InitialMutes _self;
  final $Res Function(_InitialMutes) _then;

/// Create a copy of InitialMutes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communityMutes = null,Object? userMutes = null,}) {
  return _then(_InitialMutes(
communityMutes: null == communityMutes ? _self._communityMutes : communityMutes // ignore: cast_nullable_to_non_nullable
as List<InitialCommunityMute>,userMutes: null == userMutes ? _self._userMutes : userMutes // ignore: cast_nullable_to_non_nullable
as List<InitialUserMute>,
  ));
}


}


/// @nodoc
mixin _$InitialResponse {

 User? get user; List<Community> get communities; int? get noUsers; List<String>? get bannedFrom; String? get vapidPublicKey; InitialMutes get mutes;
/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialResponseCopyWith<InitialResponse> get copyWith => _$InitialResponseCopyWithImpl<InitialResponse>(this as InitialResponse, _$identity);

  /// Serializes this InitialResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.communities, communities)&&(identical(other.noUsers, noUsers) || other.noUsers == noUsers)&&const DeepCollectionEquality().equals(other.bannedFrom, bannedFrom)&&(identical(other.vapidPublicKey, vapidPublicKey) || other.vapidPublicKey == vapidPublicKey)&&(identical(other.mutes, mutes) || other.mutes == mutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(communities),noUsers,const DeepCollectionEquality().hash(bannedFrom),vapidPublicKey,mutes);

@override
String toString() {
  return 'InitialResponse(user: $user, communities: $communities, noUsers: $noUsers, bannedFrom: $bannedFrom, vapidPublicKey: $vapidPublicKey, mutes: $mutes)';
}


}

/// @nodoc
abstract mixin class $InitialResponseCopyWith<$Res>  {
  factory $InitialResponseCopyWith(InitialResponse value, $Res Function(InitialResponse) _then) = _$InitialResponseCopyWithImpl;
@useResult
$Res call({
 User? user, List<Community> communities, int? noUsers, List<String>? bannedFrom, String? vapidPublicKey, InitialMutes mutes
});


$UserCopyWith<$Res>? get user;$InitialMutesCopyWith<$Res> get mutes;

}
/// @nodoc
class _$InitialResponseCopyWithImpl<$Res>
    implements $InitialResponseCopyWith<$Res> {
  _$InitialResponseCopyWithImpl(this._self, this._then);

  final InitialResponse _self;
  final $Res Function(InitialResponse) _then;

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? communities = null,Object? noUsers = freezed,Object? bannedFrom = freezed,Object? vapidPublicKey = freezed,Object? mutes = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,noUsers: freezed == noUsers ? _self.noUsers : noUsers // ignore: cast_nullable_to_non_nullable
as int?,bannedFrom: freezed == bannedFrom ? _self.bannedFrom : bannedFrom // ignore: cast_nullable_to_non_nullable
as List<String>?,vapidPublicKey: freezed == vapidPublicKey ? _self.vapidPublicKey : vapidPublicKey // ignore: cast_nullable_to_non_nullable
as String?,mutes: null == mutes ? _self.mutes : mutes // ignore: cast_nullable_to_non_nullable
as InitialMutes,
  ));
}
/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InitialMutesCopyWith<$Res> get mutes {
  
  return $InitialMutesCopyWith<$Res>(_self.mutes, (value) {
    return _then(_self.copyWith(mutes: value));
  });
}
}


/// Adds pattern-matching-related methods to [InitialResponse].
extension InitialResponsePatterns on InitialResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialResponse value)  $default,){
final _that = this;
switch (_that) {
case _InitialResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey,  InitialMutes mutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey,_that.mutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey,  InitialMutes mutes)  $default,) {final _that = this;
switch (_that) {
case _InitialResponse():
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey,_that.mutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey,  InitialMutes mutes)?  $default,) {final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey,_that.mutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialResponse implements InitialResponse {
  const _InitialResponse({this.user, final  List<Community> communities = const [], this.noUsers, final  List<String>? bannedFrom, this.vapidPublicKey, this.mutes = const InitialMutes()}): _communities = communities,_bannedFrom = bannedFrom;
  factory _InitialResponse.fromJson(Map<String, dynamic> json) => _$InitialResponseFromJson(json);

@override final  User? user;
 final  List<Community> _communities;
@override@JsonKey() List<Community> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}

@override final  int? noUsers;
 final  List<String>? _bannedFrom;
@override List<String>? get bannedFrom {
  final value = _bannedFrom;
  if (value == null) return null;
  if (_bannedFrom is EqualUnmodifiableListView) return _bannedFrom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? vapidPublicKey;
@override@JsonKey() final  InitialMutes mutes;

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialResponseCopyWith<_InitialResponse> get copyWith => __$InitialResponseCopyWithImpl<_InitialResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitialResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._communities, _communities)&&(identical(other.noUsers, noUsers) || other.noUsers == noUsers)&&const DeepCollectionEquality().equals(other._bannedFrom, _bannedFrom)&&(identical(other.vapidPublicKey, vapidPublicKey) || other.vapidPublicKey == vapidPublicKey)&&(identical(other.mutes, mutes) || other.mutes == mutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_communities),noUsers,const DeepCollectionEquality().hash(_bannedFrom),vapidPublicKey,mutes);

@override
String toString() {
  return 'InitialResponse(user: $user, communities: $communities, noUsers: $noUsers, bannedFrom: $bannedFrom, vapidPublicKey: $vapidPublicKey, mutes: $mutes)';
}


}

/// @nodoc
abstract mixin class _$InitialResponseCopyWith<$Res> implements $InitialResponseCopyWith<$Res> {
  factory _$InitialResponseCopyWith(_InitialResponse value, $Res Function(_InitialResponse) _then) = __$InitialResponseCopyWithImpl;
@override @useResult
$Res call({
 User? user, List<Community> communities, int? noUsers, List<String>? bannedFrom, String? vapidPublicKey, InitialMutes mutes
});


@override $UserCopyWith<$Res>? get user;@override $InitialMutesCopyWith<$Res> get mutes;

}
/// @nodoc
class __$InitialResponseCopyWithImpl<$Res>
    implements _$InitialResponseCopyWith<$Res> {
  __$InitialResponseCopyWithImpl(this._self, this._then);

  final _InitialResponse _self;
  final $Res Function(_InitialResponse) _then;

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? communities = null,Object? noUsers = freezed,Object? bannedFrom = freezed,Object? vapidPublicKey = freezed,Object? mutes = null,}) {
  return _then(_InitialResponse(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,noUsers: freezed == noUsers ? _self.noUsers : noUsers // ignore: cast_nullable_to_non_nullable
as int?,bannedFrom: freezed == bannedFrom ? _self._bannedFrom : bannedFrom // ignore: cast_nullable_to_non_nullable
as List<String>?,vapidPublicKey: freezed == vapidPublicKey ? _self.vapidPublicKey : vapidPublicKey // ignore: cast_nullable_to_non_nullable
as String?,mutes: null == mutes ? _self.mutes : mutes // ignore: cast_nullable_to_non_nullable
as InitialMutes,
  ));
}

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InitialMutesCopyWith<$Res> get mutes {
  
  return $InitialMutesCopyWith<$Res>(_self.mutes, (value) {
    return _then(_self.copyWith(mutes: value));
  });
}
}

// dart format on
