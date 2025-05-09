import 'package:dio/dio.dart';
import 'core/data/bgg_search_api.dart';
import 'core/data/models/search_results.dart';
import 'core/domain/search/search_repository.dart';
import 'core/exceptions/bgg_exceptions.dart';
import 'core/data/bgg_collection_api.dart';
import 'core/data/models/collection.dart';
import 'core/domain/collection/collection_repository.dart';

/// The main entry-point for the BGG Flutter Client.
///
/// Instantiate this class and call its methods to access any BGG XML API endpoint.
class BggClient {
  late final CollectionRepository _collectionRepository;
  late final SearchRepository _searchRepository;

  /// Creates a [BggClient].
  ///
  /// You can pass in your own [dio] client to customize timeouts, interceptors, etc.
  BggClient({Dio? dio}) {
    _collectionRepository = CollectionRepository(api: BggCollectionApi(dio: dio));
    _searchRepository = SearchRepository(api: BggSearchApi(dio: dio));
  }

  /// Fetches the board-game collection for [userName].
  ///
  /// If [own] is true, only owned games are returned.
  /// If [wishlist] is true, only wishlist items are returned.
  /// - [BggParsingException] on XML parse errors
  Future<Collection> getCollection({
    required String userName,
    bool own = false,
    bool wishlist = false,
  }) =>
      _collectionRepository.getCollection(
        userName: userName,
        own: own,
        wishlist: wishlist,
      );

  /// Searches BoardGameGeek for items matching [query].
  ///
  /// [query] is the text to search for; it may be a full or partial game name.
  /// [type] filters the “thing” type (e.g. `'boardgame'`, `'videogame'`, `'rpg'`).
  /// Defaults to `'boardgame'`.
  ///
  /// Throws:
  /// - [BggRequestPendingException] if the API returns HTTP 202 (indicating the request is still being processed).
  /// - [BggNetworkException] on network or Dio-level errors.
  /// - [BggParsingException] if the XML response cannot be parsed.
  ///
  /// Returns a [Future] that completes with a [SearchResults] containing all matched items.

  Future<SearchResults> search({
    required String query,
    String? type = 'boardgame',
  }) =>
      _searchRepository.search(query: query, type: type);
}
