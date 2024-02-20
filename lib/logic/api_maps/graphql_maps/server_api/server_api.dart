import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
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

class ServerApi extends GraphQLApiMap
    with
        VolumeApi,
        JobsApi,
        ServerActionsApi,
        ServicesApi,
        UsersApi,
        BackupsApi {
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

  Future<ServerProviderType> getServerProviderType() async {
    QueryResult<Query$SystemServerProvider> response;
    ServerProviderType providerType = ServerProviderType.unknown;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$SystemServerProvider();
      if (response.hasException) {
        print(response.exception.toString());
      }
      providerType = ServerProviderType.fromGraphQL(
        response.parsedData!.system.provider.provider,
      );
    } catch (e) {
      print(e);
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
        print(response.exception.toString());
      }
      providerType = DnsProviderType.fromGraphQL(
        response.parsedData!.system.domainInfo.provider,
      );
    } catch (e) {
      print(e);
    }
    return providerType;
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
        success: result.parsedData?.system.changeAutoUpgradeSettings.success ??
            false,
        message: result.parsedData?.system.changeAutoUpgradeSettings.message,
        data: result.parsedData == null
            ? null
            : AutoUpgradeSettings(
                allowReboot: result
                    .parsedData!.system.changeAutoUpgradeSettings.allowReboot,
                enable: result.parsedData!.system.changeAutoUpgradeSettings
                    .enableAutoUpgrade,
              ),
      );
    } catch (e) {
      print(e);
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
      final variables = Variables$Mutation$ChangeTimezone(
        timezone: timezone,
      );
      final mutation = Options$Mutation$ChangeTimezone(
        variables: variables,
      );
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
      print(e);
      return GenericResult<String?>(
        success: false,
        message: e.toString(),
        data: '',
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

  Future<GenericResult<RecoveryKeyStatus?>> getRecoveryTokenStatus() async {
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
      print(e);
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
        print(response.exception.toString());
      }
      records = response.parsedData!.system.domainInfo.requiredDnsRecords
          .map<DnsRecord>(
            (
              final Fragment$fragmentDnsRecords record,
            ) =>
                DnsRecord.fromGraphQL(record),
          )
          .toList();
    } catch (e) {
      print(e);
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
        print(message);
        tokens = GenericResult<List<ApiToken>>(
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
      tokens = GenericResult<List<ApiToken>>(
        success: true,
        data: parsed,
      );
    } catch (e) {
      print(e);
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
        returnable = GenericResult<void>(
          success: false,
          data: null,
          message: response.exception.toString(),
        );
      }
      returnable = GenericResult<void>(
        success: true,
        data: null,
      );
    } catch (e) {
      print(e);
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
      response = await client.mutate$GetNewDeviceApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
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
      print(e);
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
      response = await client.mutate$AuthorizeWithNewDeviceApiKey(
        mutation,
      );
      if (response.hasException) {
        print(response.exception.toString());
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
      print(e);
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
      print(e);
      token = GenericResult<String>(
        success: false,
        data: '',
        message: e.toString(),
      );
    }

    return token;
  }
}
