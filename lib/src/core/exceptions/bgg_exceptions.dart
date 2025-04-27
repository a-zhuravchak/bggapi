/// Custom exceptions for the BGG Flutter Client.
class BggException implements Exception {
  final String message;

  BggException(this.message);

  @override
  String toString() => 'BggException: $message';
}

class BggTimeoutException extends BggException {
  BggTimeoutException() : super('Request timed out.');
}

class BggServerException extends BggException {
  BggServerException(int? statusCode)
      : super('Server error with status code: $statusCode');
}

class BggParsingException extends BggException {
  BggParsingException() : super('Failed to parse XML response.');
}
