import 'package:freezed_annotation/freezed_annotation.dart';

part 'biller.freezed.dart';
part 'biller.g.dart';

/// A payee available in the "Pay bills" flow.
@freezed
abstract class Biller with _$Biller {
  const factory Biller({
    required String id,
    required String name,
    required String category,
    required String icon,
    @JsonKey(name: 'accountMasked') required String accountMasked,
  }) = _Biller;

  factory Biller.fromJson(Map<String, dynamic> json) => _$BillerFromJson(json);
}
