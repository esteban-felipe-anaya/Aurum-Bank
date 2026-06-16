/// Pure validation helpers for the transfer flow — shared by the UI and tests.
abstract final class TransferValidation {
  /// Parses a raw amount string (allowing "$" and thousands separators).
  static double? parseAmount(String? input) {
    if (input == null) return null;
    // Keep digits, a decimal point and a leading minus; drop currency symbols
    // and thousands separators.
    final cleaned = input.replaceAll(RegExp(r'[^0-9.\-]'), '');
    if (cleaned.isEmpty || cleaned == '-') return null;
    return double.tryParse(cleaned);
  }

  /// Returns an error message for an invalid amount, or null when valid.
  ///
  /// [balance] is the available balance of the source account; pass null to
  /// skip the funds check.
  static String? validateAmount(String? input, {double? balance}) {
    final value = parseAmount(input);
    if (value == null) return 'Enter an amount';
    if (value <= 0) return 'Amount must be greater than zero';
    if (value > 1000000) return 'Amount exceeds the per-transfer limit';
    if (balance != null && value > balance) return 'Insufficient funds';
    return null;
  }

  static bool isValidAmount(String? input, {double? balance}) =>
      validateAmount(input, balance: balance) == null;
}
