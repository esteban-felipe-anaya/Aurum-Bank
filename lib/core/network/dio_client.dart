import 'package:dio/dio.dart';

import '../env/app_config.dart';
import 'auth_interceptor.dart';
import 'chaos_interceptor.dart';
import 'logging_interceptor.dart';

/// Factory that assembles a configured [Dio] instance with the full
/// interceptor chain. Kept side-effect free so it is trivial to construct in
/// tests with a custom [baseUrl] and no chaos.
Dio buildDio({
  required Future<String?> Function() tokenReader,
  String baseUrl = AppConfig.baseUrl,
  bool simulateNetwork = AppConfig.simulateNetworkConditions,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(tokenReader),
    if (simulateNetwork)
      ChaosInterceptor(enabled: true, errorRate: AppConfig.simulatedErrorRate),
    LoggingInterceptor(),
  ]);

  return dio;
}
