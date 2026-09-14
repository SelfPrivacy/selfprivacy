import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';

class _MockGraphQLTransport extends Mock implements GraphQLTransport {}

GraphQLTransport transportWithLink(final Link link) {
  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache, error: ErrorPolicy.all),
      subscribe: Policies(fetch: FetchPolicy.noCache, error: ErrorPolicy.all),
    ),
  );
  final transport = _MockGraphQLTransport();
  when(transport.client).thenReturn(client);
  when(transport.subscriptionClient).thenReturn(client);
  return transport;
}
