// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discuit_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscuitImage {

 String get id; String get format; String get mimetype; int get width; int get height; int get size; String? get averageColor; String get url; List<ImageCopy> get copies;
/// Create a copy of DiscuitImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscuitImageCopyWith<DiscuitImage> get copyWith => _$DiscuitImageCopyWithImpl<DiscuitImage>(this as DiscuitImage, _$identity);

  /// Serializes this DiscuitImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscuitImage&&(identical(other.id, id) || other.id == id)&&(identical(other.format, format) || other.format == format)&&(identical(other.mimetype, mimetype) || other.mimetype == mimetype)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size)&&(identical(other.averageColor, averageColor) || other.averageColor == averageColor)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.copies, copies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,format,mimetype,width,height,size,averageColor,url,const DeepCollectionEquality().hash(copies));

@override
String toString() {
  return 'DiscuitImage(id: $id, format: $format, mimetype: $mimetype, width: $width, height: $height, size: $size, averageColor: $averageColor, url: $url, copies: $copies)';
}


}

/// @nodoc
abstract mixin class $DiscuitImageCopyWith<$Res>  {
  factory $DiscuitImageCopyWith(DiscuitImage value, $Res Function(DiscuitImage) _then) = _$DiscuitImageCopyWithImpl;
@useResult
$Res call({
 String id, String format, String mimetype, int width, int height, int size, String? averageColor, String url, List<ImageCopy> copies
});




}
/// @nodoc
class _$DiscuitImageCopyWithImpl<$Res>
    implements $DiscuitImageCopyWith<$Res> {
  _$DiscuitImageCopyWithImpl(this._self, this._then);

  final DiscuitImage _self;
  final $Res Function(DiscuitImage) _then;

/// Create a copy of DiscuitImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? format = null,Object? mimetype = null,Object? width = null,Object? height = null,Object? size = null,Object? averageColor = freezed,Object? url = null,Object? copies = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,mimetype: null == mimetype ? _self.mimetype : mimetype // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,averageColor: freezed == averageColor ? _self.averageColor : averageColor // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,copies: null == copies ? _self.copies : copies // ignore: cast_nullable_to_non_nullable
as List<ImageCopy>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscuitImage].
extension DiscuitImagePatterns on DiscuitImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscuitImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscuitImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscuitImage value)  $default,){
final _that = this;
switch (_that) {
case _DiscuitImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscuitImage value)?  $default,){
final _that = this;
switch (_that) {
case _DiscuitImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String format,  String mimetype,  int width,  int height,  int size,  String? averageColor,  String url,  List<ImageCopy> copies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscuitImage() when $default != null:
return $default(_that.id,_that.format,_that.mimetype,_that.width,_that.height,_that.size,_that.averageColor,_that.url,_that.copies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String format,  String mimetype,  int width,  int height,  int size,  String? averageColor,  String url,  List<ImageCopy> copies)  $default,) {final _that = this;
switch (_that) {
case _DiscuitImage():
return $default(_that.id,_that.format,_that.mimetype,_that.width,_that.height,_that.size,_that.averageColor,_that.url,_that.copies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String format,  String mimetype,  int width,  int height,  int size,  String? averageColor,  String url,  List<ImageCopy> copies)?  $default,) {final _that = this;
switch (_that) {
case _DiscuitImage() when $default != null:
return $default(_that.id,_that.format,_that.mimetype,_that.width,_that.height,_that.size,_that.averageColor,_that.url,_that.copies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscuitImage implements DiscuitImage {
  const _DiscuitImage({required this.id, required this.format, required this.mimetype, required this.width, required this.height, required this.size, this.averageColor, required this.url, final  List<ImageCopy> copies = const []}): _copies = copies;
  factory _DiscuitImage.fromJson(Map<String, dynamic> json) => _$DiscuitImageFromJson(json);

@override final  String id;
@override final  String format;
@override final  String mimetype;
@override final  int width;
@override final  int height;
@override final  int size;
@override final  String? averageColor;
@override final  String url;
 final  List<ImageCopy> _copies;
@override@JsonKey() List<ImageCopy> get copies {
  if (_copies is EqualUnmodifiableListView) return _copies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_copies);
}


/// Create a copy of DiscuitImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscuitImageCopyWith<_DiscuitImage> get copyWith => __$DiscuitImageCopyWithImpl<_DiscuitImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscuitImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscuitImage&&(identical(other.id, id) || other.id == id)&&(identical(other.format, format) || other.format == format)&&(identical(other.mimetype, mimetype) || other.mimetype == mimetype)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.size, size) || other.size == size)&&(identical(other.averageColor, averageColor) || other.averageColor == averageColor)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._copies, _copies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,format,mimetype,width,height,size,averageColor,url,const DeepCollectionEquality().hash(_copies));

@override
String toString() {
  return 'DiscuitImage(id: $id, format: $format, mimetype: $mimetype, width: $width, height: $height, size: $size, averageColor: $averageColor, url: $url, copies: $copies)';
}


}

/// @nodoc
abstract mixin class _$DiscuitImageCopyWith<$Res> implements $DiscuitImageCopyWith<$Res> {
  factory _$DiscuitImageCopyWith(_DiscuitImage value, $Res Function(_DiscuitImage) _then) = __$DiscuitImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String format, String mimetype, int width, int height, int size, String? averageColor, String url, List<ImageCopy> copies
});




}
/// @nodoc
class __$DiscuitImageCopyWithImpl<$Res>
    implements _$DiscuitImageCopyWith<$Res> {
  __$DiscuitImageCopyWithImpl(this._self, this._then);

  final _DiscuitImage _self;
  final $Res Function(_DiscuitImage) _then;

/// Create a copy of DiscuitImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? format = null,Object? mimetype = null,Object? width = null,Object? height = null,Object? size = null,Object? averageColor = freezed,Object? url = null,Object? copies = null,}) {
  return _then(_DiscuitImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,mimetype: null == mimetype ? _self.mimetype : mimetype // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,averageColor: freezed == averageColor ? _self.averageColor : averageColor // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,copies: null == copies ? _self._copies : copies // ignore: cast_nullable_to_non_nullable
as List<ImageCopy>,
  ));
}


}


