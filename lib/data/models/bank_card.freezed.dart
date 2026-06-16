// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BankCard {

 String get id; String get accountId; String get brand; String get last4; String get holder; String get expiry; bool get frozen; String get color;
/// Create a copy of BankCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankCardCopyWith<BankCard> get copyWith => _$BankCardCopyWithImpl<BankCard>(this as BankCard, _$identity);

  /// Serializes this BankCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankCard&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.holder, holder) || other.holder == holder)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.frozen, frozen) || other.frozen == frozen)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,brand,last4,holder,expiry,frozen,color);

@override
String toString() {
  return 'BankCard(id: $id, accountId: $accountId, brand: $brand, last4: $last4, holder: $holder, expiry: $expiry, frozen: $frozen, color: $color)';
}


}

/// @nodoc
abstract mixin class $BankCardCopyWith<$Res>  {
  factory $BankCardCopyWith(BankCard value, $Res Function(BankCard) _then) = _$BankCardCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, String brand, String last4, String holder, String expiry, bool frozen, String color
});




}
/// @nodoc
class _$BankCardCopyWithImpl<$Res>
    implements $BankCardCopyWith<$Res> {
  _$BankCardCopyWithImpl(this._self, this._then);

  final BankCard _self;
  final $Res Function(BankCard) _then;

/// Create a copy of BankCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? brand = null,Object? last4 = null,Object? holder = null,Object? expiry = null,Object? frozen = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,holder: null == holder ? _self.holder : holder // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as String,frozen: null == frozen ? _self.frozen : frozen // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BankCard].
extension BankCardPatterns on BankCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankCard value)  $default,){
final _that = this;
switch (_that) {
case _BankCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankCard value)?  $default,){
final _that = this;
switch (_that) {
case _BankCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  String brand,  String last4,  String holder,  String expiry,  bool frozen,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankCard() when $default != null:
return $default(_that.id,_that.accountId,_that.brand,_that.last4,_that.holder,_that.expiry,_that.frozen,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  String brand,  String last4,  String holder,  String expiry,  bool frozen,  String color)  $default,) {final _that = this;
switch (_that) {
case _BankCard():
return $default(_that.id,_that.accountId,_that.brand,_that.last4,_that.holder,_that.expiry,_that.frozen,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  String brand,  String last4,  String holder,  String expiry,  bool frozen,  String color)?  $default,) {final _that = this;
switch (_that) {
case _BankCard() when $default != null:
return $default(_that.id,_that.accountId,_that.brand,_that.last4,_that.holder,_that.expiry,_that.frozen,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BankCard implements BankCard {
  const _BankCard({required this.id, required this.accountId, required this.brand, required this.last4, required this.holder, required this.expiry, required this.frozen, required this.color});
  factory _BankCard.fromJson(Map<String, dynamic> json) => _$BankCardFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  String brand;
@override final  String last4;
@override final  String holder;
@override final  String expiry;
@override final  bool frozen;
@override final  String color;

/// Create a copy of BankCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankCardCopyWith<_BankCard> get copyWith => __$BankCardCopyWithImpl<_BankCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankCard&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.holder, holder) || other.holder == holder)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.frozen, frozen) || other.frozen == frozen)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,brand,last4,holder,expiry,frozen,color);

@override
String toString() {
  return 'BankCard(id: $id, accountId: $accountId, brand: $brand, last4: $last4, holder: $holder, expiry: $expiry, frozen: $frozen, color: $color)';
}


}

/// @nodoc
abstract mixin class _$BankCardCopyWith<$Res> implements $BankCardCopyWith<$Res> {
  factory _$BankCardCopyWith(_BankCard value, $Res Function(_BankCard) _then) = __$BankCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, String brand, String last4, String holder, String expiry, bool frozen, String color
});




}
/// @nodoc
class __$BankCardCopyWithImpl<$Res>
    implements _$BankCardCopyWith<$Res> {
  __$BankCardCopyWithImpl(this._self, this._then);

  final _BankCard _self;
  final $Res Function(_BankCard) _then;

/// Create a copy of BankCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? brand = null,Object? last4 = null,Object? holder = null,Object? expiry = null,Object? frozen = null,Object? color = null,}) {
  return _then(_BankCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,holder: null == holder ? _self.holder : holder // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as String,frozen: null == frozen ? _self.frozen : frozen // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
