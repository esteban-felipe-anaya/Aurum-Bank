// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transfer {

 String get id; String get status; String get fromAccountId; String get toBeneficiaryId; double get amount; double get fee; DateTime get date;
/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferCopyWith<Transfer> get copyWith => _$TransferCopyWithImpl<Transfer>(this as Transfer, _$identity);

  /// Serializes this Transfer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transfer&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toBeneficiaryId, toBeneficiaryId) || other.toBeneficiaryId == toBeneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,fromAccountId,toBeneficiaryId,amount,fee,date);

@override
String toString() {
  return 'Transfer(id: $id, status: $status, fromAccountId: $fromAccountId, toBeneficiaryId: $toBeneficiaryId, amount: $amount, fee: $fee, date: $date)';
}


}

/// @nodoc
abstract mixin class $TransferCopyWith<$Res>  {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) _then) = _$TransferCopyWithImpl;
@useResult
$Res call({
 String id, String status, String fromAccountId, String toBeneficiaryId, double amount, double fee, DateTime date
});




}
/// @nodoc
class _$TransferCopyWithImpl<$Res>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._self, this._then);

  final Transfer _self;
  final $Res Function(Transfer) _then;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? fromAccountId = null,Object? toBeneficiaryId = null,Object? amount = null,Object? fee = null,Object? date = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toBeneficiaryId: null == toBeneficiaryId ? _self.toBeneficiaryId : toBeneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Transfer].
extension TransferPatterns on Transfer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transfer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transfer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transfer value)  $default,){
final _that = this;
switch (_that) {
case _Transfer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transfer value)?  $default,){
final _that = this;
switch (_that) {
case _Transfer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transfer() when $default != null:
return $default(_that.id,_that.status,_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _Transfer():
return $default(_that.id,_that.status,_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _Transfer() when $default != null:
return $default(_that.id,_that.status,_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transfer implements Transfer {
  const _Transfer({required this.id, required this.status, required this.fromAccountId, required this.toBeneficiaryId, required this.amount, required this.fee, required this.date});
  factory _Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);

@override final  String id;
@override final  String status;
@override final  String fromAccountId;
@override final  String toBeneficiaryId;
@override final  double amount;
@override final  double fee;
@override final  DateTime date;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferCopyWith<_Transfer> get copyWith => __$TransferCopyWithImpl<_Transfer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transfer&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toBeneficiaryId, toBeneficiaryId) || other.toBeneficiaryId == toBeneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,fromAccountId,toBeneficiaryId,amount,fee,date);

@override
String toString() {
  return 'Transfer(id: $id, status: $status, fromAccountId: $fromAccountId, toBeneficiaryId: $toBeneficiaryId, amount: $amount, fee: $fee, date: $date)';
}


}

/// @nodoc
abstract mixin class _$TransferCopyWith<$Res> implements $TransferCopyWith<$Res> {
  factory _$TransferCopyWith(_Transfer value, $Res Function(_Transfer) _then) = __$TransferCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, String fromAccountId, String toBeneficiaryId, double amount, double fee, DateTime date
});




}
/// @nodoc
class __$TransferCopyWithImpl<$Res>
    implements _$TransferCopyWith<$Res> {
  __$TransferCopyWithImpl(this._self, this._then);

  final _Transfer _self;
  final $Res Function(_Transfer) _then;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? fromAccountId = null,Object? toBeneficiaryId = null,Object? amount = null,Object? fee = null,Object? date = null,}) {
  return _then(_Transfer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toBeneficiaryId: null == toBeneficiaryId ? _self.toBeneficiaryId : toBeneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TransferRequest {

 String get fromAccountId; String get toBeneficiaryId; double get amount; double get fee; String? get note;
/// Create a copy of TransferRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferRequestCopyWith<TransferRequest> get copyWith => _$TransferRequestCopyWithImpl<TransferRequest>(this as TransferRequest, _$identity);

  /// Serializes this TransferRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferRequest&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toBeneficiaryId, toBeneficiaryId) || other.toBeneficiaryId == toBeneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAccountId,toBeneficiaryId,amount,fee,note);

@override
String toString() {
  return 'TransferRequest(fromAccountId: $fromAccountId, toBeneficiaryId: $toBeneficiaryId, amount: $amount, fee: $fee, note: $note)';
}


}

/// @nodoc
abstract mixin class $TransferRequestCopyWith<$Res>  {
  factory $TransferRequestCopyWith(TransferRequest value, $Res Function(TransferRequest) _then) = _$TransferRequestCopyWithImpl;
@useResult
$Res call({
 String fromAccountId, String toBeneficiaryId, double amount, double fee, String? note
});




}
/// @nodoc
class _$TransferRequestCopyWithImpl<$Res>
    implements $TransferRequestCopyWith<$Res> {
  _$TransferRequestCopyWithImpl(this._self, this._then);

  final TransferRequest _self;
  final $Res Function(TransferRequest) _then;

/// Create a copy of TransferRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromAccountId = null,Object? toBeneficiaryId = null,Object? amount = null,Object? fee = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toBeneficiaryId: null == toBeneficiaryId ? _self.toBeneficiaryId : toBeneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferRequest].
extension TransferRequestPatterns on TransferRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferRequest value)  $default,){
final _that = this;
switch (_that) {
case _TransferRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TransferRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferRequest() when $default != null:
return $default(_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TransferRequest():
return $default(_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fromAccountId,  String toBeneficiaryId,  double amount,  double fee,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TransferRequest() when $default != null:
return $default(_that.fromAccountId,_that.toBeneficiaryId,_that.amount,_that.fee,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferRequest implements TransferRequest {
  const _TransferRequest({required this.fromAccountId, required this.toBeneficiaryId, required this.amount, required this.fee, this.note});
  factory _TransferRequest.fromJson(Map<String, dynamic> json) => _$TransferRequestFromJson(json);

@override final  String fromAccountId;
@override final  String toBeneficiaryId;
@override final  double amount;
@override final  double fee;
@override final  String? note;

/// Create a copy of TransferRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferRequestCopyWith<_TransferRequest> get copyWith => __$TransferRequestCopyWithImpl<_TransferRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferRequest&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toBeneficiaryId, toBeneficiaryId) || other.toBeneficiaryId == toBeneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAccountId,toBeneficiaryId,amount,fee,note);

@override
String toString() {
  return 'TransferRequest(fromAccountId: $fromAccountId, toBeneficiaryId: $toBeneficiaryId, amount: $amount, fee: $fee, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransferRequestCopyWith<$Res> implements $TransferRequestCopyWith<$Res> {
  factory _$TransferRequestCopyWith(_TransferRequest value, $Res Function(_TransferRequest) _then) = __$TransferRequestCopyWithImpl;
@override @useResult
$Res call({
 String fromAccountId, String toBeneficiaryId, double amount, double fee, String? note
});




}
/// @nodoc
class __$TransferRequestCopyWithImpl<$Res>
    implements _$TransferRequestCopyWith<$Res> {
  __$TransferRequestCopyWithImpl(this._self, this._then);

  final _TransferRequest _self;
  final $Res Function(_TransferRequest) _then;

/// Create a copy of TransferRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromAccountId = null,Object? toBeneficiaryId = null,Object? amount = null,Object? fee = null,Object? note = freezed,}) {
  return _then(_TransferRequest(
fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toBeneficiaryId: null == toBeneficiaryId ? _self.toBeneficiaryId : toBeneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
