import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/get_api_tokens.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/get_api_version.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/get_server_disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

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
    String? apiVersion;

    final GraphQLClient client = await getClient();
    try {
      response = await client.query$GetApiVersionQuery();
      apiVersion = response.data!['api']['version'];
    } catch (e) {
      print(e);
    }
    return apiVersion;
  }

  Future<List<ApiToken>> getApiTokens() async {
    QueryResult response;
    List<ApiToken> tokens = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiTokensQuery();
      tokens = response.data!['api']['devices']
          .map<ApiToken>((final e) => ApiToken.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return tokens;
  }

  Future<List<ServerDiskVolume>> getServerDiskVolumes() async {
    QueryResult response;
    List<ServerDiskVolume> volumes = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetServerDiskVolumesQuery();
      volumes = response.data!['storage']['volumes']
          .map<ServerDiskVolume>((final e) => ServerDiskVolume.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return volumes;
  }
}
