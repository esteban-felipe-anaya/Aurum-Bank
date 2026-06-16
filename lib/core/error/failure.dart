/// Typed, UI-friendly failures. Repositories translate transport/`DioException`
/// errors into these so the UI layer never inspects raw exceptions.
sealed class Failure implements Exception {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'The request timed out. Try again.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Your session has expired.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([
    super.message = 'The requested resource was not found.',
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on our end.']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}
