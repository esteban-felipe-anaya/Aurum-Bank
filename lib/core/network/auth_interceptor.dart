import 'package:dio/dio.dart';

/// Attaches the bearer token (if any) to outgoing requests. The token is read
/// lazily through [tokenReader] so it always reflects the latest stored value.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.tokenReader);

  final Future<String?> Function() tokenReader;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenReader();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
