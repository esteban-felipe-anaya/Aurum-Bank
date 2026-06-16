import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/app_transaction.dart';

/// Filter/query parameters for the transactions list. Mirrors the json-server
/// query contract: ?accountId=&category=&from=&to=&q=&_page=&_limit=
class TransactionQuery {
  const TransactionQuery({
    this.accountId,
    this.category,
    this.from,
    this.to,
    this.q,
    this.page = 1,
    this.limit = 20,
  });

  final String? accountId;
  final String? category;
  final DateTime? from;
  final DateTime? to;
  final String? q;
  final int page;
  final int limit;

  Map<String, dynamic> toQueryParameters() {
    return <String, dynamic>{
      if (accountId != null && accountId!.isNotEmpty) 'accountId': accountId,
      if (category != null && category!.isNotEmpty) 'category': category,
      if (from != null) 'date_gte': from!.toUtc().toIso8601String(),
      if (to != null) 'date_lte': to!.toUtc().toIso8601String(),
      if (q != null && q!.trim().isNotEmpty) 'q': q!.trim(),
      '_page': page,
      '_limit': limit,
      '_sort': 'date',
      '_order': 'desc',
    };
  }

  TransactionQuery copyWith({
    String? accountId,
    String? category,
    DateTime? from,
    DateTime? to,
    String? q,
    int? page,
    int? limit,
    bool clearAccountId = false,
    bool clearCategory = false,
    bool clearFrom = false,
    bool clearTo = false,
    bool clearQ = false,
  }) {
    return TransactionQuery(
      accountId: clearAccountId ? null : (accountId ?? this.accountId),
      category: clearCategory ? null : (category ?? this.category),
      from: clearFrom ? null : (from ?? this.from),
      to: clearTo ? null : (to ?? this.to),
      q: clearQ ? null : (q ?? this.q),
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}

abstract interface class TransactionsRepository {
  Future<List<AppTransaction>> getTransactions(TransactionQuery query);
  Future<AppTransaction> getTransaction(String id);
}

class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<AppTransaction>> getTransactions(TransactionQuery query) async {
    try {
      final res = await _dio.get<List<dynamic>>(
        '/transactions',
        queryParameters: query.toQueryParameters(),
      );
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(AppTransaction.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AppTransaction> getTransaction(String id) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/transactions/$id');
      return AppTransaction.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
