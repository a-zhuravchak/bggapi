import 'package:xml/xml.dart';

/// Represents a single item in a BGG collection.
class CollectionItem {
  final int objectId;
  final String name;
  final int? yearPublished;
  final int? numPlays;

  CollectionItem({
    required this.objectId,
    required this.name,
    this.yearPublished,
    this.numPlays,
  });

  /// Parses a [CollectionItem] from an XML element.
  factory CollectionItem.fromXml(XmlElement element) {
    final name = element.getElement('name')?.innerText ?? 'Unknown';
    final year =
        int.tryParse(element.getElement('yearpublished')?.innerText ?? '');
    final plays = int.tryParse(element.getElement('numplays')?.innerText ?? '');

    return CollectionItem(
      objectId: int.parse(element.getAttribute('objectid')!),
      name: name,
      yearPublished: year,
      numPlays: plays,
    );
  }
}
