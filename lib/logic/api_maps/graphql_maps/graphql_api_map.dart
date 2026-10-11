import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';

abstract class GraphQLApiMap {
  GraphQLApiMap(this.transport);

  final GraphQLTransport transport;

  Future<GraphQLClient> getClient() async => transport.client();

  Future<GraphQLClient> getSubscriptionClient({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
    final void Function({required bool connected})? onConnectionState,
  }) async => transport.subscriptionClient(
    onConnectionLost: onConnectionLost,
    onConnectionState: onConnectionState,
  );
}
