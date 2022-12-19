// ignore_for_file: prefer_foreach

import 'dart:async';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';
import 'package:selfprivacy/logic/models/message.dart';

void _logToAppConsole<T>(final T objectToLog) {
  getIt.get<ConsoleModel>().addMessage(
        Message(
          text: objectToLog.toString(),
        ),
      );
}

class LoggingLink extends Link {
  @override
  Stream<Response> request(
    final Request request, [
    final NextLink? forward,
  ]) async* {
    _logToAppConsole(request);
    yield* forward!(request);
  }
}

class LoggingResponseParser extends ResponseParser {
  @override
  Response parseResponse(final Map<String, dynamic> body) {
    final response = super.parseResponse(body);
    _logToAppConsole(response);
    return response;
  }

  @override
  GraphQLError parseError(final Map<String, dynamic> error) {
    final graphQlError = super.parseError(error);
    _logToAppConsole(graphQlError);
    return graphQlError;
  }
}

abstract class ApiMap {
  Future<GraphQLClient> getClient() async {
    IOClient? ioClient;
    if (StagingOptions.stagingAcme) {
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
      parser: LoggingResponseParser(),
    );

    final String token = _getApiToken();

    final Link graphQLLink = LoggingLink().concat(
      isWithToken
          ? AuthLink(
              getToken: () async =>
                  customToken == '' ? 'Bearer $token' : customToken,
            ).concat(httpLink)
          : httpLink,
    );

    // Every request goes through either chain:
    // 1. AuthLink -> HttpLink -> LoggingLink
    // 2.             HttpLink -> LoggingLink

    return GraphQLClient(
      cache: GraphQLCache(),
      link: graphQLLink,
    );
  }

  Future<GraphQLClient> getSubscriptionClient() async {
    final String token = _getApiToken();

    final WebSocketLink webSocketLink = WebSocketLink(
      'ws://api.$rootAddress/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        headers: token.isEmpty ? null : {'Authorization': 'Bearer $token'},
      ),
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: webSocketLink,
    );
  }

  String _getApiToken() {
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
