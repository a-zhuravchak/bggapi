import 'package:bggapi/src/core/exceptions/bgg_exceptions.dart';
import 'package:xml/xml.dart';

import '../../data/bgg_collection_api.dart';
import '../../data/models/collection.dart';

class CollectionRepository {
  final BggCollectionApi _api;

  CollectionRepository({BggCollectionApi? api})
      : _api = api ?? BggCollectionApi();

  Future<Collection> getCollection({
    required String userName,
    bool own = false,
    bool wishlist = false,
  }) async {
    try {
      final xmlString = await _api.fetchCollection(
        userName: userName,
        own: own,
        wishlist: wishlist,
      );

      final document = XmlDocument.parse(xmlString);
      return Collection.fromXml(document.rootElement);
    } on BggException {
      rethrow;
    } catch (e) {
      throw BggParsingException();
    }
  }
}
