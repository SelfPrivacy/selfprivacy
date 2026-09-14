import 'package:graphql/client.dart';

/// Rejects partial responses and preserves the original request exception.
T requireServerApiData<T extends Object>(final QueryResult<T> response) {
  final exception = response.exception;
  if (exception != null) {
    throw exception;
  }
  final data = response.parsedData;
  if (data == null) {
    throw const MissingServerApiData();
  }
  return data;
}

class MissingServerApiData implements Exception {
  const MissingServerApiData();

  @override
  String toString() => 'The server response contains no required data.';
}
