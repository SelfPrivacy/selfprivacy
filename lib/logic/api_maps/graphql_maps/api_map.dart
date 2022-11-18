import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';

abstract class ApiMap {
  Future<GraphQLClient> getClient() async {
    final HttpClient httpClient = HttpClient();
    if (StagingOptions.stagingAcme) {
      httpClient.badCertificateCallback = (
        final cert,
        final host,
        final port,
      ) =>
          true;
    }

    final httpLink = HttpLink(
      'https://api.$rootAddress/graphql',
      httpClient: IOClient(httpClient),
    );

    final String token = _getApiToken();

    final Link graphQLLink = isWithToken
        ? AuthLink(
            getToken: () async =>
                customToken == '' ? 'Bearer $token' : customToken,
          ).concat(httpLink)
        : httpLink;

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
