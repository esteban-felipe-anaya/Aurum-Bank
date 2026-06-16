// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Beneficiary _$BeneficiaryFromJson(Map<String, dynamic> json) => _Beneficiary(
  id: json['id'] as String,
  name: json['name'] as String,
  bank: json['bank'] as String,
  accountNumberMasked: json['accountNumberMasked'] as String,
  avatarColor: json['avatarColor'] as String,
);

Map<String, dynamic> _$BeneficiaryToJson(_Beneficiary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bank': instance.bank,
      'accountNumberMasked': instance.accountNumberMasked,
      'avatarColor': instance.avatarColor,
    };
