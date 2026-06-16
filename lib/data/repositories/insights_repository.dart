import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/insights.dart';

abstract interface class InsightsRepository {
  Future<Insights> getSpending();
}

class InsightsRepositoryImpl implements InsightsRepository {
  InsightsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Insights> getSpending() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/insights/spending');
      return Insights.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
