import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';

/// Rejects partial responses and preserves the original request exception.
T requireServerApiData<T extends Object>(final QueryResult<T> response) {
  final exception = response.exception;
  if (exception != null) {
    if (exception.linkException?.originalException
        case final GraphQLDispatchDeferred deferred) {
      throw deferred;
    }
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
