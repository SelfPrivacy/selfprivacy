import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/utils/app_logger.dart';

abstract class GraphQLApiMap {
  GraphQLApiMap(this.transport);

  final GraphQLTransport transport;

  void Function(String, {Object? error, StackTrace? stackTrace}) get logger =>
      const AppLogger(name: 'graphql_map').log;

  Future<GraphQLClient> getClient() async => transport.client();

  Future<GraphQLClient> getSubscriptionClient({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
  }) async => transport.subscriptionClient(onConnectionLost: onConnectionLost);
}
