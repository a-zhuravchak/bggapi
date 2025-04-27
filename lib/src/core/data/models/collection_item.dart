import 'package:xml/xml.dart';

/// Represents a single item in a BGG collection.
class CollectionItem {
  final int objectId;
  final String name;
  final int? yearPublished;
  final int? numPlays;
  final String? thumbnailUrl;
  final String? imageUrl;

  CollectionItem({
    required this.objectId,
    required this.name,
    this.yearPublished,
    this.numPlays,
    this.thumbnailUrl,
    this.imageUrl,
  });

  /// Parses a [CollectionItem] from an XML element.
  factory CollectionItem.fromXml(XmlElement element) {
    final name = element.getElement('name')?.innerText ?? 'Unknown';
    final year = int.tryParse(element.getElement('yearpublished')?.innerText ?? '');
    final plays = int.tryParse(element.getElement('numplays')?.innerText ?? '');
    final thumb = element.getElement('thumbnail')?.innerText;
    final img = element.getElement('image')?.innerText;

    return CollectionItem(
      objectId: int.parse(element.getAttribute('objectid')!),
      name: name,
      yearPublished: year,
      numPlays: plays,
      thumbnailUrl: thumb,
      imageUrl: img,
    );
  }
}
