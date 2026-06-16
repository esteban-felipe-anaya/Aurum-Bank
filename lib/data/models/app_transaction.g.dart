// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppTransaction _$AppTransactionFromJson(Map<String, dynamic> json) =>
    _AppTransaction(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      title: json['title'] as String,
      merchant: json['merchant'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$AppTransactionToJson(_AppTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'title': instance.title,
      'merchant': instance.merchant,
      'category': instance.category,
      'amount': instance.amount,
      'currency': instance.currency,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.debit: 'debit',
  TransactionType.credit: 'credit',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.completed: 'completed',
  TransactionStatus.pending: 'pending',
  TransactionStatus.failed: 'failed',
};
