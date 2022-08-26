import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

part 'volume_api.dart';
part 'jobs_api.dart';
part 'server_actions_api.dart';
part 'services_api.dart';

class ServerApi extends ApiMap with VolumeApi, JobsApi, ServerActionsApi {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken = '',
  }) {
    final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
    rootAddress = serverDomain?.domainName ?? '';
  }
  @override
  bool hasLogger;
  @override
  bool isWithToken;
  @override
  String customToken;
  @override
  String? rootAddress;

  Future<String?> getApiVersion() async {
    QueryResult response;
    String? apiVersion;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiVersion();
      if (response.hasException) {
        print(response.exception.toString());
      }
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
      response = await client.query$GetApiTokens();
      if (response.hasException) {
        print(response.exception.toString());
      }
      tokens = response.data!['api']['devices']
          .map<ApiToken>((final e) => ApiToken.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return tokens;
  }

  Future<void> switchService(final String uid, final bool needTurnOn) async {
    try {
      final GraphQLClient client = await getClient();
      if (needTurnOn) {
        final variables = Variables$Mutation$EnableService(serviceId: uid);
        final mutation = Options$Mutation$EnableService(variables: variables);
        await client.mutate$EnableService(mutation);
      } else {
        final variables = Variables$Mutation$DisableService(serviceId: uid);
        final mutation = Options$Mutation$DisableService(variables: variables);
        await client.mutate$DisableService(mutation);
      }
    } catch (e) {
      print(e);
    }
  }
}
