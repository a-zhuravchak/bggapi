import 'package:dio/dio.dart';

import '../../core/config/bgg_config.dart';
import '../../core/exceptions/bgg_exceptions.dart';

/// API client for accessing BoardGameGeek's collection endpoint.
class BggCollectionApi {
  final Dio _dio;

  /// Creates a [BggCollectionApi] instance with an optional custom Dio client.
  /// If no Dio client is provided, a default one will be created with the
  BggCollectionApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: BggConfig.baseUrl,
                connectTimeout: BggConfig.connectTimeout,
                receiveTimeout: BggConfig.receiveTimeout,
              ),
            );

  /// Fetches the raw XML string of a user's board game collection.
  ///
  /// [username] is required. Optional [own] and [wishlist] filters
  /// can be applied.
  ///
  /// Throws a [BggNetworkException] or [BggRequestPendingException] if an error occurs.
  /// Throws a [BggTimeoutException] if the request times out.
  Future<String> fetchCollection({
    required String userName,
    bool own = false,
    bool wishlist = false,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'username': userName,
        if (own) 'own': '1',
        if (wishlist) 'wishlist': '1',
      };

      final response = await _dio.get<String>(
        '/collection',
        queryParameters: queryParams,
      );

      if (response.statusCode == 202) {
        // 202 = Accepted but not ready yet
        await Future.delayed(const Duration(seconds: 2));
        return fetchCollection(
          userName: userName,
          own: own,
          wishlist: wishlist,
        );
      }

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw BggServerException(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw BggTimeoutException();
      }
      throw BggException('Dio error: ${e.message}');
    } catch (e) {
      throw BggException('Unexpected error: $e');
    }
  }
}
