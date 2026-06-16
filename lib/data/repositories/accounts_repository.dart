import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/account.dart';

abstract interface class AccountsRepository {
  Future<List<Account>> getAccounts();
}

class AccountsRepositoryImpl implements AccountsRepository {
  AccountsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<Account>> getAccounts() async {
    try {
      final res = await _dio.get<List<dynamic>>('/accounts');
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(Account.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
