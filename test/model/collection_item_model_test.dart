import 'package:bggapi/bgg_flutter_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  test('CollectionItem.fromXml handles missing optional fields', () {
    final xml = XmlDocument.parse('''
      <item objectid="123">
        <name>Test Game</name>
      </item>
    ''').rootElement;

    final item = CollectionItem.fromXml(xml);
    expect(item.objectId, 123);
    expect(item.name, 'Test Game');
    expect(item.yearPublished, isNull);
    expect(item.numPlays, isNull);
    expect(item.thumbnailUrl, isNull);
    expect(item.imageUrl, isNull);
  });
}
