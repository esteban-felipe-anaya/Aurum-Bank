/// The result of creating a "Request money" link. Constructed client-side from
/// the mock API response; kept as a plain value type (no JSON codegen needed).
class PaymentRequest {
  const PaymentRequest({
    required this.id,
    required this.code,
    required this.amount,
    required this.currency,
    this.note,
  });

  final String id;
  final String code;
  final double amount;
  final String currency;
  final String? note;

  /// A shareable deep link others can use to fulfil the request.
  String get shareLink => 'https://pay.aurum.app/r/$code';
}
