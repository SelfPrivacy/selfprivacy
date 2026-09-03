import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:web_socket_channel/io.dart';

abstract class GraphQLApiMap {
  void Function(String, {Object? error, StackTrace? stackTrace}) get logger =>
      const AppLogger(name: 'graphql_map').log;

  Future<GraphQLClient> getClient({
    final TlsPolicy tlsPolicy = TlsPolicy.strict,
  }) async {
    if (tlsPolicy == TlsPolicy.allowUnverified && isWithToken) {
      throw StateError(
        'A token-bearing client must not opt out of certificate verification',
      );
    }

    final httpLink = HttpLink(
      'https://$_host/graphql',
      httpClient: getIt<TlsContext>().clientFor(host: _host, policy: tlsPolicy),
      parser: ResponseLoggingParser(),
      defaultHeaders: {'Accept-Language': _locale},
    );

    final token = apiToken;
    final Link graphQLLink = RequestLoggingLink().concat(
      isWithToken
          ? AuthLink(getToken: () => 'Bearer $token').concat(httpLink)
          : httpLink,
    );

    // Every request goes through either chain:
    // 1. RequestLoggingLink -> AuthLink -> HttpLink
    // 2. RequestLoggingLink -> HttpLink

    return GraphQLClient(cache: GraphQLCache(), link: graphQLLink);
  }

  Future<GraphQLClient> getSubscriptionClient({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
  }) async {
    final token = apiToken;
    final Map<String, dynamic>? headers = token.isEmpty
        ? null
        : {'Authorization': 'Bearer $token', 'Accept-Language': _locale};

    final WebSocketLink webSocketLink = WebSocketLink(
      'wss://$_host/graphql',
      // Only [GraphQLProtocol.graphqlTransportWs] supports automatic pings, so we don't disconnect when nothing happens.
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        onConnectionLost: onConnectionLost,
        autoReconnect: true,
        initialPayload: token.isEmpty
            ? null
            : {'Authorization': 'Bearer $token'},
        headers: headers,
        connectFn: (final Uri uri, final Iterable<String>? protocols) =>
            IOWebSocketChannel.connect(
              uri,
              protocols: protocols,
              headers: headers,
              customClient: getIt<TlsContext>().httpClientFor(host: uri.host),
            ).forGraphQL(),
      ),
    );

    return GraphQLClient(cache: GraphQLCache(), link: webSocketLink);
  }

  String get _host => 'api.$rootAddress';

  String get _locale => getIt.get<ApiConfigModel>().localeCode;

  abstract final String? rootAddress;
  abstract final bool hasLogger;
  abstract final bool isWithToken;
  abstract final String apiToken;
}
