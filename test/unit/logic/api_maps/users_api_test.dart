import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';

class _UsersApi extends GraphQLApiMap with UsersApi {
  _UsersApi(super.transport);
}

class _MockGraphQLTransport extends Mock implements GraphQLTransport {}

GraphQLClient _clientReturning(final Map<String, dynamic> data) =>
    GraphQLClient(
      cache: GraphQLCache(),
      link: Link.function(
        (final Request request, [final NextLink? forward]) =>
            Stream.value(Response(data: data, response: const {})),
      ),
    );

void main() {
  test('delegates subscription client creation to the transport', () async {
    final transport = _MockGraphQLTransport();
    final client = _clientReturning(const {});
    Future<Duration?> onConnectionLost(
      final int? code,
      final String? reason,
    ) async => null;
    when(
      () => transport.subscriptionClient(onConnectionLost: onConnectionLost),
    ).thenReturn(client);

    final api = _UsersApi(transport);

    expect(
      await api.getSubscriptionClient(onConnectionLost: onConnectionLost),
      same(client),
    );
  });
}
