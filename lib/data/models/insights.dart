import 'package:freezed_annotation/freezed_annotation.dart';

part 'insights.freezed.dart';
part 'insights.g.dart';

@freezed
abstract class CategorySpend with _$CategorySpend {
  const factory CategorySpend({
    required String category,
    required double amount,
    required String color,
  }) = _CategorySpend;

  factory CategorySpend.fromJson(Map<String, dynamic> json) =>
      _$CategorySpendFromJson(json);
}

@freezed
abstract class TrendPoint with _$TrendPoint {
  const factory TrendPoint({required String month, required double amount}) =
      _TrendPoint;

  factory TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);
}

@freezed
abstract class Budget with _$Budget {
  const factory Budget({
    required String category,
    required double spent,
    required double limit,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
}

@freezed
abstract class Insights with _$Insights {
  const factory Insights({
    required String period,
    required double total,
    required List<CategorySpend> byCategory,
    required List<TrendPoint> trend,
    required List<Budget> budgets,
  }) = _Insights;

  factory Insights.fromJson(Map<String, dynamic> json) =>
      _$InsightsFromJson(json);
}
