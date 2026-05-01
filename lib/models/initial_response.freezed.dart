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
mixin _$InitialResponse {

 User? get user; List<Community> get communities; int? get noUsers; List<String>? get bannedFrom; String? get vapidPublicKey;
/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialResponseCopyWith<InitialResponse> get copyWith => _$InitialResponseCopyWithImpl<InitialResponse>(this as InitialResponse, _$identity);

  /// Serializes this InitialResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.communities, communities)&&(identical(other.noUsers, noUsers) || other.noUsers == noUsers)&&const DeepCollectionEquality().equals(other.bannedFrom, bannedFrom)&&(identical(other.vapidPublicKey, vapidPublicKey) || other.vapidPublicKey == vapidPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(communities),noUsers,const DeepCollectionEquality().hash(bannedFrom),vapidPublicKey);

@override
String toString() {
  return 'InitialResponse(user: $user, communities: $communities, noUsers: $noUsers, bannedFrom: $bannedFrom, vapidPublicKey: $vapidPublicKey)';
}


}

/// @nodoc
abstract mixin class $InitialResponseCopyWith<$Res>  {
  factory $InitialResponseCopyWith(InitialResponse value, $Res Function(InitialResponse) _then) = _$InitialResponseCopyWithImpl;
@useResult
$Res call({
 User? user, List<Community> communities, int? noUsers, List<String>? bannedFrom, String? vapidPublicKey
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$InitialResponseCopyWithImpl<$Res>
    implements $InitialResponseCopyWith<$Res> {
  _$InitialResponseCopyWithImpl(this._self, this._then);

  final InitialResponse _self;
  final $Res Function(InitialResponse) _then;

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? communities = null,Object? noUsers = freezed,Object? bannedFrom = freezed,Object? vapidPublicKey = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,noUsers: freezed == noUsers ? _self.noUsers : noUsers // ignore: cast_nullable_to_non_nullable
as int?,bannedFrom: freezed == bannedFrom ? _self.bannedFrom : bannedFrom // ignore: cast_nullable_to_non_nullable
as List<String>?,vapidPublicKey: freezed == vapidPublicKey ? _self.vapidPublicKey : vapidPublicKey // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey)  $default,) {final _that = this;
switch (_that) {
case _InitialResponse():
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User? user,  List<Community> communities,  int? noUsers,  List<String>? bannedFrom,  String? vapidPublicKey)?  $default,) {final _that = this;
switch (_that) {
case _InitialResponse() when $default != null:
return $default(_that.user,_that.communities,_that.noUsers,_that.bannedFrom,_that.vapidPublicKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialResponse implements InitialResponse {
  const _InitialResponse({this.user, final  List<Community> communities = const [], this.noUsers, final  List<String>? bannedFrom, this.vapidPublicKey}): _communities = communities,_bannedFrom = bannedFrom;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialResponse&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._communities, _communities)&&(identical(other.noUsers, noUsers) || other.noUsers == noUsers)&&const DeepCollectionEquality().equals(other._bannedFrom, _bannedFrom)&&(identical(other.vapidPublicKey, vapidPublicKey) || other.vapidPublicKey == vapidPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,const DeepCollectionEquality().hash(_communities),noUsers,const DeepCollectionEquality().hash(_bannedFrom),vapidPublicKey);

@override
String toString() {
  return 'InitialResponse(user: $user, communities: $communities, noUsers: $noUsers, bannedFrom: $bannedFrom, vapidPublicKey: $vapidPublicKey)';
}


}

/// @nodoc
abstract mixin class _$InitialResponseCopyWith<$Res> implements $InitialResponseCopyWith<$Res> {
  factory _$InitialResponseCopyWith(_InitialResponse value, $Res Function(_InitialResponse) _then) = __$InitialResponseCopyWithImpl;
@override @useResult
$Res call({
 User? user, List<Community> communities, int? noUsers, List<String>? bannedFrom, String? vapidPublicKey
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$InitialResponseCopyWithImpl<$Res>
    implements _$InitialResponseCopyWith<$Res> {
  __$InitialResponseCopyWithImpl(this._self, this._then);

  final _InitialResponse _self;
  final $Res Function(_InitialResponse) _then;

/// Create a copy of InitialResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? communities = null,Object? noUsers = freezed,Object? bannedFrom = freezed,Object? vapidPublicKey = freezed,}) {
  return _then(_InitialResponse(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,noUsers: freezed == noUsers ? _self.noUsers : noUsers // ignore: cast_nullable_to_non_nullable
as int?,bannedFrom: freezed == bannedFrom ? _self._bannedFrom : bannedFrom // ignore: cast_nullable_to_non_nullable
as List<String>?,vapidPublicKey: freezed == vapidPublicKey ? _self.vapidPublicKey : vapidPublicKey // ignore: cast_nullable_to_non_nullable
as String?,
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
}
}

// dart format on
