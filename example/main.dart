import 'package:bgg_flutter_client/src/bgg_client.dart';
import 'package:bgg_flutter_client/src/core/exceptions/bgg_exceptions.dart';
import 'package:flutter/foundation.dart';

void main() async {
  final client = BggClient();

  try {
    final collection = await client.getCollection(userName: 'username');

    for (final item in collection.items) {
      debugPrint('${item.name} (${item.yearPublished}) - Played ${item.numPlays} times');
    }
  } on BggTimeoutException {
    debugPrint('Request timed out.');
  } on BggServerException catch (e) {
    debugPrint('Server error: ${e.message}');
  } on BggParsingException {
    debugPrint('Failed to parse XML response.');
  } catch (e) {
    debugPrint('Unexpected error: $e');
  }

  final results = await client.search(query: 'Catan');
  for (var r in results.items) {
    debugPrint('${r.name} (ID: ${r.id}) – published ${r.yearPublished}');
  }
}
