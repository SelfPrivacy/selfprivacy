import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/logs.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/monitoring.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

export 'package:selfprivacy/logic/api_maps/generic_result.dart';

part 'backups_api.dart';
part 'jobs_api.dart';
part 'server_actions_api.dart';
part 'services_api.dart';
part 'users_api.dart';
part 'volume_api.dart';
part 'logs_api.dart';
part 'monitoring_api.dart';

class ServerApi extends GraphQLApiMap
    with
        VolumeApi,
        JobsApi,
        ServerActionsApi,
        ServicesApi,
        UsersApi,
        BackupsApi,
        LogsApi,
        MonitoringApi {
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
      overrideDomain ?? getIt<ResourcesModel>().serverDomain?.domainName;
  String? overrideDomain;

  Future<String?> getApiVersion() async {
    QueryResult<Query$GetApiVersion> response;
    String? apiVersion;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiVersion();
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetApiVersion request: ${response.exception}',
          error: response.exception,
        );
      }
      apiVersion = response.parsedData?.api.version;
    } catch (e) {
      logger('Error in GraphQL GetApiVersion request: $e', error: e);
    }
    return apiVersion;
  }

  Future<ServerProviderType> getServerProviderType() async {
    QueryResult<Query$SystemServerProvider> response;
    ServerProviderType providerType = ServerProviderType.unknown;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemServerProvider();
      if (response.hasException) {
        logger(
          'Exception in GraphQL SystemServerProvider request: ${response.exception}',
          error: response.exception,
        );
      }
      providerType = ServerProviderType.fromGraphQL(
        response.parsedData!.system.provider.provider,
      );
    } catch (e) {
      logger('Error in GraphQL SystemServerProvider request: $e', error: e);
    }
    return providerType;
  }

  Future<DnsProviderType> getDnsProviderType() async {
    QueryResult<Query$SystemDnsProvider> response;
    DnsProviderType providerType = DnsProviderType.unknown;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemDnsProvider();
      if (response.hasException) {
        logger(
          'Exception in GraphQL SystemDnsProvider request: ${response.exception}',
          error: response.exception,
        );
      }
      providerType = DnsProviderType.fromGraphQL(
        response.parsedData!.system.domainInfo.provider,
      );
    } catch (e) {
      logger('Error in GraphQL SystemDnsProvider request: $e', error: e);
    }
    return providerType;
  }

  Future<bool> isUsingBinds() async {
    QueryResult<Query$SystemIsUsingBinds> response;
    bool usesBinds = false;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemIsUsingBinds();
      if (response.hasException) {
        logger(
          'Exception in GraphQL SystemIsUsingBinds request: ${response.exception}',
          error: response.exception,
        );
      }
      usesBinds = response.parsedData!.system.info.usingBinds;
    } catch (e) {
      logger('Error in GraphQL SystemIsUsingBinds request: $e', error: e);
    }
    return usesBinds;
  }

  Future<GenericResult> switchService({
    required final String serviceId,
    required final bool needTurnOn,
  }) async {
    try {
      final GraphQLClient client = await getClient();
      if (needTurnOn) {
        final variables = Variables$Mutation$EnableService(
          serviceId: serviceId,
        );
        final mutation = Options$Mutation$EnableService(variables: variables);
        final result = await client.mutate$EnableService(mutation);
        if (result.hasException) {
          return GenericResult(
            success: false,
            message: result.exception.toString(),
            data: null,
          );
        }
        return GenericResult(
          success: result.parsedData?.services.enableService.success ?? false,
          message: result.parsedData?.services.enableService.message,
          data: null,
        );
      } else {
        final variables = Variables$Mutation$DisableService(
          serviceId: serviceId,
        );
        final mutation = Options$Mutation$DisableService(variables: variables);
        final result = await client.mutate$DisableService(mutation);
        if (result.hasException) {
          return GenericResult(
            success: false,
            message: result.exception.toString(),
            data: null,
          );
        }
        return GenericResult(
          success: result.parsedData?.services.disableService.success ?? false,
          message: result.parsedData?.services.disableService.message,
          data: null,
        );
      }
    } catch (e) {
      return GenericResult(success: false, message: e.toString(), data: null);
    }
  }

  Future<GenericResult<AutoUpgradeSettings?>> setAutoUpgradeSettings(
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
      final result = await client.mutate$ChangeAutoUpgradeSettings(mutation);
      if (result.hasException) {
        return GenericResult<AutoUpgradeSettings?>(
          success: false,
          message: result.exception.toString(),
          data: null,
        );
      }
      return GenericResult<AutoUpgradeSettings?>(
        success:
            result.parsedData?.system.changeAutoUpgradeSettings.success ??
            false,
        message: result.parsedData?.system.changeAutoUpgradeSettings.message,
        data:
            result.parsedData == null
                ? null
                : AutoUpgradeSettings(
                  allowReboot:
                      result
                          .parsedData!
                          .system
                          .changeAutoUpgradeSettings
                          .allowReboot,
                  enable:
                      result
                          .parsedData!
                          .system
                          .changeAutoUpgradeSettings
                          .enableAutoUpgrade,
                ),
      );
    } catch (e) {
      logger('Error setting auto upgrade settings: $e', error: e);
      return GenericResult<AutoUpgradeSettings?>(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<GenericResult<String?>> setTimezone(final String timezone) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$ChangeTimezone(timezone: timezone);
      final mutation = Options$Mutation$ChangeTimezone(variables: variables);
      final result = await client.mutate$ChangeTimezone(mutation);
      if (result.hasException) {
        return GenericResult<String>(
          success: false,
          message: result.exception.toString(),
          data: '',
        );
      }
      return GenericResult<String?>(
        success: result.parsedData?.system.changeTimezone.success ?? false,
        message: result.parsedData?.system.changeTimezone.message,
        data: result.parsedData?.system.changeTimezone.timezone,
      );
    } catch (e) {
      logger('Error setting timezone: $e', error: e);
      return GenericResult<String?>(
        success: false,
        message: e.toString(),
        data: '',
      );
    }
  }

  Future<GenericResult<SshSettings?>> setSshSettings(
    final SshSettings settings,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final input = Input$SSHSettingsInput(enable: settings.enable);
      final variables = Variables$Mutation$ChangeSshSettings(settings: input);
      final mutation = Options$Mutation$ChangeSshSettings(variables: variables);
      final result = await client.mutate$ChangeSshSettings(mutation);
      if (result.hasException) {
        return GenericResult<SshSettings?>(
          success: false,
          message: result.exception.toString(),
          data: null,
        );
      }
      return GenericResult<SshSettings?>(
        success: result.parsedData?.system.changeSshSettings.success ?? false,
        message: result.parsedData?.system.changeSshSettings.message,
        data:
            result.parsedData == null
                ? null
                : SshSettings(
                  enable: result.parsedData!.system.changeSshSettings.enable,
                ),
      );
    } catch (e) {
      logger('Error setting SSH settings: $e', error: e);
      return GenericResult<SshSettings?>(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<SystemSettings> getSystemSettings() async {
    QueryResult<Query$SystemSettings> response;
    SystemSettings settings = SystemSettings(
      autoUpgradeSettings: AutoUpgradeSettings(
        allowReboot: false,
        enable: false,
      ),
      sshSettings: SshSettings(enable: false),
      timezone: 'Unknown',
    );

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemSettings();
      if (response.hasException) {
        logger(
          'Exception in GraphQL SystemSettings request: ${response.exception}',
          error: response.exception,
        );
      }
      settings = SystemSettings.fromGraphQL(response.parsedData!.system);
    } catch (e) {
      logger('Error in GraphQL SystemSettings request: $e', error: e);
    }

    return settings;
  }

  Future<GenericResult<RecoveryKeyStatus?>> getRecoveryTokenStatus() async {
    RecoveryKeyStatus? key;
    QueryResult<Query$RecoveryKey> response;
    String? error;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$RecoveryKey();
      if (response.hasException) {
        logger(
          'Exception in GraphQL RecoveryKey request: ${response.exception}',
          error: response.exception,
        );
        error = response.exception.toString();
      }
      key = RecoveryKeyStatus.fromGraphQL(response.parsedData!.api.recoveryKey);
    } catch (e) {
      logger('Error in GraphQL RecoveryKey request: $e', error: e);
    }

    return GenericResult<RecoveryKeyStatus?>(
      success: error == null,
      data: key,
      message: error,
    );
  }

  Future<GenericResult<String>> generateRecoveryToken(
    final DateTime? expirationDate,
    final int? numberOfUses,
  ) async {
    GenericResult<String> key;
    QueryResult<Mutation$GetNewRecoveryApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final input = Input$RecoveryKeyLimitsInput(
        expirationDate: expirationDate?.toUtc(),
        uses: numberOfUses,
      );
      final variables = Variables$Mutation$GetNewRecoveryApiKey(limits: input);
      final mutation = Options$Mutation$GetNewRecoveryApiKey(
        variables: variables,
      );
      response = await client.mutate$GetNewRecoveryApiKey(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetNewRecoveryApiKey request: ${response.exception}',
          error: response.exception,
        );
        key = GenericResult<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      key = GenericResult<String>(
        success: true,
        data: response.parsedData!.api.getNewRecoveryApiKey.key!,
      );
    } catch (e) {
      logger('Error in GraphQL GetNewRecoveryApiKey request: $e', error: e);
      key = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return key;
  }

  Future<List<DnsRecord>> getDnsRecords() async {
    List<DnsRecord> records = [];
    QueryResult<Query$GetDnsRecords> response;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetDnsRecords();
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetDnsRecords request: ${response.exception}',
          error: response.exception,
        );
      }
      records =
          response.parsedData!.system.domainInfo.requiredDnsRecords
              .map<DnsRecord>(DnsRecord.fromGraphQL)
              .toList();
    } catch (e) {
      logger('Error in GraphQL GetDnsRecords request: $e', error: e);
    }

    return records;
  }

  Future<GenericResult<List<ApiToken>>> getApiTokens() async {
    GenericResult<List<ApiToken>> tokens;
    QueryResult<Query$GetApiTokens> response;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiTokens();
      if (response.hasException) {
        final message = response.exception.toString();
        logger(
          'Exception in GraphQL GetApiTokens request: $message',
          error: response.exception,
        );
        tokens = GenericResult<List<ApiToken>>(
          success: false,
          data: [],
          message: message,
        );
      }
      final List<ApiToken> parsed =
          response.parsedData!.api.devices.map(ApiToken.fromGraphQL).toList();
      tokens = GenericResult<List<ApiToken>>(success: true, data: parsed);
    } catch (e) {
      logger('Error in GraphQL GetApiTokens request: $e', error: e);
      tokens = GenericResult<List<ApiToken>>(
        success: false,
        data: [],
        message: e.toString(),
      );
    }

    return tokens;
  }

  Future<GenericResult<void>> deleteApiToken(final String name) async {
    GenericResult<void> returnable;
    QueryResult<Mutation$DeleteDeviceApiToken> response;

    try {
      final GraphQLClient client = await getClient();

      final variables = Variables$Mutation$DeleteDeviceApiToken(device: name);
      final mutation = Options$Mutation$DeleteDeviceApiToken(
        variables: variables,
      );
      response = await client.mutate$DeleteDeviceApiToken(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL DeleteDeviceApiToken request: ${response.exception}',
          error: response.exception,
        );
        returnable = GenericResult<void>(
          success: false,
          data: null,
          message: response.exception.toString(),
        );
      }
      returnable = GenericResult<void>(success: true, data: null);
    } catch (e) {
      logger('Error in GraphQL DeleteDeviceApiToken request: $e', error: e);
      returnable = GenericResult<void>(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return returnable;
  }

  Future<GenericResult<String>> createDeviceToken() async {
    GenericResult<String> token;
    QueryResult<Mutation$GetNewDeviceApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final mutation = Options$Mutation$GetNewDeviceApiKey();
      response = await client.mutate$GetNewDeviceApiKey(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetNewDeviceApiKey request: ${response.exception}',
          error: response.exception,
        );
        token = GenericResult<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = GenericResult<String>(
        success: true,
        data: response.parsedData!.api.getNewDeviceApiKey.key!,
      );
    } catch (e) {
      logger('Error in GraphQL GetNewDeviceApiKey request: $e', error: e);
      token = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  Future<GenericResult<String>> refreshDeviceApiToken() async {
    GenericResult<String> token;
    QueryResult<Mutation$RefreshDeviceApiToken> response;

    try {
      final GraphQLClient client = await getClient();

      final mutation = Options$Mutation$RefreshDeviceApiToken();
      response = await client.mutate$RefreshDeviceApiToken(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL RefreshDeviceApiToken request: ${response.exception}',
          error: response.exception,
        );
        token = GenericResult<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = GenericResult<String>(
        success: true,
        data: response.parsedData!.api.refreshDeviceApiToken.token!,
      );
    } catch (e) {
      logger('Error in GraphQL RefreshDeviceApiToken request: $e', error: e);
      token = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  Future<bool> isHttpServerWorking() async => (await getApiVersion()) != null;

  Future<GenericResult<String>> authorizeDevice(
    final DeviceToken deviceToken,
  ) async {
    GenericResult<String> token;
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
      response = await client.mutate$AuthorizeWithNewDeviceApiKey(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL AuthorizeWithNewDeviceApiKey request: ${response.exception}',
          error: response.exception,
        );
        token = GenericResult<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = GenericResult<String>(
        success: true,
        data: response.parsedData!.api.authorizeWithNewDeviceApiKey.token!,
      );
    } catch (e) {
      logger(
        'Error in GraphQL AuthorizeWithNewDeviceApiKey request: $e',
        error: e,
      );
      token = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }

  Future<GenericResult<String>> useRecoveryToken(
    final DeviceToken deviceToken,
  ) async {
    GenericResult<String> token;
    QueryResult<Mutation$UseRecoveryApiKey> response;

    try {
      final GraphQLClient client = await getClient();

      final input = Input$UseRecoveryKeyInput(
        deviceName: deviceToken.device,
        key: deviceToken.token,
      );

      final variables = Variables$Mutation$UseRecoveryApiKey(input: input);
      final mutation = Options$Mutation$UseRecoveryApiKey(variables: variables);
      response = await client.mutate$UseRecoveryApiKey(mutation);
      if (response.hasException) {
        logger(
          'Exception in GraphQL UseRecoveryApiKey request: ${response.exception}',
          error: response.exception,
        );
        token = GenericResult<String>(
          success: false,
          data: '',
          message: response.exception.toString(),
        );
      }
      token = GenericResult<String>(
        success: true,
        data: response.parsedData!.api.useRecoveryApiKey.token!,
      );
    } catch (e) {
      logger('Error in GraphQL UseRecoveryApiKey request: $e', error: e);
      token = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }
}
