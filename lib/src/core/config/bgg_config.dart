/// Configuration constants for the BGG Flutter Client.
class BggConfig {
  static const String baseUrl = 'https://boardgamegeek.com/xmlapi2';
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 5);
}
