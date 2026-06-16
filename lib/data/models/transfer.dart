import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';
part 'transfer.g.dart';

@freezed
abstract class Transfer with _$Transfer {
  const factory Transfer({
    required String id,
    required String status,
    required String fromAccountId,
    required String toBeneficiaryId,
    required double amount,
    required double fee,
    required DateTime date,
  }) = _Transfer;

  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);
}

/// Payload sent to `POST /transfers`.
@freezed
abstract class TransferRequest with _$TransferRequest {
  const factory TransferRequest({
    required String fromAccountId,
    required String toBeneficiaryId,
    required double amount,
    required double fee,
    String? note,
  }) = _TransferRequest;

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestFromJson(json);
}
