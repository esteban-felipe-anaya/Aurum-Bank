import 'package:flutter/material.dart';
import 'package:aurum_bank/data/models/app_transaction.dart';
import 'package:aurum_bank/shared/widgets/transaction_tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TransactionTile renders title and a signed debit amount', (
    tester,
  ) async {
    final txn = AppTransaction(
      id: 'txn_1',
      accountId: 'acc_01',
      title: 'Spotify Premium',
      merchant: 'Spotify',
      category: 'subscriptions',
      amount: -9.99,
      currency: 'USD',
      type: TransactionType.debit,
      status: TransactionStatus.completed,
      date: DateTime.utc(2026, 6, 10),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: TransactionTile(transaction: txn)),
      ),
    );

    expect(find.text('Spotify Premium'), findsOneWidget);
    expect(find.textContaining('9.99'), findsOneWidget);
    expect(find.textContaining('-'), findsOneWidget);
  });
}
