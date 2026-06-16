import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/account.dart';
import '../models/biller.dart';
import '../models/payment_request.dart';

/// Money-movement operations that back the dashboard quick actions:
/// top-up, bill payment and money requests.
abstract interface class PaymentsRepository {
  Future<List<Biller>> getBillers();
  Future<Account> topUp({required String accountId, required double amount});
  Future<Account> payBill({
    required String accountId,
    required double amount,
    required String billerName,
  });
  Future<PaymentRequest> requestMoney({
    required double amount,
    required String currency,
    String? note,
  });
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  PaymentsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<Biller>> getBillers() async {
    try {
      final res = await _dio.get<List<dynamic>>('/billers');
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(Biller.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }

  /// Reads the account, then persists the new balance so the change is real.
  Future<Account> _adjustBalance(String accountId, double delta) async {
    final current = await _dio.get<Map<String, dynamic>>(
      '/accounts/$accountId',
    );
    final account = Account.fromJson(current.data!);
    final res = await _dio.patch<Map<String, dynamic>>(
      '/accounts/$accountId',
      data: {'balance': account.balance + delta},
    );
    return Account.fromJson(res.data!);
  }

  @override
  Future<Account> topUp({
    required String accountId,
    required double amount,
  }) async {
    try {
      return await _adjustBalance(accountId, amount);
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<Account> payBill({
    required String accountId,
    required double amount,
    required String billerName,
  }) async {
    try {
      final account = await _adjustBalance(accountId, -amount);
      // Record the payment (best-effort; balance change is the source of truth).
      await _dio.post<Map<String, dynamic>>(
        '/payments',
        data: {
          'accountId': accountId,
          'biller': billerName,
          'amount': amount,
          'date': DateTime.now().toIso8601String(),
        },
      );
      return account;
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<PaymentRequest> requestMoney({
    required double amount,
    required String currency,
    String? note,
  }) async {
    try {
      final code = _generateCode(amount);
      final res = await _dio.post<Map<String, dynamic>>(
        '/paymentRequests',
        data: {
          'code': code,
          'amount': amount,
          'currency': currency,
          'note': note,
          'date': DateTime.now().toIso8601String(),
        },
      );
      final data = res.data ?? const {};
      return PaymentRequest(
        id: '${data['id'] ?? code}',
        code: code,
        amount: amount,
        currency: currency,
        note: note,
      );
    } catch (e) {
      throw mapDioError(e);
    }
  }

  String _generateCode(double amount) {
    // Short, human-shareable reference derived from the clock + amount.
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final raw = (stamp ^ (amount * 100).round()).toRadixString(36).toUpperCase();
    final tail = raw.length > 6 ? raw.substring(raw.length - 6) : raw;
    return 'AUR-$tail';
  }
}
