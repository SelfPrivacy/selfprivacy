import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/models/message.dart';

void _logToAppConsole<T>(final T objectToLog) {
  getIt.get<ConsoleModel>().addMessage(
        Message(
          text: objectToLog.toString(),
        ),
      );
}

class RequestLoggingLink extends Link {
  @override
  Stream<Response> request(
    final Request request, [
    final NextLink? forward,
  ]) async* {
    getIt.get<ConsoleModel>().addMessage(
          GraphQlRequestMessage(
            operation: request.operation,
            variables: request.variables,
            context: request.context,
          ),
        );
    yield* forward!(request);
  }
}

class ResponseLoggingParser extends ResponseParser {
  @override
  Response parseResponse(final Map<String, dynamic> body) {
    final response = super.parseResponse(body);
    getIt.get<ConsoleModel>().addMessage(
          GraphQlResponseMessage(
            data: response.data,
            errors: response.errors,
            context: response.context,
          ),
        );
    return response;
  }

  @override
  GraphQLError parseError(final Map<String, dynamic> error) {
    final graphQlError = super.parseError(error);
    _logToAppConsole(graphQlError);
    return graphQlError;
  }
}

abstract class GraphQLApiMap {
  Future<GraphQLClient> getClient() async {
    IOClient? ioClient;
    if (TlsOptions.stagingAcme || !TlsOptions.verifyCertificate) {
      final HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = (
        final cert,
        final host,
        final port,
      ) =>
          true;
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
              getToken: () async =>
                  customToken == '' ? 'Bearer $_token' : customToken,
            ).concat(httpLink)
          : httpLink,
    );

    // Every request goes through either chain:
    // 1. RequestLoggingLink -> AuthLink -> HttpLink
    // 2. RequestLoggingLink -> HttpLink

    return GraphQLClient(
      cache: GraphQLCache(),
      link: graphQLLink,
    );
  }

  Future<GraphQLClient> getSubscriptionClient() async {
    final WebSocketLink webSocketLink = WebSocketLink(
      'ws://api.$rootAddress/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        headers: _token.isEmpty
            ? null
            : {
                'Authorization': 'Bearer $_token',
                'Accept-Language': _locale,
              },
      ),
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: webSocketLink,
    );
  }

  String get _locale => getIt.get<ApiConfigModel>().localeCode ?? 'en';

  String get _token {
    String token = '';
    final serverDetails = getIt<ApiConfigModel>().serverDetails;
    if (serverDetails != null) {
      token = getIt<ApiConfigModel>().serverDetails!.apiToken;
    }
    return token;
  }

  abstract final String? rootAddress;
  abstract final bool hasLogger;
  abstract final bool isWithToken;
  abstract final String customToken;
}
