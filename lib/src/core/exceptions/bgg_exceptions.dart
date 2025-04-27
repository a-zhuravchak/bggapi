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
  BggServerException(int? statusCode) : super('Server error with status code: $statusCode');
}

class BggParsingException extends BggException {
  BggParsingException() : super('Failed to parse XML response.');
}

/// Thrown when the BGG API request is still processing (HTTP 202).
class BggRequestPendingException extends BggException {
  BggRequestPendingException() : super('Request is still processing (HTTP 202).');
}

/// Thrown when a network error occurs during the BGG API request.
class BggNetworkException extends BggException {
  BggNetworkException(super.message);
}
