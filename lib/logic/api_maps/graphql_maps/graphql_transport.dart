import 'dart:convert';

import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:web_socket_channel/io.dart';

typedef GraphQLDomainProvider = String? Function();
typedef GraphQLTokenProvider = String? Function();
typedef GraphQLLocaleProvider = String Function();
typedef GraphQLAuthFailureHandler = void Function();
typedef ConsoleLogSink = void Function(ConsoleLog);

const String _unauthenticatedErrorCode = 'UNAUTHENTICATED';
const String _legacyUnauthenticatedErrorMessage =
    'You must be authenticated to access this resource.';

class SensitiveGraphQLRequest extends ContextEntry {
  const SensitiveGraphQLRequest();

  @override
  List<Object?> get fieldsForEquality => const [];
}

final sensitiveGraphQLContext = const Context().withEntry(
  const SensitiveGraphQLRequest(),
);

class GraphQLLoggingLink extends Link {
  GraphQLLoggingLink({required final ConsoleLogSink consoleLog})
    : _consoleLog = consoleLog;

  final ConsoleLogSink _consoleLog;

  @override
  Stream<Response> request(
    final Request request, [
    final NextLink? forward,
  ]) async* {
    final sensitive = request.context.entry<SensitiveGraphQLRequest>() != null;

    void logSensitive(final String phase, [final String? error]) {
      _consoleLog(
        ManualConsoleLog(
          customTitle: 'GraphQL $phase',
          content: jsonEncode({
            'type': request.type.name,
            'name':
                request.operation.operationName ??
                request.operation.document.definitions
                    .whereType<OperationDefinitionNode>()
                    .single
                    .name
                    ?.value,
            'error': ?error,
          }),
          severity: error == null
              ? ConsoleLogSeverity.normal
              : ConsoleLogSeverity.warning,
        ),
      );
    }

    if (sensitive) {
      logSensitive('Request');
    } else {
      _consoleLog(
        GraphQlRequestConsoleLog(
          operationType: request.type.name,
          operation: request.operation,
          variables: request.variables,
        ),
      );
    }
    try {
      await for (final response in forward!(request)) {
        if (sensitive) {
          logSensitive(
            'Response',
            response.errors?.isNotEmpty ?? false ? 'graphql' : null,
          );
        } else {
          _consoleLog(
            GraphQlResponseConsoleLog(
              data: response.data,
              errors: response.errors,
              rawResponse: jsonEncode(response.response),
            ),
          );
          for (final error in response.errors ?? const <GraphQLError>[]) {
            _consoleLog(
              ManualConsoleLog.warning(
                customTitle: 'GraphQL Error',
                content: error.toString(),
              ),
            );
          }
        }
        yield response;
      }
    } catch (_) {
      if (sensitive) {
        logSensitive('Error', 'transport');
      }
      rethrow;
    }
  }
}

class GraphQLTransport {
  GraphQLTransport({
    required this.domainProvider,
    required this.localeProvider,
    required this.tlsContext,
    required this.consoleLog,
    this.tokenProvider,
    this.onAuthFailure,
    this.tlsPolicy = TlsPolicy.strict,
  });

  final GraphQLDomainProvider domainProvider;
  final GraphQLTokenProvider? tokenProvider;
  final GraphQLLocaleProvider localeProvider;
  final GraphQLAuthFailureHandler? onAuthFailure;
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
    onAuthFailure: onAuthFailure,
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

  Link _watchAuthFailures(final Link link) {
    final callback = onAuthFailure;
    if (callback == null) {
      return link;
    }

    return ErrorLink(
      onGraphQLError: (final request, final forward, final response) {
        final hasAuthenticationError = response.errors?.any((final error) {
          final code = error.extensions?['code'];
          return code == _unauthenticatedErrorCode ||
              (code == null &&
                  error.message == _legacyUnauthenticatedErrorMessage);
        });
        if (hasAuthenticationError ?? false) {
          callback();
        }
        return null;
      },
    ).concat(link);
  }

  GraphQLClient client() {
    _validateTlsPolicy();

    final httpLink = HttpLink(
      'https://$_host/graphql',
      httpClient: tlsContext.clientFor(host: _host, policy: tlsPolicy),
      defaultHeaders: {'Accept-Language': localeProvider()},
    );

    final currentToken = token;
    final Link link = _watchAuthFailures(
      GraphQLLoggingLink(consoleLog: consoleLog).concat(
        isAuthenticated
            ? AuthLink(getToken: () => 'Bearer $currentToken').concat(httpLink)
            : httpLink,
      ),
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

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _watchAuthFailures(webSocketLink),
    );
  }
}
