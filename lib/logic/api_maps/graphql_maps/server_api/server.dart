import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

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
    required super.success,
    required super.code,
    super.message,
    this.job,
  });
  final ServerJob? job;
}

class ApiResponse<D> {
  ApiResponse({
    required this.statusCode,
    required this.data,
    this.errorMessage,
  });
  final int statusCode;
  final String? errorMessage;
  final D data;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

class ServerApi extends ApiMap
    with VolumeApi, JobsApi, ServerActionsApi, ServicesApi, UsersApi {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken = '',
    this.overrideDomain,
  });

  @override
  bool hasLogger;
  @override
  bool isWithToken;
  @override
  String customToken;
  @override
  String? get rootAddress =>
      overrideDomain ?? getIt<ApiConfigModel>().serverDomain?.domainName;
  String? overrideDomain;

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
    final AutoUpgradeSettings settings,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final input = Input$AutoUpgradeSettingsInput(
        allowReboot: settings.allowReboot,
        enableAutoUpgrade: settings.enable,
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

  Future<void> setTimezone(final String timezone) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$ChangeTimezone(
        timezone: timezone,
      );
      final mutation = Options$Mutation$ChangeTimezone(
        variables: variables,
      );
      await client.mutate$ChangeTimezone(mutation);
    } catch (e) {
      print(e);
    }
  }

  Future<SystemSettings> getSystemSettings() async {
    QueryResult<Query$SystemSettings> response;
    SystemSettings settings = SystemSettings(
      autoUpgradeSettings: AutoUpgradeSettings(
        allowReboot: false,
        enable: false,
      ),
      sshSettings: SshSettings(
        enable: false,
        passwordAuthentication: false,
      ),
      timezone: 'Unknown',
    );

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemSettings();
      if (response.hasException) {
        print(response.exception.toString());
      }
      settings = SystemSettings.fromGraphQL(response.parsedData!.system);
    } catch (e) {
      print(e);
    }

    return settings;
  }

  Future<ApiResponse<RecoveryKeyStatus?>> getRecoveryTokenStatus() async {}

  Future<ApiResponse<String>> generateRecoveryToken(
    final DateTime? expirationDate,
    final int? numberOfUses,
  ) async {}

  Future<String?> getDkim() async {}

  Future<ApiResponse<List<ApiToken>>> getApiTokens() async {}

  Future<ApiResponse<void>> deleteApiToken(final String name) async {}

  Future<ApiResponse<String>> createDeviceToken() async {}

  Future<BackupStatus> getBackupStatus() async {}

  Future<List<Backup>> getBackups() async {}

  Future<void> uploadBackblazeConfig(final BackblazeBucket bucket) async {}

  Future<void> forceBackupListReload() async {}

  Future<void> startBackup() async {}

  Future<void> restoreBackup(final String backupId) async {}

  Future<bool> isHttpServerWorking() async {}

  Future<ApiResponse<String>> authorizeDevice(final DeviceToken token) async {}

  Future<ApiResponse<String>> useRecoveryToken(final DeviceToken token) async {}

  Future<Map<String, bool>> servicesPowerCheck() async {}

  Future<ApiResponse<List<String>>> getUsersList({
    required final bool withMainUser,
  }) async {}
}
