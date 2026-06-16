import 'package:dio/dio.dart';
import 'package:aurum_bank/core/error/failure.dart';
import 'package:aurum_bank/data/models/app_transaction.dart';
import 'package:aurum_bank/data/repositories/accounts_repository.dart';
import 'package:aurum_bank/data/repositories/transactions_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
  });

  group('TransactionsRepository', () {
    test('getTransaction parses the JSON into a typed model', () async {
      adapter.onGet(
        '/transactions/txn_1',
        (server) => server.reply(200, {
          'id': 'txn_1',
          'accountId': 'acc_01',
          'title': 'Spotify Premium',
          'merchant': 'Spotify',
          'category': 'subscriptions',
          'amount': -9.99,
          'currency': 'USD',
          'type': 'debit',
          'status': 'completed',
          'date': '2026-06-10T14:22:00Z',
        }),
      );

      final repo = TransactionsRepositoryImpl(dio);
      final txn = await repo.getTransaction('txn_1');

      expect(txn.id, 'txn_1');
      expect(txn.merchant, 'Spotify');
      expect(txn.amount, -9.99);
      expect(txn.type, TransactionType.debit);
      expect(txn.status, TransactionStatus.completed);
      expect(txn.date, DateTime.utc(2026, 6, 10, 14, 22));
    });

    test('maps a 500 response to a ServerFailure', () async {
      adapter.onGet(
        '/transactions/boom',
        (server) => server.reply(500, {'error': 'kaboom'}),
      );

      final repo = TransactionsRepositoryImpl(dio);

      await expectLater(
        repo.getTransaction('boom'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('AccountsRepository', () {
    test('getAccounts parses a list of accounts', () async {
      adapter.onGet(
        '/accounts',
        (server) => server.reply(200, [
          {
            'id': 'acc_01',
            'name': 'Everyday Checking',
            'type': 'checking',
            'currency': 'USD',
            'balance': 8240.55,
            'accountNumberMasked': '•••• 4021',
          },
          {
            'id': 'acc_02',
            'name': 'Savings',
            'type': 'savings',
            'currency': 'USD',
            'balance': 15200.0,
            'accountNumberMasked': '•••• 7788',
          },
        ]),
      );

      final repo = AccountsRepositoryImpl(dio);
      final accounts = await repo.getAccounts();

      expect(accounts, hasLength(2));
      expect(accounts.first.name, 'Everyday Checking');
      expect(accounts.last.balance, 15200.0);
    });
  });
}
