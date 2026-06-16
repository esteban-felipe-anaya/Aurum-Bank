import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Lightweight request/response logger (debug builds only).
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log('→ ${options.method} ${options.uri}', name: 'http');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        '← ${response.statusCode} ${response.requestOptions.uri}',
        name: 'http',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        '✖ ${err.requestOptions.method} ${err.requestOptions.uri} '
        '→ ${err.type.name} ${err.response?.statusCode ?? ''}',
        name: 'http',
        error: err.message,
      );
    }
    handler.next(err);
  }
}
