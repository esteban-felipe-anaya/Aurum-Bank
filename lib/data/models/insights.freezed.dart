// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insights.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategorySpend {

 String get category; double get amount; String get color;
/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySpendCopyWith<CategorySpend> get copyWith => _$CategorySpendCopyWithImpl<CategorySpend>(this as CategorySpend, _$identity);

  /// Serializes this CategorySpend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySpend&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amount,color);

@override
String toString() {
  return 'CategorySpend(category: $category, amount: $amount, color: $color)';
}


}

/// @nodoc
abstract mixin class $CategorySpendCopyWith<$Res>  {
  factory $CategorySpendCopyWith(CategorySpend value, $Res Function(CategorySpend) _then) = _$CategorySpendCopyWithImpl;
@useResult
$Res call({
 String category, double amount, String color
});




}
/// @nodoc
class _$CategorySpendCopyWithImpl<$Res>
    implements $CategorySpendCopyWith<$Res> {
  _$CategorySpendCopyWithImpl(this._self, this._then);

  final CategorySpend _self;
  final $Res Function(CategorySpend) _then;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? amount = null,Object? color = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CategorySpend].
extension CategorySpendPatterns on CategorySpend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorySpend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorySpend value)  $default,){
final _that = this;
switch (_that) {
case _CategorySpend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorySpend value)?  $default,){
final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  double amount,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
return $default(_that.category,_that.amount,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  double amount,  String color)  $default,) {final _that = this;
switch (_that) {
case _CategorySpend():
return $default(_that.category,_that.amount,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  double amount,  String color)?  $default,) {final _that = this;
switch (_that) {
case _CategorySpend() when $default != null:
return $default(_that.category,_that.amount,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategorySpend implements CategorySpend {
  const _CategorySpend({required this.category, required this.amount, required this.color});
  factory _CategorySpend.fromJson(Map<String, dynamic> json) => _$CategorySpendFromJson(json);

@override final  String category;
@override final  double amount;
@override final  String color;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorySpendCopyWith<_CategorySpend> get copyWith => __$CategorySpendCopyWithImpl<_CategorySpend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorySpendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorySpend&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,amount,color);

@override
String toString() {
  return 'CategorySpend(category: $category, amount: $amount, color: $color)';
}


}

/// @nodoc
abstract mixin class _$CategorySpendCopyWith<$Res> implements $CategorySpendCopyWith<$Res> {
  factory _$CategorySpendCopyWith(_CategorySpend value, $Res Function(_CategorySpend) _then) = __$CategorySpendCopyWithImpl;
@override @useResult
$Res call({
 String category, double amount, String color
});




}
/// @nodoc
class __$CategorySpendCopyWithImpl<$Res>
    implements _$CategorySpendCopyWith<$Res> {
  __$CategorySpendCopyWithImpl(this._self, this._then);

  final _CategorySpend _self;
  final $Res Function(_CategorySpend) _then;

/// Create a copy of CategorySpend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? amount = null,Object? color = null,}) {
  return _then(_CategorySpend(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TrendPoint {

 String get month; double get amount;
/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendPointCopyWith<TrendPoint> get copyWith => _$TrendPointCopyWithImpl<TrendPoint>(this as TrendPoint, _$identity);

  /// Serializes this TrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendPoint&&(identical(other.month, month) || other.month == month)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,amount);

@override
String toString() {
  return 'TrendPoint(month: $month, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $TrendPointCopyWith<$Res>  {
  factory $TrendPointCopyWith(TrendPoint value, $Res Function(TrendPoint) _then) = _$TrendPointCopyWithImpl;
@useResult
$Res call({
 String month, double amount
});




}
/// @nodoc
class _$TrendPointCopyWithImpl<$Res>
    implements $TrendPointCopyWith<$Res> {
  _$TrendPointCopyWithImpl(this._self, this._then);

  final TrendPoint _self;
  final $Res Function(TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? amount = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendPoint].
extension TrendPointPatterns on TrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _TrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.month,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  double amount)  $default,) {final _that = this;
switch (_that) {
case _TrendPoint():
return $default(_that.month,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.month,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendPoint implements TrendPoint {
  const _TrendPoint({required this.month, required this.amount});
  factory _TrendPoint.fromJson(Map<String, dynamic> json) => _$TrendPointFromJson(json);

@override final  String month;
@override final  double amount;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendPointCopyWith<_TrendPoint> get copyWith => __$TrendPointCopyWithImpl<_TrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendPoint&&(identical(other.month, month) || other.month == month)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,amount);

@override
String toString() {
  return 'TrendPoint(month: $month, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TrendPointCopyWith<$Res> implements $TrendPointCopyWith<$Res> {
  factory _$TrendPointCopyWith(_TrendPoint value, $Res Function(_TrendPoint) _then) = __$TrendPointCopyWithImpl;
@override @useResult
$Res call({
 String month, double amount
});




}
/// @nodoc
class __$TrendPointCopyWithImpl<$Res>
    implements _$TrendPointCopyWith<$Res> {
  __$TrendPointCopyWithImpl(this._self, this._then);

  final _TrendPoint _self;
  final $Res Function(_TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? amount = null,}) {
  return _then(_TrendPoint(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Budget {

 String get category; double get spent; double get limit;
/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetCopyWith<Budget> get copyWith => _$BudgetCopyWithImpl<Budget>(this as Budget, _$identity);

  /// Serializes this Budget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Budget&&(identical(other.category, category) || other.category == category)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,spent,limit);

@override
String toString() {
  return 'Budget(category: $category, spent: $spent, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $BudgetCopyWith<$Res>  {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) _then) = _$BudgetCopyWithImpl;
@useResult
$Res call({
 String category, double spent, double limit
});




}
/// @nodoc
class _$BudgetCopyWithImpl<$Res>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._self, this._then);

  final Budget _self;
  final $Res Function(Budget) _then;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? spent = null,Object? limit = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Budget].
extension BudgetPatterns on Budget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Budget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Budget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Budget value)  $default,){
final _that = this;
switch (_that) {
case _Budget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Budget value)?  $default,){
final _that = this;
switch (_that) {
case _Budget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  double spent,  double limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that.category,_that.spent,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  double spent,  double limit)  $default,) {final _that = this;
switch (_that) {
case _Budget():
return $default(_that.category,_that.spent,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  double spent,  double limit)?  $default,) {final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that.category,_that.spent,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Budget implements Budget {
  const _Budget({required this.category, required this.spent, required this.limit});
  factory _Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

@override final  String category;
@override final  double spent;
@override final  double limit;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetCopyWith<_Budget> get copyWith => __$BudgetCopyWithImpl<_Budget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Budget&&(identical(other.category, category) || other.category == category)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,spent,limit);

@override
String toString() {
  return 'Budget(category: $category, spent: $spent, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$BudgetCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$BudgetCopyWith(_Budget value, $Res Function(_Budget) _then) = __$BudgetCopyWithImpl;
@override @useResult
$Res call({
 String category, double spent, double limit
});




}
/// @nodoc
class __$BudgetCopyWithImpl<$Res>
    implements _$BudgetCopyWith<$Res> {
  __$BudgetCopyWithImpl(this._self, this._then);

  final _Budget _self;
  final $Res Function(_Budget) _then;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? spent = null,Object? limit = null,}) {
  return _then(_Budget(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Insights {

 String get period; double get total; List<CategorySpend> get byCategory; List<TrendPoint> get trend; List<Budget> get budgets;
/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightsCopyWith<Insights> get copyWith => _$InsightsCopyWithImpl<Insights>(this as Insights, _$identity);

  /// Serializes this Insights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Insights&&(identical(other.period, period) || other.period == period)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byCategory, byCategory)&&const DeepCollectionEquality().equals(other.trend, trend)&&const DeepCollectionEquality().equals(other.budgets, budgets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,total,const DeepCollectionEquality().hash(byCategory),const DeepCollectionEquality().hash(trend),const DeepCollectionEquality().hash(budgets));

@override
String toString() {
  return 'Insights(period: $period, total: $total, byCategory: $byCategory, trend: $trend, budgets: $budgets)';
}


}

/// @nodoc
abstract mixin class $InsightsCopyWith<$Res>  {
  factory $InsightsCopyWith(Insights value, $Res Function(Insights) _then) = _$InsightsCopyWithImpl;
@useResult
$Res call({
 String period, double total, List<CategorySpend> byCategory, List<TrendPoint> trend, List<Budget> budgets
});




}
/// @nodoc
class _$InsightsCopyWithImpl<$Res>
    implements $InsightsCopyWith<$Res> {
  _$InsightsCopyWithImpl(this._self, this._then);

  final Insights _self;
  final $Res Function(Insights) _then;

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? total = null,Object? byCategory = null,Object? trend = null,Object? budgets = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,budgets: null == budgets ? _self.budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<Budget>,
  ));
}

}


/// Adds pattern-matching-related methods to [Insights].
extension InsightsPatterns on Insights {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Insights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Insights() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Insights value)  $default,){
final _that = this;
switch (_that) {
case _Insights():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Insights value)?  $default,){
final _that = this;
switch (_that) {
case _Insights() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String period,  double total,  List<CategorySpend> byCategory,  List<TrendPoint> trend,  List<Budget> budgets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Insights() when $default != null:
return $default(_that.period,_that.total,_that.byCategory,_that.trend,_that.budgets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String period,  double total,  List<CategorySpend> byCategory,  List<TrendPoint> trend,  List<Budget> budgets)  $default,) {final _that = this;
switch (_that) {
case _Insights():
return $default(_that.period,_that.total,_that.byCategory,_that.trend,_that.budgets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String period,  double total,  List<CategorySpend> byCategory,  List<TrendPoint> trend,  List<Budget> budgets)?  $default,) {final _that = this;
switch (_that) {
case _Insights() when $default != null:
return $default(_that.period,_that.total,_that.byCategory,_that.trend,_that.budgets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Insights implements Insights {
  const _Insights({required this.period, required this.total, required final  List<CategorySpend> byCategory, required final  List<TrendPoint> trend, required final  List<Budget> budgets}): _byCategory = byCategory,_trend = trend,_budgets = budgets;
  factory _Insights.fromJson(Map<String, dynamic> json) => _$InsightsFromJson(json);

@override final  String period;
@override final  double total;
 final  List<CategorySpend> _byCategory;
@override List<CategorySpend> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}

 final  List<TrendPoint> _trend;
@override List<TrendPoint> get trend {
  if (_trend is EqualUnmodifiableListView) return _trend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trend);
}

 final  List<Budget> _budgets;
@override List<Budget> get budgets {
  if (_budgets is EqualUnmodifiableListView) return _budgets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgets);
}


/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsightsCopyWith<_Insights> get copyWith => __$InsightsCopyWithImpl<_Insights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InsightsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Insights&&(identical(other.period, period) || other.period == period)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._byCategory, _byCategory)&&const DeepCollectionEquality().equals(other._trend, _trend)&&const DeepCollectionEquality().equals(other._budgets, _budgets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,total,const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_trend),const DeepCollectionEquality().hash(_budgets));

@override
String toString() {
  return 'Insights(period: $period, total: $total, byCategory: $byCategory, trend: $trend, budgets: $budgets)';
}


}

/// @nodoc
abstract mixin class _$InsightsCopyWith<$Res> implements $InsightsCopyWith<$Res> {
  factory _$InsightsCopyWith(_Insights value, $Res Function(_Insights) _then) = __$InsightsCopyWithImpl;
@override @useResult
$Res call({
 String period, double total, List<CategorySpend> byCategory, List<TrendPoint> trend, List<Budget> budgets
});




}
/// @nodoc
class __$InsightsCopyWithImpl<$Res>
    implements _$InsightsCopyWith<$Res> {
  __$InsightsCopyWithImpl(this._self, this._then);

  final _Insights _self;
  final $Res Function(_Insights) _then;

/// Create a copy of Insights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? total = null,Object? byCategory = null,Object? trend = null,Object? budgets = null,}) {
  return _then(_Insights(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategorySpend>,trend: null == trend ? _self._trend : trend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,budgets: null == budgets ? _self._budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<Budget>,
  ));
}


}

// dart format on
