import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/get_it/developer_settings_model.dart';

GraphQLTransport aGraphQLTransport({
  final GraphQLDomainProvider? domainProvider,
  final GraphQLTokenProvider? tokenProvider,
}) => GraphQLTransport(
  domainProvider: domainProvider ?? () => null,
  tokenProvider: tokenProvider,
  localeProvider: () => 'en',
  tlsContext: TlsContext(DeveloperSettingsModel()),
  consoleLog: (_) {},
);

ServerApi aServerApi({
  final GraphQLDomainProvider? domainProvider,
  final GraphQLTokenProvider? tokenProvider,
}) => ServerApi(
  transport: aGraphQLTransport(
    domainProvider: domainProvider,
    tokenProvider: tokenProvider,
  ),
);
