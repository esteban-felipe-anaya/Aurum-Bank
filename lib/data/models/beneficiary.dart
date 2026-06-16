import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary.freezed.dart';
part 'beneficiary.g.dart';

@freezed
abstract class Beneficiary with _$Beneficiary {
  const factory Beneficiary({
    required String id,
    required String name,
    required String bank,
    required String accountNumberMasked,
    required String avatarColor,
  }) = _Beneficiary;

  factory Beneficiary.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFromJson(json);
}
