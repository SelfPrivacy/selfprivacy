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

@Deprecated(
    'Extend GenericMutationResult for mutations, return data for queries')
class ApiResponse<D> {
  ApiResponse({
    required this.success,
    required this.data,
    this.message,
  });
  final bool success;
  final String? message;
  final D data;
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

  Future<ApiResponse<RecoveryKeyStatus?>> getRecoveryTokenStatus() async {
    RecoveryKeyStatus? key;
    QueryResult<Query$RecoveryKey> response;
    String? error;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$RecoveryKey();
      if (response.hasException) {
        print(response.exception.toString());
        error = response.exception.toString();
      }
      key = RecoveryKeyStatus.fromGraphQL(response.parsedData!.api.recoveryKey);
    } catch (e) {
      print(e);
    }

    return ApiResponse<RecoveryKeyStatus?>(
      success: error == null,
      data: key,
      message: error,
    );
  }

  Future<ApiResponse<String>> generateRecoveryToken(
    final DateTime? expirationDate,
    final int? numberOfUses,
  ) async {
    ApiResponse<String> key;
    QueryResult<Mutation$GetNewRecoveryApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final input = Input$RecoveryKeyLimitsInput(
        expirationDate: expirationDate,
        uses: numberOfUses,
      );
      final variables = Variables$Mutation$GetNewRecoveryApiKey(
        limits: input,
      );
      final mutation = Options$Mutation$GetNewRecoveryApiKey(
        variables: variables,
      );
      response = await client.mutate$GetNewRecoveryApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
        key = ApiResponse<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      key = ApiResponse<String>(
        success: true,
        data: response.parsedData!.getNewRecoveryApiKey.key!,
      );
    } catch (e) {
      print(e);
      key = ApiResponse<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return key;
  }

  Future<String?> getDkim() async {
    String? dkim;
    QueryResult<Query$DomainInfo> response;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$DomainInfo();
      if (response.hasException) {
        print(response.exception.toString());
      }
      dkim = response.parsedData!.system.domainInfo.requiredDnsRecords
          .firstWhere(
            (
              final Query$DomainInfo$system$domainInfo$requiredDnsRecords
                  dnsRecord,
            ) =>
                dnsRecord.name == 'selector._domainkey' &&
                dnsRecord.recordType == 'TXT',
          )
          .content;
    } catch (e) {
      print(e);
    }

    return dkim;
  }

  Future<ApiResponse<List<ApiToken>>> getApiTokens() async {
    ApiResponse<List<ApiToken>> tokens;
    QueryResult<Query$GetApiTokens> response;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiTokens();
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        tokens = ApiResponse<List<ApiToken>>(
          success: false,
          data: [],
          message: message,
        );
      }
      final List<ApiToken> parsed = response.parsedData!.api.devices
          .map(
            (
              final Query$GetApiTokens$api$devices device,
            ) =>
                ApiToken.fromGraphQL(device),
          )
          .toList();
      tokens = ApiResponse<List<ApiToken>>(
        success: true,
        data: parsed,
      );
    } catch (e) {
      print(e);
      tokens = ApiResponse<List<ApiToken>>(
        success: false,
        data: [],
        message: e.toString(),
      );
    }

    return tokens;
  }

  Future<ApiResponse<void>> deleteApiToken(final String name) async {
    ApiResponse<void> returnable;
    QueryResult<Mutation$DeleteDeviceApiToken> response;

    try {
      final GraphQLClient client = await getClient();

      final variables = Variables$Mutation$DeleteDeviceApiToken(
        device: name,
      );
      final mutation = Options$Mutation$DeleteDeviceApiToken(
        variables: variables,
      );
      response = await client.mutate$DeleteDeviceApiToken(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
        returnable = ApiResponse<void>(
          success: false,
          data: null,
          message: response.exception.toString(),
        );
      }
      returnable = ApiResponse<void>(
        success: true,
        data: null,
      );
    } catch (e) {
      print(e);
      returnable = ApiResponse<void>(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return returnable;
  }

  Future<ApiResponse<String>> createDeviceToken() async {
    ApiResponse<String> token;
    QueryResult<Mutation$GetNewDeviceApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final mutation = Options$Mutation$GetNewDeviceApiKey();
      response = await client.mutate$GetNewDeviceApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
        token = ApiResponse<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = ApiResponse<String>(
        success: true,
        data: response.parsedData!.getNewDeviceApiKey.key!,
      );
    } catch (e) {
      print(e);
      token = ApiResponse<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  Future<bool> isHttpServerWorking() async => (await getApiVersion()) != null;

  Future<ApiResponse<String>> authorizeDevice(
    final DeviceToken deviceToken,
  ) async {
    ApiResponse<String> token;
    QueryResult<Mutation$AuthorizeWithNewDeviceApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final input = Input$UseNewDeviceKeyInput(
        deviceName: deviceToken.device,
        key: deviceToken.token,
      );

      final variables = Variables$Mutation$AuthorizeWithNewDeviceApiKey(
        input: input,
      );
      final mutation = Options$Mutation$AuthorizeWithNewDeviceApiKey(
        variables: variables,
      );
      response = await client.mutate$AuthorizeWithNewDeviceApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
        token = ApiResponse<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = ApiResponse<String>(
        success: true,
        data: response.parsedData!.authorizeWithNewDeviceApiKey.token!,
      );
    } catch (e) {
      print(e);
      token = ApiResponse<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  Future<ApiResponse<String>> useRecoveryToken(
    final DeviceToken deviceToken,
  ) async {
    ApiResponse<String> token;
    QueryResult<Mutation$UseRecoveryApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final input = Input$UseRecoveryKeyInput(
        deviceName: deviceToken.device,
        key: deviceToken.token,
      );

      final variables = Variables$Mutation$UseRecoveryApiKey(
        input: input,
      );
      final mutation = Options$Mutation$UseRecoveryApiKey(
        variables: variables,
      );
      response = await client.mutate$UseRecoveryApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
        token = ApiResponse<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = ApiResponse<String>(
        success: true,
        data: response.parsedData!.useRecoveryApiKey.token!,
      );
    } catch (e) {
      print(e);
      token = ApiResponse<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  /// TODO: backups're not implemented on server side

  Future<BackupStatus> getBackupStatus() async => BackupStatus(
        progress: 0.0,
        status: BackupStatusEnum.error,
        errorMessage: null,
      );

  Future<List<Backup>> getBackups() async => [];

  Future<void> uploadBackblazeConfig(final BackblazeBucket bucket) async {}

  Future<void> forceBackupListReload() async {}

  Future<void> startBackup() async {}

  Future<void> restoreBackup(final String backupId) async {}
}
