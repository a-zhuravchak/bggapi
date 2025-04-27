import 'package:bggapi/bgg_flutter_client.dart';
import 'package:bggapi/src/core/exceptions/bgg_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockBggSearchApi mockApi;
  late SearchRepository repo;

  const sampleSearchXml = '''
<items total="1">
  <item id="99" type="boardgame">
    <name value="Search Game"/>
    <yearpublished value="2019"/>
    <thumbnail>https://…/s_thumb.jpg</thumbnail>
    <image>https://…/s_image.jpg</image>
  </item>
</items>
''';

  setUp(() {
    mockApi = MockBggSearchApi();
    repo = SearchRepository(api: mockApi);
  });

  test('returns parsed SearchResults on 200', () async {
    when(mockApi.fetchSearch(
      query: anyNamed('query'),
      type: anyNamed('type'),
    )).thenAnswer((_) async => sampleSearchXml);

    final results = await repo.search(query: 'game', type: 'boardgame');

    expect(results.items, hasLength(1));
    final item = results.items.first;
    expect(item.id, 99);
    expect(item.name, 'Search Game');
    expect(item.yearPublished, 2019);
    expect(item.thumbnailUrl, isNotNull);
    expect(item.imageUrl, isNotNull);
  });

  test('rethrows BggRequestPendingException to caller', () async {
    when(mockApi.fetchSearch(
      query: anyNamed('query'),
      type: anyNamed('type'),
    )).thenThrow(BggRequestPendingException());

    expect(
      () => repo.search(query: 'game', type: 'boardgame'),
      throwsA(isA<BggRequestPendingException>()),
    );
  });

  test('throws BggParsingException on bad XML', () async {
    when(mockApi.fetchSearch(
      query: anyNamed('query'),
      type: anyNamed('type'),
    )).thenAnswer((_) async => '<bad xml>');

    expect(
      () => repo.search(query: 'game', type: 'boardgame'),
      throwsA(isA<BggParsingException>()),
    );
  });
}
