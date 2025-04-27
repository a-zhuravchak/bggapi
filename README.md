# BGG API

A lightweight Dart client for accessing the [BoardGameGeek XML API2](https://boardgamegeek.com/wiki/page/BGG_XML_API2).

This package provides simple tools to fetch and parse BoardGameGeek API, with network error handling and XML parsing built-in.

## Features

- Fetch user collections from BoardGameGeek.
- Search BGG for games

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  bgg_flutter_client: ^0.0.1
```

Then run:
```bash
flutter pub get
```

## Usage

Here’s an example of how to use the BggClient to fetch a user’s collection or search for a game:

```dart
import 'package:bggapi/bggapi.dart';

void main() async {
  final client = BggClient(); 

  try {
    final collection = await client.getCollection(userName: 'username');
    for (final item in collection.items) {
      print('${item.name} (${item.yearPublished}) - Played ${item.numPlays} times');
    }
  } on BggTimeoutException {
    print('Request timed out.');
  } on BggServerException catch (e) {
    print('Server error: ${e.message}');
  } on BggParsingException {
    print('Failed to parse XML response.');
  } catch (e) {
    print('Unexpected error: $e');
  }

  final results = await client.search(query: 'Catan');
  for (var r in results.items) {
    print('${r.name} (ID: ${r.id}) – published ${r.yearPublished}');
  }
}
```
## License
BSD-3-Clause “New” or “Revised” License  
See the [LICENSE](LICENSE) file for details.

## 📜 BGG XML API Terms of Use

This client uses the BoardGameGeek XML API2.  
By using this package, you agree to BGG’s [Terms of Use](https://boardgamegeek.com/wiki/page/XML_API_Terms_of_Use#).
