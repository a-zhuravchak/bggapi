// test/mocks.dart

import 'package:bggapi/src/core/data/bgg_collection_api.dart';
import 'package:bggapi/src/core/data/bgg_search_api.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([BggCollectionApi, BggSearchApi])
void main() {}
