import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/get_api_version.graphql.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ServerApi extends ApiMap {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.authToken = '',
  }) {
    final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
    rootAddress = serverDomain?.domainName ?? '';
  }
  @override
  bool hasLogger;
  @override
  bool isWithToken;
  @override
  String authToken;
  @override
  String? rootAddress;

  Future<String?> getApiVersion() async {
    QueryResult response;

    final GraphQLClient client = await getClient();
    String? apiVersion;

    try {
      response = await client.query$GetApiVersionQuery();
      apiVersion = response.data!['api']['version'];
    } catch (e) {
      print(e);
    }
    return apiVersion;
  }
}
