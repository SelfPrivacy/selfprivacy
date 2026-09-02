import 'dart:convert';
import 'dart:io';

Map<String, dynamic> loadJsonFixture(final String relativePath) =>
    jsonDecode(File('test/fixtures/$relativePath').readAsStringSync())
        as Map<String, dynamic>;

Map<String, dynamic> loadJsonFixtureItem(
  final String relativePath,
  final String collectionKey,
) =>
    (loadJsonFixture(relativePath)[collectionKey] as List<dynamic>).single
        as Map<String, dynamic>;
