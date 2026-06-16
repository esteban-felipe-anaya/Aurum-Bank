import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/beneficiary.dart';

abstract interface class BeneficiariesRepository {
  Future<List<Beneficiary>> getBeneficiaries();
}

class BeneficiariesRepositoryImpl implements BeneficiariesRepository {
  BeneficiariesRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    try {
      final res = await _dio.get<List<dynamic>>('/beneficiaries');
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(Beneficiary.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
