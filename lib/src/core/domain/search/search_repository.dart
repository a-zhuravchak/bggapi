import 'package:xml/xml.dart';

import '../../data/bgg_search_api.dart';
import '../../data/models/search_results.dart';
import '../../exceptions/bgg_exceptions.dart';

/// High-level interface for searching BGG.
class SearchRepository {
  final BggSearchApi _api;

  /// Optionally provide your own [api] (e.g. for testing).
  SearchRepository({BggSearchApi? api}) : _api = api ?? BggSearchApi();

  /// Perform [query] search, optional [type] filter (e.g. 'boardgame').
  ///
  /// Throws:
  /// - [BggRequestPendingException] if API returns 202
  /// - [BggNetworkException] on network errors
  /// - [BggParsingException] on XML parse errors
  Future<SearchResults> search({
    required String query,
    String? type,
  }) async {
    try {
      final xmlString = await _api.fetchSearch(query: query, type: type);
      final root = XmlDocument.parse(xmlString).rootElement;
      return SearchResults.fromXml(root);
    } on BggException {
      rethrow;
    } catch (_) {
      throw BggParsingException();
    }
  }
}
