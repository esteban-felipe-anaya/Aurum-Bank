import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/transfer.dart';

abstract interface class TransferRepository {
  Future<Transfer> createTransfer(TransferRequest request);
}

class TransferRepositoryImpl implements TransferRepository {
  TransferRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Transfer> createTransfer(TransferRequest request) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/transfers',
        data: request.toJson(),
      );
      return Transfer.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
