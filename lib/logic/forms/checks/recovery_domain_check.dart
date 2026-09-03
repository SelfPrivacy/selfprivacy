import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';

Future<bool> checkRecoveryDomain(final String domain) async =>
    await ServerApi(
      hasLogger: false,
      domainProvider: () => domain,
    ).getApiVersion() !=
    null;
