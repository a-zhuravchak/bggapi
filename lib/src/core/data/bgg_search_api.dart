import 'package:dio/dio.dart';

import '../config/bgg_config.dart';
import '../exceptions/bgg_exceptions.dart';

/// Handles direct communication with BGG’s XML “search” endpoint.
class BggSearchApi {
  final Dio _dio;

  /// Creates a [BggSearchApi], optionally with a custom [dio].
  BggSearchApi({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: BggConfig.baseUrl,
              connectTimeout: BggConfig.connectTimeout,
              receiveTimeout: BggConfig.receiveTimeout,
            ));

  /// Fetches raw XML for a search on [query].
  ///
  /// If [type] is provided (e.g. `'boardgame'`), the API filters by that thing type.
  ///
  /// Throws [BggRequestPendingException] for HTTP 202,
  /// [BggNetworkException] on other errors.
  Future<String> fetchSearch({
    required String query,
    String? type,
  }) async {
    final params = <String, dynamic>{'query': query, if (type != null) 'type': type};

    try {
      final resp = await _dio.get<String>('/search', queryParameters: params);
      if (resp.statusCode == 202) {
        throw BggRequestPendingException();
      }
      if (resp.data == null) {
        throw BggNetworkException('No data returned from search.');
      }
      return resp.data!;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw BggTimeoutException();
      }
      throw BggNetworkException(e.message ?? 'Search request failed');
    }
  }
}
