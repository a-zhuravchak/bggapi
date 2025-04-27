import 'package:bggapi/bgg_flutter_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  test('SearchResultItem.fromXml handles missing thumbnail/image', () {
    final xml = XmlDocument.parse('''
      <item id="99" type="boardgame">
        <name value="Foo"/>
      </item>
    ''').rootElement;

    final result = SearchResultItem.fromXml(xml);
    expect(result.id, 99);
    expect(result.name, 'Foo');
    expect(result.thumbnailUrl, isNull);
    expect(result.imageUrl, isNull);
  });
}
