// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Biller {

 String get id; String get name; String get category; String get icon;@JsonKey(name: 'accountMasked') String get accountMasked;
/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillerCopyWith<Biller> get copyWith => _$BillerCopyWithImpl<Biller>(this as Biller, _$identity);

  /// Serializes this Biller to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Biller&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.accountMasked, accountMasked) || other.accountMasked == accountMasked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,icon,accountMasked);

@override
String toString() {
  return 'Biller(id: $id, name: $name, category: $category, icon: $icon, accountMasked: $accountMasked)';
}


}

/// @nodoc
abstract mixin class $BillerCopyWith<$Res>  {
  factory $BillerCopyWith(Biller value, $Res Function(Biller) _then) = _$BillerCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String icon,@JsonKey(name: 'accountMasked') String accountMasked
});




}
/// @nodoc
class _$BillerCopyWithImpl<$Res>
    implements $BillerCopyWith<$Res> {
  _$BillerCopyWithImpl(this._self, this._then);

  final Biller _self;
  final $Res Function(Biller) _then;

/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? icon = null,Object? accountMasked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,accountMasked: null == accountMasked ? _self.accountMasked : accountMasked // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Biller].
extension BillerPatterns on Biller {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Biller value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Biller() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Biller value)  $default,){
final _that = this;
switch (_that) {
case _Biller():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Biller value)?  $default,){
final _that = this;
switch (_that) {
case _Biller() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String icon, @JsonKey(name: 'accountMasked')  String accountMasked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.icon,_that.accountMasked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String icon, @JsonKey(name: 'accountMasked')  String accountMasked)  $default,) {final _that = this;
switch (_that) {
case _Biller():
return $default(_that.id,_that.name,_that.category,_that.icon,_that.accountMasked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String icon, @JsonKey(name: 'accountMasked')  String accountMasked)?  $default,) {final _that = this;
switch (_that) {
case _Biller() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.icon,_that.accountMasked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Biller implements Biller {
  const _Biller({required this.id, required this.name, required this.category, required this.icon, @JsonKey(name: 'accountMasked') required this.accountMasked});
  factory _Biller.fromJson(Map<String, dynamic> json) => _$BillerFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String icon;
@override@JsonKey(name: 'accountMasked') final  String accountMasked;

/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillerCopyWith<_Biller> get copyWith => __$BillerCopyWithImpl<_Biller>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Biller&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.accountMasked, accountMasked) || other.accountMasked == accountMasked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,icon,accountMasked);

@override
String toString() {
  return 'Biller(id: $id, name: $name, category: $category, icon: $icon, accountMasked: $accountMasked)';
}


}

/// @nodoc
abstract mixin class _$BillerCopyWith<$Res> implements $BillerCopyWith<$Res> {
  factory _$BillerCopyWith(_Biller value, $Res Function(_Biller) _then) = __$BillerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String icon,@JsonKey(name: 'accountMasked') String accountMasked
});




}
/// @nodoc
class __$BillerCopyWithImpl<$Res>
    implements _$BillerCopyWith<$Res> {
  __$BillerCopyWithImpl(this._self, this._then);

  final _Biller _self;
  final $Res Function(_Biller) _then;

/// Create a copy of Biller
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? icon = null,Object? accountMasked = null,}) {
  return _then(_Biller(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,accountMasked: null == accountMasked ? _self.accountMasked : accountMasked // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
