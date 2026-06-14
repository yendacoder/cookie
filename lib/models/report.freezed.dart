// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Report {

 int get id; String get communityId; String? get postId; String get reason; String? get description; int get reasonId; String get type;// "post" or "comment"
 String get targetId; String? get actionTaken; DateTime? get dealtAt; String? get dealtBy; DateTime get createdAt; Map<String, dynamic>? get target;
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCopyWith<Report> get copyWith => _$ReportCopyWithImpl<Report>(this as Report, _$identity);

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Report&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.reasonId, reasonId) || other.reasonId == reasonId)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.dealtAt, dealtAt) || other.dealtAt == dealtAt)&&(identical(other.dealtBy, dealtBy) || other.dealtBy == dealtBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.target, target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,postId,reason,description,reasonId,type,targetId,actionTaken,dealtAt,dealtBy,createdAt,const DeepCollectionEquality().hash(target));

@override
String toString() {
  return 'Report(id: $id, communityId: $communityId, postId: $postId, reason: $reason, description: $description, reasonId: $reasonId, type: $type, targetId: $targetId, actionTaken: $actionTaken, dealtAt: $dealtAt, dealtBy: $dealtBy, createdAt: $createdAt, target: $target)';
}


}

/// @nodoc
abstract mixin class $ReportCopyWith<$Res>  {
  factory $ReportCopyWith(Report value, $Res Function(Report) _then) = _$ReportCopyWithImpl;
@useResult
$Res call({
 int id, String communityId, String? postId, String reason, String? description, int reasonId, String type, String targetId, String? actionTaken, DateTime? dealtAt, String? dealtBy, DateTime createdAt, Map<String, dynamic>? target
});




}
/// @nodoc
class _$ReportCopyWithImpl<$Res>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._self, this._then);

  final Report _self;
  final $Res Function(Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? postId = freezed,Object? reason = null,Object? description = freezed,Object? reasonId = null,Object? type = null,Object? targetId = null,Object? actionTaken = freezed,Object? dealtAt = freezed,Object? dealtBy = freezed,Object? createdAt = null,Object? target = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,postId: freezed == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reasonId: null == reasonId ? _self.reasonId : reasonId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,actionTaken: freezed == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as String?,dealtAt: freezed == dealtAt ? _self.dealtAt : dealtAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dealtBy: freezed == dealtBy ? _self.dealtBy : dealtBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Report].
extension ReportPatterns on Report {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Report value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Report() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Report value)  $default,){
final _that = this;
switch (_that) {
case _Report():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Report value)?  $default,){
final _that = this;
switch (_that) {
case _Report() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String communityId,  String? postId,  String reason,  String? description,  int reasonId,  String type,  String targetId,  String? actionTaken,  DateTime? dealtAt,  String? dealtBy,  DateTime createdAt,  Map<String, dynamic>? target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.communityId,_that.postId,_that.reason,_that.description,_that.reasonId,_that.type,_that.targetId,_that.actionTaken,_that.dealtAt,_that.dealtBy,_that.createdAt,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String communityId,  String? postId,  String reason,  String? description,  int reasonId,  String type,  String targetId,  String? actionTaken,  DateTime? dealtAt,  String? dealtBy,  DateTime createdAt,  Map<String, dynamic>? target)  $default,) {final _that = this;
switch (_that) {
case _Report():
return $default(_that.id,_that.communityId,_that.postId,_that.reason,_that.description,_that.reasonId,_that.type,_that.targetId,_that.actionTaken,_that.dealtAt,_that.dealtBy,_that.createdAt,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String communityId,  String? postId,  String reason,  String? description,  int reasonId,  String type,  String targetId,  String? actionTaken,  DateTime? dealtAt,  String? dealtBy,  DateTime createdAt,  Map<String, dynamic>? target)?  $default,) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.communityId,_that.postId,_that.reason,_that.description,_that.reasonId,_that.type,_that.targetId,_that.actionTaken,_that.dealtAt,_that.dealtBy,_that.createdAt,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Report implements Report {
  const _Report({required this.id, required this.communityId, this.postId, required this.reason, this.description, required this.reasonId, required this.type, required this.targetId, this.actionTaken, this.dealtAt, this.dealtBy, required this.createdAt, final  Map<String, dynamic>? target}): _target = target;
  factory _Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

@override final  int id;
@override final  String communityId;
@override final  String? postId;
@override final  String reason;
@override final  String? description;
@override final  int reasonId;
@override final  String type;
// "post" or "comment"
@override final  String targetId;
@override final  String? actionTaken;
@override final  DateTime? dealtAt;
@override final  String? dealtBy;
@override final  DateTime createdAt;
 final  Map<String, dynamic>? _target;
@override Map<String, dynamic>? get target {
  final value = _target;
  if (value == null) return null;
  if (_target is EqualUnmodifiableMapView) return _target;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCopyWith<_Report> get copyWith => __$ReportCopyWithImpl<_Report>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Report&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.reasonId, reasonId) || other.reasonId == reasonId)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.dealtAt, dealtAt) || other.dealtAt == dealtAt)&&(identical(other.dealtBy, dealtBy) || other.dealtBy == dealtBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._target, _target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,postId,reason,description,reasonId,type,targetId,actionTaken,dealtAt,dealtBy,createdAt,const DeepCollectionEquality().hash(_target));

