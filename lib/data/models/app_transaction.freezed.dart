// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppTransaction {

 String get id; String get accountId; String get title; String get merchant; String get category; double get amount; String get currency; TransactionType get type; TransactionStatus get status; DateTime get date;
/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppTransactionCopyWith<AppTransaction> get copyWith => _$AppTransactionCopyWithImpl<AppTransaction>(this as AppTransaction, _$identity);

  /// Serializes this AppTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.title, title) || other.title == title)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,title,merchant,category,amount,currency,type,status,date);

@override
String toString() {
  return 'AppTransaction(id: $id, accountId: $accountId, title: $title, merchant: $merchant, category: $category, amount: $amount, currency: $currency, type: $type, status: $status, date: $date)';
}


}

/// @nodoc
abstract mixin class $AppTransactionCopyWith<$Res>  {
  factory $AppTransactionCopyWith(AppTransaction value, $Res Function(AppTransaction) _then) = _$AppTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, String title, String merchant, String category, double amount, String currency, TransactionType type, TransactionStatus status, DateTime date
});




}
/// @nodoc
class _$AppTransactionCopyWithImpl<$Res>
    implements $AppTransactionCopyWith<$Res> {
  _$AppTransactionCopyWithImpl(this._self, this._then);

  final AppTransaction _self;
  final $Res Function(AppTransaction) _then;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? title = null,Object? merchant = null,Object? category = null,Object? amount = null,Object? currency = null,Object? type = null,Object? status = null,Object? date = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AppTransaction].
extension AppTransactionPatterns on AppTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppTransaction value)  $default,){
final _that = this;
switch (_that) {
case _AppTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  String title,  String merchant,  String category,  double amount,  String currency,  TransactionType type,  TransactionStatus status,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
return $default(_that.id,_that.accountId,_that.title,_that.merchant,_that.category,_that.amount,_that.currency,_that.type,_that.status,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  String title,  String merchant,  String category,  double amount,  String currency,  TransactionType type,  TransactionStatus status,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _AppTransaction():
return $default(_that.id,_that.accountId,_that.title,_that.merchant,_that.category,_that.amount,_that.currency,_that.type,_that.status,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  String title,  String merchant,  String category,  double amount,  String currency,  TransactionType type,  TransactionStatus status,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _AppTransaction() when $default != null:
return $default(_that.id,_that.accountId,_that.title,_that.merchant,_that.category,_that.amount,_that.currency,_that.type,_that.status,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppTransaction implements AppTransaction {
  const _AppTransaction({required this.id, required this.accountId, required this.title, required this.merchant, required this.category, required this.amount, required this.currency, required this.type, required this.status, required this.date});
  factory _AppTransaction.fromJson(Map<String, dynamic> json) => _$AppTransactionFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  String title;
@override final  String merchant;
@override final  String category;
@override final  double amount;
@override final  String currency;
@override final  TransactionType type;
@override final  TransactionStatus status;
@override final  DateTime date;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppTransactionCopyWith<_AppTransaction> get copyWith => __$AppTransactionCopyWithImpl<_AppTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.title, title) || other.title == title)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,title,merchant,category,amount,currency,type,status,date);

@override
String toString() {
  return 'AppTransaction(id: $id, accountId: $accountId, title: $title, merchant: $merchant, category: $category, amount: $amount, currency: $currency, type: $type, status: $status, date: $date)';
}


}

/// @nodoc
abstract mixin class _$AppTransactionCopyWith<$Res> implements $AppTransactionCopyWith<$Res> {
  factory _$AppTransactionCopyWith(_AppTransaction value, $Res Function(_AppTransaction) _then) = __$AppTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, String title, String merchant, String category, double amount, String currency, TransactionType type, TransactionStatus status, DateTime date
});




}
/// @nodoc
class __$AppTransactionCopyWithImpl<$Res>
    implements _$AppTransactionCopyWith<$Res> {
  __$AppTransactionCopyWithImpl(this._self, this._then);

  final _AppTransaction _self;
  final $Res Function(_AppTransaction) _then;

/// Create a copy of AppTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? title = null,Object? merchant = null,Object? category = null,Object? amount = null,Object? currency = null,Object? type = null,Object? status = null,Object? date = null,}) {
  return _then(_AppTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
