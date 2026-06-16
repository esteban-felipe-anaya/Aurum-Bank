import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/app_notification.dart';

abstract interface class NotificationsRepository {
  Future<List<AppNotification>> getNotifications();
  Future<AppNotification> setRead(String id, {required bool read});
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<AppNotification>> getNotifications() async {
    try {
      final res = await _dio.get<List<dynamic>>('/notifications');
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(AppNotification.fromJson)
          .toList();
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AppNotification> setRead(String id, {required bool read}) async {
    try {
      final res = await _dio.patch<Map<String, dynamic>>(
        '/notifications/$id',
        data: {'read': read},
      );
      return AppNotification.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
