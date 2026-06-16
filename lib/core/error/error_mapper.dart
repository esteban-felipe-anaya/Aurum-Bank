import 'package:dio/dio.dart';

import 'failure.dart';

/// Maps a low-level [DioException] into a domain [Failure].
Failure mapDioError(Object error) {
  if (error is Failure) return error;
  if (error is! DioException) return const UnknownFailure();

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode ?? 0;
      if (status == 401 || status == 403) return const UnauthorizedFailure();
      if (status == 404) return const NotFoundFailure();
      if (status >= 500) return const ServerFailure();
      return ServerFailure('Request failed (HTTP $status).');
    case DioExceptionType.cancel:
      return const UnknownFailure('Request was cancelled.');
    case DioExceptionType.badCertificate:
      return const NetworkFailure('Insecure connection.');
    case DioExceptionType.unknown:
      return const NetworkFailure();
  }
}
