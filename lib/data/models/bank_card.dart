import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_card.freezed.dart';
part 'bank_card.g.dart';

@freezed
abstract class BankCard with _$BankCard {
  const factory BankCard({
    required String id,
    required String accountId,
    required String brand,
    required String last4,
    required String holder,
    required String expiry,
    required bool frozen,
    required String color,
  }) = _BankCard;

  factory BankCard.fromJson(Map<String, dynamic> json) =>
      _$BankCardFromJson(json);
}
