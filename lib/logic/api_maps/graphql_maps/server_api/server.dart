import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

part 'jobs_api.dart';
part 'server_actions_api.dart';
part 'services_api.dart';
part 'users_api.dart';
part 'volume_api.dart';

class GenericMutationResult {
  GenericMutationResult({
    required this.success,
    required this.code,
    this.message,
  });
  final bool success;
  final int code;
  final String? message;
}

class GenericJobMutationReturn extends GenericMutationResult {
  GenericJobMutationReturn({
    required final super.success,
    required final super.code,
    final super.message,
    this.job,
  });
  final ServerJob? job;
}

class ServerApi extends ApiMap
    with VolumeApi, JobsApi, ServerActionsApi, ServicesApi, UsersApi {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken = '',
  });

  @override
  bool hasLogger;
  @override
  bool isWithToken;
  @override
  String customToken;
  @override
  String? get rootAddress => getIt<ApiConfigModel>().serverDomain?.domainName;

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

  Future<bool> isUsingBinds() async {
    QueryResult response;
    bool usesBinds = false;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemIsUsingBinds();
      if (response.hasException) {
        print(response.exception.toString());
      }
      usesBinds = response.data!['system']['info']['usingBinds'];
    } catch (e) {
      print(e);
    }
    return usesBinds;
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

  Future<void> setAutoUpgradeSettings(
    final bool allowReboot,
    final bool enableAutoUpgrade,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final input = Input$AutoUpgradeSettingsInput(
        allowReboot: allowReboot,
        enableAutoUpgrade: enableAutoUpgrade,
      );
      final variables = Variables$Mutation$ChangeAutoUpgradeSettings(
        settings: input,
      );
      final mutation = Options$Mutation$ChangeAutoUpgradeSettings(
        variables: variables,
      );
      await client.mutate$ChangeAutoUpgradeSettings(mutation);
    } catch (e) {
      print(e);
    }
  }
}
