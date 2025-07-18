import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/utils/app_logger.dart';

void _addConsoleLog(final ConsoleLog message) =>
    getIt.get<ConsoleModel>().log(message);

class RequestLoggingLink extends Link {
  @override
  Stream<Response> request(
    final Request request, [
    final NextLink? forward,
  ]) async* {
    _addConsoleLog(
      GraphQlRequestConsoleLog(
        // context: request.context,
        operationType: request.type.name,
        operation: request.operation,
        variables: request.variables,
      ),
    );
    yield* forward!(request);
  }
}

class ResponseLoggingParser extends ResponseParser {
  @override
  Response parseResponse(final Map<String, dynamic> body) {
    final response = super.parseResponse(body);
    _addConsoleLog(
      GraphQlResponseConsoleLog(
        // context: response.context,
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
    _addConsoleLog(
      ManualConsoleLog.warning(
        customTitle: 'GraphQL Error',
        content: graphQlError.toString(),
      ),
    );
    return graphQlError;
  }
}

abstract class GraphQLApiMap {
  void Function(String, {Object? error, StackTrace? stackTrace}) get logger =>
      const AppLogger(name: 'graphql_map').log;

  Future<GraphQLClient> getClient() async {
    IOClient? ioClient;
    if (TlsOptions.stagingAcme || !TlsOptions.verifyCertificate) {
      final HttpClient httpClient =
          HttpClient()
            ..badCertificateCallback =
                (final cert, final host, final port) => true;
      ioClient = IOClient(httpClient);
    }

    final httpLink = HttpLink(
      'https://api.$rootAddress/graphql',
      httpClient: ioClient,
      parser: ResponseLoggingParser(),
      defaultHeaders: {'Accept-Language': _locale},
    );

    final Link graphQLLink = RequestLoggingLink().concat(
      isWithToken
          ? AuthLink(
            getToken: () => customToken == '' ? 'Bearer $_token' : customToken,
          ).concat(httpLink)
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
    final WebSocketLink webSocketLink = WebSocketLink(
      'ws://api.$rootAddress/graphql',
      // Only [GraphQLProtocol.graphqlTransportWs] supports automatic pings, so we don't disconnect when nothing happens.
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        onConnectionLost: onConnectionLost,
        autoReconnect: true,
        initialPayload:
            _token.isEmpty ? null : {'Authorization': 'Bearer $_token'},
        headers:
            _token.isEmpty
                ? null
                : {
                  'Authorization': 'Bearer $_token',
                  'Accept-Language': _locale,
                },
      ),
    );

    return GraphQLClient(cache: GraphQLCache(), link: webSocketLink);
  }

  String get _locale => getIt.get<ApiConfigModel>().localeCode;

  String get _token {
    String token = '';
    final serverDetails = getIt<ResourcesModel>().serverDetails;
    if (serverDetails != null) {
      token = serverDetails.apiToken;
    }

    return token;
  }

  abstract final String? rootAddress;
  abstract final bool hasLogger;
  abstract final bool isWithToken;
  abstract final String customToken;
}
