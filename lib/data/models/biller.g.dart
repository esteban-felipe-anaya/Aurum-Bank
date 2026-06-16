// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Biller _$BillerFromJson(Map<String, dynamic> json) => _Biller(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  icon: json['icon'] as String,
  accountMasked: json['accountMasked'] as String,
);

Map<String, dynamic> _$BillerToJson(_Biller instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'icon': instance.icon,
  'accountMasked': instance.accountMasked,
};
