// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategorySpend _$CategorySpendFromJson(Map<String, dynamic> json) =>
    _CategorySpend(
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$CategorySpendToJson(_CategorySpend instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amount': instance.amount,
      'color': instance.color,
    };

_TrendPoint _$TrendPointFromJson(Map<String, dynamic> json) => _TrendPoint(
  month: json['month'] as String,
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$TrendPointToJson(_TrendPoint instance) =>
    <String, dynamic>{'month': instance.month, 'amount': instance.amount};

_Budget _$BudgetFromJson(Map<String, dynamic> json) => _Budget(
  category: json['category'] as String,
  spent: (json['spent'] as num).toDouble(),
  limit: (json['limit'] as num).toDouble(),
);

Map<String, dynamic> _$BudgetToJson(_Budget instance) => <String, dynamic>{
  'category': instance.category,
  'spent': instance.spent,
  'limit': instance.limit,
};

_Insights _$InsightsFromJson(Map<String, dynamic> json) => _Insights(
  period: json['period'] as String,
  total: (json['total'] as num).toDouble(),
  byCategory: (json['byCategory'] as List<dynamic>)
      .map((e) => CategorySpend.fromJson(e as Map<String, dynamic>))
      .toList(),
  trend: (json['trend'] as List<dynamic>)
      .map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  budgets: (json['budgets'] as List<dynamic>)
      .map((e) => Budget.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$InsightsToJson(_Insights instance) => <String, dynamic>{
  'period': instance.period,
  'total': instance.total,
  'byCategory': instance.byCategory,
  'trend': instance.trend,
  'budgets': instance.budgets,
};