@override
String toString() {
  return 'Report(id: $id, communityId: $communityId, postId: $postId, reason: $reason, description: $description, reasonId: $reasonId, type: $type, targetId: $targetId, actionTaken: $actionTaken, dealtAt: $dealtAt, dealtBy: $dealtBy, createdAt: $createdAt, target: $target)';
}


}

/// @nodoc
abstract mixin class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) _then) = __$ReportCopyWithImpl;
@override @useResult
$Res call({
 int id, String communityId, String? postId, String reason, String? description, int reasonId, String type, String targetId, String? actionTaken, DateTime? dealtAt, String? dealtBy, DateTime createdAt, Map<String, dynamic>? target
});




}
/// @nodoc
class __$ReportCopyWithImpl<$Res>
    implements _$ReportCopyWith<$Res> {
  __$ReportCopyWithImpl(this._self, this._then);

  final _Report _self;
  final $Res Function(_Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? postId = freezed,Object? reason = null,Object? description = freezed,Object? reasonId = null,Object? type = null,Object? targetId = null,Object? actionTaken = freezed,Object? dealtAt = freezed,Object? dealtBy = freezed,Object? createdAt = null,Object? target = freezed,}) {
  return _then(_Report(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,postId: freezed == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,reasonId: null == reasonId ? _self.reasonId : reasonId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,actionTaken: freezed == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as String?,dealtAt: freezed == dealtAt ? _self.dealtAt : dealtAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dealtBy: freezed == dealtBy ? _self.dealtBy : dealtBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,target: freezed == target ? _self._target : target // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$CommunityReportsDetails {

@JsonKey(name: 'noReports') int get numReports;@JsonKey(name: 'noPostReports') int get numPostReports;@JsonKey(name: 'noCommentReports') int get numCommentReports;
/// Create a copy of CommunityReportsDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityReportsDetailsCopyWith<CommunityReportsDetails> get copyWith => _$CommunityReportsDetailsCopyWithImpl<CommunityReportsDetails>(this as CommunityReportsDetails, _$identity);

  /// Serializes this CommunityReportsDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityReportsDetails&&(identical(other.numReports, numReports) || other.numReports == numReports)&&(identical(other.numPostReports, numPostReports) || other.numPostReports == numPostReports)&&(identical(other.numCommentReports, numCommentReports) || other.numCommentReports == numCommentReports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numReports,numPostReports,numCommentReports);

@override
String toString() {
  return 'CommunityReportsDetails(numReports: $numReports, numPostReports: $numPostReports, numCommentReports: $numCommentReports)';
}


}

/// @nodoc
abstract mixin class $CommunityReportsDetailsCopyWith<$Res>  {
  factory $CommunityReportsDetailsCopyWith(CommunityReportsDetails value, $Res Function(CommunityReportsDetails) _then) = _$CommunityReportsDetailsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'noReports') int numReports,@JsonKey(name: 'noPostReports') int numPostReports,@JsonKey(name: 'noCommentReports') int numCommentReports
});




}
/// @nodoc
class _$CommunityReportsDetailsCopyWithImpl<$Res>
    implements $CommunityReportsDetailsCopyWith<$Res> {
  _$CommunityReportsDetailsCopyWithImpl(this._self, this._then);

  final CommunityReportsDetails _self;
  final $Res Function(CommunityReportsDetails) _then;

/// Create a copy of CommunityReportsDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? numReports = null,Object? numPostReports = null,Object? numCommentReports = null,}) {
  return _then(_self.copyWith(
numReports: null == numReports ? _self.numReports : numReports // ignore: cast_nullable_to_non_nullable
as int,numPostReports: null == numPostReports ? _self.numPostReports : numPostReports // ignore: cast_nullable_to_non_nullable
as int,numCommentReports: null == numCommentReports ? _self.numCommentReports : numCommentReports // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityReportsDetails].
extension CommunityReportsDetailsPatterns on CommunityReportsDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityReportsDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityReportsDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityReportsDetails value)  $default,){
final _that = this;
switch (_that) {
case _CommunityReportsDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityReportsDetails value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityReportsDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'noReports')  int numReports, @JsonKey(name: 'noPostReports')  int numPostReports, @JsonKey(name: 'noCommentReports')  int numCommentReports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityReportsDetails() when $default != null:
return $default(_that.numReports,_that.numPostReports,_that.numCommentReports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'noReports')  int numReports, @JsonKey(name: 'noPostReports')  int numPostReports, @JsonKey(name: 'noCommentReports')  int numCommentReports)  $default,) {final _that = this;
switch (_that) {
case _CommunityReportsDetails():
return $default(_that.numReports,_that.numPostReports,_that.numCommentReports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'noReports')  int numReports, @JsonKey(name: 'noPostReports')  int numPostReports, @JsonKey(name: 'noCommentReports')  int numCommentReports)?  $default,) {final _that = this;
switch (_that) {
case _CommunityReportsDetails() when $default != null:
return $default(_that.numReports,_that.numPostReports,_that.numCommentReports);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityReportsDetails implements CommunityReportsDetails {
  const _CommunityReportsDetails({@JsonKey(name: 'noReports') required this.numReports, @JsonKey(name: 'noPostReports') required this.numPostReports, @JsonKey(name: 'noCommentReports') required this.numCommentReports});
  factory _CommunityReportsDetails.fromJson(Map<String, dynamic> json) => _$CommunityReportsDetailsFromJson(json);

@override@JsonKey(name: 'noReports') final  int numReports;
@override@JsonKey(name: 'noPostReports') final  int numPostReports;
@override@JsonKey(name: 'noCommentReports') final  int numCommentReports;

/// Create a copy of CommunityReportsDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityReportsDetailsCopyWith<_CommunityReportsDetails> get copyWith => __$CommunityReportsDetailsCopyWithImpl<_CommunityReportsDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityReportsDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityReportsDetails&&(identical(other.numReports, numReports) || other.numReports == numReports)&&(identical(other.numPostReports, numPostReports) || other.numPostReports == numPostReports)&&(identical(other.numCommentReports, numCommentReports) || other.numCommentReports == numCommentReports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numReports,numPostReports,numCommentReports);

@override
String toString() {
  return 'CommunityReportsDetails(numReports: $numReports, numPostReports: $numPostReports, numCommentReports: $numCommentReports)';
}


}

/// @nodoc
abstract mixin class _$CommunityReportsDetailsCopyWith<$Res> implements $CommunityReportsDetailsCopyWith<$Res> {
  factory _$CommunityReportsDetailsCopyWith(_CommunityReportsDetails value, $Res Function(_CommunityReportsDetails) _then) = __$CommunityReportsDetailsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'noReports') int numReports,@JsonKey(name: 'noPostReports') int numPostReports,@JsonKey(name: 'noCommentReports') int numCommentReports
});




}
/// @nodoc
class __$CommunityReportsDetailsCopyWithImpl<$Res>
    implements _$CommunityReportsDetailsCopyWith<$Res> {
  __$CommunityReportsDetailsCopyWithImpl(this._self, this._then);

  final _CommunityReportsDetails _self;
  final $Res Function(_CommunityReportsDetails) _then;

/// Create a copy of CommunityReportsDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numReports = null,Object? numPostReports = null,Object? numCommentReports = null,}) {
  return _then(_CommunityReportsDetails(
numReports: null == numReports ? _self.numReports : numReports // ignore: cast_nullable_to_non_nullable
as int,numPostReports: null == numPostReports ? _self.numPostReports : numPostReports // ignore: cast_nullable_to_non_nullable
as int,numCommentReports: null == numCommentReports ? _self.numCommentReports : numCommentReports // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
