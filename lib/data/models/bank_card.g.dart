// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BankCard _$BankCardFromJson(Map<String, dynamic> json) => _BankCard(
  id: json['id'] as String,
  accountId: json['accountId'] as String,
  brand: json['brand'] as String,
  last4: json['last4'] as String,
  holder: json['holder'] as String,
  expiry: json['expiry'] as String,
  frozen: json['frozen'] as bool,
  color: json['color'] as String,
);

Map<String, dynamic> _$BankCardToJson(_BankCard instance) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'brand': instance.brand,
  'last4': instance.last4,
  'holder': instance.holder,
  'expiry': instance.expiry,
  'frozen': instance.frozen,
  'color': instance.color,
};
