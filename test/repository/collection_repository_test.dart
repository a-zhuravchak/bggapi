import 'package:bgg_flutter_client/bgg_flutter_client.dart';
import 'package:bgg_flutter_client/src/core/exceptions/bgg_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockBggCollectionApi mockApi;
  late CollectionRepository repo;

  const sampleXml = '''
<items totalitems="1">
  <item objectid="42">
    <name>Example Game</name>
    <yearpublished>2021</yearpublished>
    <numplays>3</numplays>
    <thumbnail>https://…/thumb.jpg</thumbnail>
    <image>https://…/image.jpg</image>
  </item>
</items>
''';

  setUp(() {
    mockApi = MockBggCollectionApi();
    repo = CollectionRepository(api: mockApi);
  });

  test('returns parsed Collection on 200', () async {
    when(mockApi.fetchCollection(
      userName: anyNamed('userName'),
      own: anyNamed('own'),
      wishlist: anyNamed('wishlist'),
    )).thenAnswer((_) async => sampleXml);

    final col = await repo.getCollection(userName: 'user123');

    expect(col.items, hasLength(1));
    final item = col.items.first;
    expect(item.objectId, 42);
    expect(item.name, 'Example Game');
    expect(item.yearPublished, 2021);
    expect(item.numPlays, 3);
    expect(item.thumbnailUrl, isNotNull);
    expect(item.imageUrl, isNotNull);
  });

  test('rethrows BggRequestPendingException to caller', () async {
    when(mockApi.fetchCollection(
      userName: anyNamed('userName'),
      own: anyNamed('own'),
      wishlist: anyNamed('wishlist'),
    )).thenThrow(BggRequestPendingException());

    expect(
      () => repo.getCollection(userName: 'user123'),
      throwsA(isA<BggRequestPendingException>()),
    );
  });

  test('throws BggParsingException on invalid XML', () async {
    when(mockApi.fetchCollection(
      userName: anyNamed('userName'),
      own: anyNamed('own'),
      wishlist: anyNamed('wishlist'),
    )).thenAnswer((_) async => '<bad xml>');

    expect(
      () => repo.getCollection(userName: 'user123'),
      throwsA(isA<BggParsingException>()),
    );
  });
}
