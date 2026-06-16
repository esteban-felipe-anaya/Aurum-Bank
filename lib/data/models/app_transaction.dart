import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_transaction.freezed.dart';
part 'app_transaction.g.dart';

enum TransactionType {
  @JsonValue('debit')
  debit,
  @JsonValue('credit')
  credit,
}

enum TransactionStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('pending')
  pending,
  @JsonValue('failed')
  failed,
}

@freezed
abstract class AppTransaction with _$AppTransaction {
  const factory AppTransaction({
    required String id,
    required String accountId,
    required String title,
    required String merchant,
    required String category,
    required double amount,
    required String currency,
    required TransactionType type,
    required TransactionStatus status,
    required DateTime date,
  }) = _AppTransaction;

  factory AppTransaction.fromJson(Map<String, dynamic> json) =>
      _$AppTransactionFromJson(json);
}
