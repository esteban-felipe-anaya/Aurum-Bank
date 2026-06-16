import 'package:aurum_bank/features/transfer/application/transfer_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransferValidation.parseAmount', () {
    test('parses plain and decorated numbers', () {
      expect(TransferValidation.parseAmount('100'), 100);
      expect(TransferValidation.parseAmount('\$1,250.50'), 1250.50);
      expect(TransferValidation.parseAmount('  42.00 '), 42.0);
    });

    test('returns null for empty or non-numeric input', () {
      expect(TransferValidation.parseAmount(null), isNull);
      expect(TransferValidation.parseAmount(''), isNull);
      expect(TransferValidation.parseAmount('abc'), isNull);
    });
  });

  group('TransferValidation.validateAmount', () {
    test('rejects empty input', () {
      expect(TransferValidation.validateAmount(''), 'Enter an amount');
    });

    test('rejects zero and negative amounts', () {
      expect(
        TransferValidation.validateAmount('0'),
        'Amount must be greater than zero',
      );
      expect(
        TransferValidation.validateAmount('-5'),
        'Amount must be greater than zero',
      );
    });

    test('rejects amounts over the per-transfer limit', () {
      expect(
        TransferValidation.validateAmount('2000000'),
        'Amount exceeds the per-transfer limit',
      );
    });

    test('rejects amounts above the available balance', () {
      expect(
        TransferValidation.validateAmount('500', balance: 100),
        'Insufficient funds',
      );
    });

    test('accepts a valid amount within balance', () {
      expect(TransferValidation.validateAmount('80', balance: 100), isNull);
      expect(TransferValidation.isValidAmount('80', balance: 100), isTrue);
    });

    test('skips the funds check when balance is null', () {
      expect(TransferValidation.validateAmount('999999'), isNull);
    });
  });
}
