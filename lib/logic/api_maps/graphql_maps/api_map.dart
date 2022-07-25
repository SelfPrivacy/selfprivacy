import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ApiMap {
  Future<GraphQLClient> getClient() async {
    final httpLink = HttpLink(
      'https://api.$rootAddress/graphql',
    );

    final Link graphQLLink = isWithToken
        ? AuthLink(
            getToken: () async => authToken,
          ).concat(httpLink)
        : httpLink;

    return GraphQLClient(
      cache: GraphQLCache(),
      link: graphQLLink,
    );
  }

  abstract final String? rootAddress;
  abstract final bool hasLogger;
  abstract final bool isWithToken;
  abstract final String authToken;
}
