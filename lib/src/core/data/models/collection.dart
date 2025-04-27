import 'package:xml/xml.dart';
import 'collection_item.dart';

/// Represents a BGG collection containing multiple items.
class Collection {
  final List<CollectionItem> items;

  Collection({required this.items});

  /// Parses a [Collection] from an XML root element.
  factory Collection.fromXml(XmlElement root) {
    final items =
        root.findElements('item').map(CollectionItem.fromXml).toList();
    return Collection(items: items);
  }
}
