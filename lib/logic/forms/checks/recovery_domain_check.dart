import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';

Future<bool> checkRecoveryDomain(final String domain) async =>
    await ServerApi(
      transport: createGraphQLTransport(domainProvider: () => domain),
    ).getApiVersion() !=
    null;
