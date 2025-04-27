import 'package:xml/xml.dart';

/// A single search result item.
class SearchResultItem {
  /// BGG’s integer ID for this item.
  final int id;

  /// The name value.
  final String name;

  /// Thing-type (e.g. “boardgame”).
  final String? type;

  /// Year published, if present.
  final int? yearPublished;

  /// URL to the thumbnail (small) image.
  final String? thumbnailUrl;

  /// URL to the full-size image.
  final String? imageUrl;

  SearchResultItem({
    required this.id,
    required this.name,
    this.type,
    this.yearPublished,
    this.thumbnailUrl,
    this.imageUrl,
  });

  /// Parse one `<item>` element from the `/search` response.
  factory SearchResultItem.fromXml(XmlElement xml) {
    final id = int.parse(xml.getAttribute('id')!);
    final name = xml.getElement('name')?.getAttribute('value') ?? 'Unknown';
    final type = xml.getAttribute('type');
    final yearEl = xml.getElement('yearpublished');
    final year = yearEl == null ? null : int.tryParse(yearEl.getAttribute('value')!);
    final thumb = xml.getElement('thumbnail')?.innerText;
    final img = xml.getElement('image')?.innerText;

    return SearchResultItem(
      id: id,
      name: name,
      type: type,
      yearPublished: year,
      thumbnailUrl: thumb,
      imageUrl: img,
    );
  }
}

/// Wraps a list of [SearchResultItem]s.
class SearchResults {
  /// All matched items.
  final List<SearchResultItem> items;

  SearchResults({required this.items});

  /// Parse root `<items>` element into [SearchResults].
  factory SearchResults.fromXml(XmlElement root) {
    final list = root.findElements('item').map((e) => SearchResultItem.fromXml(e)).toList();
    return SearchResults(items: list);
  }
}
