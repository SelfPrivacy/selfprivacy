import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:web_socket_channel/io.dart';

typedef GraphQLDomainProvider = String? Function();
typedef GraphQLTokenProvider = String? Function();
typedef GraphQLLocaleProvider = String Function();
typedef ConsoleLogSink = void Function(ConsoleLog);

class RequestLoggingLink extends Link {
  RequestLoggingLink({required final ConsoleLogSink consoleLog})
    : _consoleLog = consoleLog;

  final ConsoleLogSink _consoleLog;

  @override
  Stream<Response> request(
    final Request request, [
    final NextLink? forward,
  ]) async* {
    _consoleLog(
      GraphQlRequestConsoleLog(
        operationType: request.type.name,
        operation: request.operation,
        variables: request.variables,
      ),
    );
    yield* forward!(request);
  }
}

class ResponseLoggingParser extends ResponseParser {
  ResponseLoggingParser({required final ConsoleLogSink consoleLog})
    : _consoleLog = consoleLog;

  final ConsoleLogSink _consoleLog;

  @override
  Response parseResponse(final Map<String, dynamic> body) {
    final response = super.parseResponse(body);
    _consoleLog(
      GraphQlResponseConsoleLog(
        data: response.data,
        errors: response.errors,
        rawResponse: jsonEncode(response.response),
      ),
    );
    return response;
  }

  @override
  GraphQLError parseError(final Map<String, dynamic> error) {
    final graphQlError = super.parseError(error);
    _consoleLog(
      ManualConsoleLog.warning(
        customTitle: 'GraphQL Error',
        content: graphQlError.toString(),
      ),
    );
    return graphQlError;
  }
}

class GraphQLTransport {
  GraphQLTransport({
    required this.domainProvider,
    required this.localeProvider,
    required this.tlsContext,
    required this.consoleLog,
    this.tokenProvider,
    this.tlsPolicy = TlsPolicy.strict,
  });

  final GraphQLDomainProvider domainProvider;
  final GraphQLTokenProvider? tokenProvider;
  final GraphQLLocaleProvider localeProvider;
  final TlsContext tlsContext;
  final TlsPolicy tlsPolicy;
  final ConsoleLogSink consoleLog;

  String? get domain => domainProvider();
  String get token => tokenProvider?.call() ?? '';
  bool get isAuthenticated => tokenProvider != null;
  String get _host => 'api.$domain';

  GraphQLTransport withTlsPolicy(final TlsPolicy policy) => GraphQLTransport(
    domainProvider: domainProvider,
    tokenProvider: tokenProvider,
    localeProvider: localeProvider,
    tlsContext: tlsContext,
    tlsPolicy: policy,
    consoleLog: consoleLog,
  );

  void _validateTlsPolicy() {
    if (tlsPolicy == TlsPolicy.allowUnverified && isAuthenticated) {
      throw StateError(
        'A token-bearing client must not opt out of certificate verification',
      );
    }
  }

  GraphQLClient client() {
    _validateTlsPolicy();

    final httpLink = HttpLink(
      'https://$_host/graphql',
      httpClient: tlsContext.clientFor(host: _host, policy: tlsPolicy),
      parser: ResponseLoggingParser(consoleLog: consoleLog),
      defaultHeaders: {'Accept-Language': localeProvider()},
    );

    final currentToken = token;
    final Link link = RequestLoggingLink(consoleLog: consoleLog).concat(
      isAuthenticated
          ? AuthLink(getToken: () => 'Bearer $currentToken').concat(httpLink)
          : httpLink,
    );

    return GraphQLClient(cache: GraphQLCache(), link: link);
  }

  GraphQLClient subscriptionClient({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
  }) {
    _validateTlsPolicy();
    final currentToken = token;
    final Map<String, dynamic>? headers = currentToken.isEmpty
        ? null
        : {
            'Authorization': 'Bearer $currentToken',
            'Accept-Language': localeProvider(),
          };

    final webSocketLink = WebSocketLink(
      'wss://$_host/graphql',
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        onConnectionLost: onConnectionLost,
        autoReconnect: true,
        initialPayload: currentToken.isEmpty
            ? null
            : {'Authorization': 'Bearer $currentToken'},
        headers: headers,
        connectFn: (final Uri uri, final Iterable<String>? protocols) =>
            IOWebSocketChannel.connect(
              uri,
              protocols: protocols,
              headers: headers,
              customClient: tlsContext.httpClientFor(
                host: uri.host,
                policy: tlsPolicy,
              ),
            ).forGraphQL(),
      ),
    );

    return GraphQLClient(cache: GraphQLCache(), link: webSocketLink);
  }
}
