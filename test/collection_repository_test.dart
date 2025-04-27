// import 'package:bggapi/src/core/data/bgg_collection_api.dart';
// import 'package:bggapi/src/core/domain/collection/collection_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dio/dio.dart';
// import 'package:xml/xml.dart';
// import 'mocks/mock_dio.dart';
// import 'package:bggapi/src/core/data/bgg_collection_api.dart';
// import 'package:bggapi/src/core/domain/collection/collection_repository.dart';
// import 'package:bggapi/src/core/data/models/collection.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:dio/dio.dart';
// import 'collection_repository_test.mocks.dart';

// @GenerateMocks([BggCollectionApi])
// void main() {
//   late MockBggCollectionApi mockApi;
//   late CollectionRepository repository;

//   setUp(() {
//     mockApi = MockBggCollectionApi();
//     repository = CollectionRepository(api: mockApi);
//   });

//   Future<void> mockFetchSuccess(XmlElement xmlResponse) async {
//     when(mockApi.fetchCollection(userName: anyNamed('userName'))).thenAnswer(
//       (_) async => Collection.fromXml(xmlResponse),
//     );
//   }

//   Future<void> mockFetchError(Exception exception) async {
//     when(mockApi.fetchCollection(userName: anyNamed('userName'))).thenThrow(exception);
//   }

//   test('getCollection() returns parsed Collection', () async {
//     const fakeResponse = '<items totalitems="1"><item objectid="1"></item></items>';

//     await mockFetchSuccess(fakeResponse);

//     final result = await repository.getCollection(userName: 'testuser');

//     expect(result.totalItems, equals(1));
//     expect(result.items.length, equals(1));
//   });

//   test('getCollection() retries on 202 and eventually succeeds', () async {
//     const fakeResponse = '<items totalitems="1"><item objectid="1"></item></items>';

//     when(mockApi.fetchCollection(userName: anyNamed('userName')))
//         .thenThrow(DioException(
//           requestOptions: RequestOptions(path: ''),
//           response: Response(
//             requestOptions: RequestOptions(path: ''),
//             statusCode: 202,
//           ),
//           type: DioExceptionType.badResponse,
//         ))
//         .thenAnswer((_) async => Collection.fromXml(fakeResponse));

//     final result = await repository.getCollection(userName: 'testuser');

//     expect(result.totalItems, equals(1));
//     expect(result.items.length, equals(1));
//   });

//   test('getCollection() throws on 500 error', () async {
//     await mockFetchError(DioException(
//       requestOptions: RequestOptions(path: ''),
//       response: Response(
//         requestOptions: RequestOptions(path: ''),
//         statusCode: 500,
//       ),
//       type: DioExceptionType.badResponse,
//     ));

//     expect(() => repository.getCollection(userName: 'testuser'), throwsA(isA<DioException>()));
//   });

//   test('getCollection() throws on invalid XML response', () async {
//     const invalidResponse = '<invalid>';

//     when(mockApi.fetchCollection(userName: anyNamed('userName')))
//         .thenAnswer((_) async => Collection.fromXml(invalidResponse));

//     expect(() => repository.getCollection(userName: 'testuser'), throwsA(isA<FormatException>()));
//   });

//   test('getCollection() handles empty collection response', () async {
//     const emptyResponse = '<items totalitems="0"></items>';

//     await mockFetchSuccess(emptyResponse);

//     final result = await repository.getCollection(userName: 'testuser');

//     expect(result.totalItems, equals(0));
//     expect(result.items.isEmpty, isTrue);
//   });
// }
