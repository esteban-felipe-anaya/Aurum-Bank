import 'dart:math';

import 'package:dio/dio.dart';

/// Development-only interceptor that simulates real-world network behaviour:
/// adds 300–800ms of latency and fails a small percentage of requests so that
/// loading and error states are genuinely exercised.
class ChaosInterceptor extends Interceptor {
  ChaosInterceptor({
    required this.enabled,
    required this.errorRate,
    Random? random,
  }) : _random = random ?? Random();

  final bool enabled;
  final double errorRate;
  final Random _random;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!enabled) {
      handler.next(options);
      return;
    }

    // 300–800ms artificial latency.
    final delayMs = 300 + _random.nextInt(500);
    await Future<void>.delayed(Duration(milliseconds: delayMs));

    // Occasionally fail safe (idempotent) GET requests only, so writes such as
    // login/transfer stay deterministic and the demo remains usable.
    final isGet = options.method.toUpperCase() == 'GET';
    if (isGet && _random.nextDouble() < errorRate) {
      handler.reject(
        DioException.connectionError(
          requestOptions: options,
          reason: 'Simulated network failure',
        ),
      );
      return;
    }

    handler.next(options);
  }
}
