/// A custom exception to handle network errors with error codes.
class NetworkException implements Exception {
  final String message;
  final int? errorCode;

  NetworkException({required this.message, this.errorCode});

  @override
  String toString() => 'NetworkException: $message, Error Code: $errorCode';
}

/// A custom exception for timeout-related errors.
class TimeoutException implements Exception {
  final String message;
  final int? timeoutDuration;

  TimeoutException({required this.message, this.timeoutDuration});

  @override
  String toString() =>
      'TimeoutException: $message, Timeout Duration: $timeoutDuration seconds';
}

/// A custom exception for unauthorized access (401 errors).
class UnauthorizedAccessException implements Exception {
  final String message;

  UnauthorizedAccessException(this.message);

  @override
  String toString() => 'UnauthorizedAccessException: $message';
}

/// A custom exception for not found errors (404).
class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

/// A custom exception for bad request errors (400).
class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);

  @override
  String toString() => 'BadRequestException: $message';
}

/// A custom exception for server errors (500).
class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);

  @override
  String toString() => 'ServerErrorException: $message';
}

/// A custom exception for any unknown errors.
class UnknownErrorException implements Exception {
  final String message;

  UnknownErrorException(this.message);

  @override
  String toString() => 'UnknownErrorException: $message';
}
