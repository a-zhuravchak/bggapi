# BGG API

A lightweight Dart client for accessing the [BoardGameGeek XML API2](https://boardgamegeek.com/wiki/page/BGG_XML_API2).

This package provides simple tools to fetch and parse BoardGameGeek user collections, with network error handling and XML parsing built-in.

## Features

- Fetch user collections from BoardGameGeek.
- Parse XML responses into Dart objects.
- Handle API retries and errors gracefully.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  bggapi: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

Here’s an example of how to use the CollectionRepository to fetch a user’s collection:

```dart
import 'package:bggapi/bggapi.dart';

void main() async {
  final api = BggCollectionApi();
  final repository = CollectionRepository(api: api);

  try {
    final collection = await repository.getCollection(userName: 'testuser');
    print('Total items: ${collection.totalItems}');
    for (var item in collection.items) {
      print('Item ID: ${item.objectId}');
    }
  } catch (e) {
    print('Error fetching collection: $e');
  }
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
