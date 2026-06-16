// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transfer _$TransferFromJson(Map<String, dynamic> json) => _Transfer(
  id: json['id'] as String,
  status: json['status'] as String,
  fromAccountId: json['fromAccountId'] as String,
  toBeneficiaryId: json['toBeneficiaryId'] as String,
  amount: (json['amount'] as num).toDouble(),
  fee: (json['fee'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$TransferToJson(_Transfer instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'fromAccountId': instance.fromAccountId,
  'toBeneficiaryId': instance.toBeneficiaryId,
  'amount': instance.amount,
  'fee': instance.fee,
  'date': instance.date.toIso8601String(),
};

_TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) =>
    _TransferRequest(
      fromAccountId: json['fromAccountId'] as String,
      toBeneficiaryId: json['toBeneficiaryId'] as String,
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TransferRequestToJson(_TransferRequest instance) =>
    <String, dynamic>{
      'fromAccountId': instance.fromAccountId,
      'toBeneficiaryId': instance.toBeneficiaryId,
      'amount': instance.amount,
      'fee': instance.fee,
      'note': instance.note,
    };
