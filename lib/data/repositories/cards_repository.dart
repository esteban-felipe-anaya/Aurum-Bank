import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/bank_card.dart';

abstract interface class CardsRepository {
  Future<List<BankCard>> getCards();
  Future<BankCard> getCard(String id);
  Future<BankCard> setFrozen(String id, {required bool frozen});
  Future<BankCard> addCard(BankCard card);
}

class CardsRepositoryImpl implements CardsRepository {
  CardsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<BankCard>> getCards() async {
    try {
      final res = await _dio.get<List<dynamic>>('/cards');
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(BankCard.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<BankCard> getCard(String id) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/cards/$id');
      return BankCard.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<BankCard> setFrozen(String id, {required bool frozen}) async {
    try {
      final res = await _dio.patch<Map<String, dynamic>>(
        '/cards/$id',
        data: {'frozen': frozen},
      );
      return BankCard.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<BankCard> addCard(BankCard card) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/cards',
        data: card.toJson(),
      );
      return BankCard.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