/// @nodoc
mixin _$ImageCopy {

 String? get name; int get width; int get height; int get boxWidth; int get boxHeight; String get objectFit; String get format; String get url;
/// Create a copy of ImageCopy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCopyCopyWith<ImageCopy> get copyWith => _$ImageCopyCopyWithImpl<ImageCopy>(this as ImageCopy, _$identity);

  /// Serializes this ImageCopy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCopy&&(identical(other.name, name) || other.name == name)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.boxWidth, boxWidth) || other.boxWidth == boxWidth)&&(identical(other.boxHeight, boxHeight) || other.boxHeight == boxHeight)&&(identical(other.objectFit, objectFit) || other.objectFit == objectFit)&&(identical(other.format, format) || other.format == format)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,width,height,boxWidth,boxHeight,objectFit,format,url);

@override
String toString() {
  return 'ImageCopy(name: $name, width: $width, height: $height, boxWidth: $boxWidth, boxHeight: $boxHeight, objectFit: $objectFit, format: $format, url: $url)';
}


}

/// @nodoc
abstract mixin class $ImageCopyCopyWith<$Res>  {
  factory $ImageCopyCopyWith(ImageCopy value, $Res Function(ImageCopy) _then) = _$ImageCopyCopyWithImpl;
@useResult
$Res call({
 String? name, int width, int height, int boxWidth, int boxHeight, String objectFit, String format, String url
});




}
/// @nodoc
class _$ImageCopyCopyWithImpl<$Res>
    implements $ImageCopyCopyWith<$Res> {
  _$ImageCopyCopyWithImpl(this._self, this._then);

  final ImageCopy _self;
  final $Res Function(ImageCopy) _then;

/// Create a copy of ImageCopy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? width = null,Object? height = null,Object? boxWidth = null,Object? boxHeight = null,Object? objectFit = null,Object? format = null,Object? url = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,boxWidth: null == boxWidth ? _self.boxWidth : boxWidth // ignore: cast_nullable_to_non_nullable
as int,boxHeight: null == boxHeight ? _self.boxHeight : boxHeight // ignore: cast_nullable_to_non_nullable
as int,objectFit: null == objectFit ? _self.objectFit : objectFit // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageCopy].
extension ImageCopyPatterns on ImageCopy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageCopy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageCopy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageCopy value)  $default,){
final _that = this;
switch (_that) {
case _ImageCopy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageCopy value)?  $default,){
final _that = this;
switch (_that) {
case _ImageCopy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  int width,  int height,  int boxWidth,  int boxHeight,  String objectFit,  String format,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageCopy() when $default != null:
return $default(_that.name,_that.width,_that.height,_that.boxWidth,_that.boxHeight,_that.objectFit,_that.format,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  int width,  int height,  int boxWidth,  int boxHeight,  String objectFit,  String format,  String url)  $default,) {final _that = this;
switch (_that) {
case _ImageCopy():
return $default(_that.name,_that.width,_that.height,_that.boxWidth,_that.boxHeight,_that.objectFit,_that.format,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  int width,  int height,  int boxWidth,  int boxHeight,  String objectFit,  String format,  String url)?  $default,) {final _that = this;
switch (_that) {
case _ImageCopy() when $default != null:
return $default(_that.name,_that.width,_that.height,_that.boxWidth,_that.boxHeight,_that.objectFit,_that.format,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageCopy implements ImageCopy {
  const _ImageCopy({this.name, required this.width, required this.height, required this.boxWidth, required this.boxHeight, required this.objectFit, required this.format, required this.url});
  factory _ImageCopy.fromJson(Map<String, dynamic> json) => _$ImageCopyFromJson(json);

@override final  String? name;
@override final  int width;
@override final  int height;
@override final  int boxWidth;
@override final  int boxHeight;
@override final  String objectFit;
@override final  String format;
@override final  String url;

/// Create a copy of ImageCopy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCopyCopyWith<_ImageCopy> get copyWith => __$ImageCopyCopyWithImpl<_ImageCopy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageCopyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCopy&&(identical(other.name, name) || other.name == name)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.boxWidth, boxWidth) || other.boxWidth == boxWidth)&&(identical(other.boxHeight, boxHeight) || other.boxHeight == boxHeight)&&(identical(other.objectFit, objectFit) || other.objectFit == objectFit)&&(identical(other.format, format) || other.format == format)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,width,height,boxWidth,boxHeight,objectFit,format,url);

@override
String toString() {
  return 'ImageCopy(name: $name, width: $width, height: $height, boxWidth: $boxWidth, boxHeight: $boxHeight, objectFit: $objectFit, format: $format, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ImageCopyCopyWith<$Res> implements $ImageCopyCopyWith<$Res> {
  factory _$ImageCopyCopyWith(_ImageCopy value, $Res Function(_ImageCopy) _then) = __$ImageCopyCopyWithImpl;
@override @useResult
$Res call({
 String? name, int width, int height, int boxWidth, int boxHeight, String objectFit, String format, String url
});




}
/// @nodoc
class __$ImageCopyCopyWithImpl<$Res>
    implements _$ImageCopyCopyWith<$Res> {
  __$ImageCopyCopyWithImpl(this._self, this._then);

  final _ImageCopy _self;
  final $Res Function(_ImageCopy) _then;

/// Create a copy of ImageCopy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? width = null,Object? height = null,Object? boxWidth = null,Object? boxHeight = null,Object? objectFit = null,Object? format = null,Object? url = null,}) {
  return _then(_ImageCopy(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,boxWidth: null == boxWidth ? _self.boxWidth : boxWidth // ignore: cast_nullable_to_non_nullable
as int,boxHeight: null == boxHeight ? _self.boxHeight : boxHeight // ignore: cast_nullable_to_non_nullable
as int,objectFit: null == objectFit ? _self.objectFit : objectFit // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
