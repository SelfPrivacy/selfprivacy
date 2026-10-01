import 'dart:async';

import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/logs.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/monitoring.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/users.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/decode_server_mutation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/require_server_api_data.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
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

enum ServerProbeResult { unreachable, untrustedCertificate, reachable }

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
  ServerApi({required final GraphQLTransport transport}) : super(transport);

  bool get isWithToken => transport.isAuthenticated;
  String get apiToken => transport.token;
  String? get rootAddress => transport.domain;

  Future<String?> getApiVersion() => _getApiVersion();

  Future<String> fetchApiVersion() => _fetchApiVersion();

  Future<String> _fetchApiVersion({
    final GraphQLTransport? clientTransport,
  }) async {
    final client = clientTransport?.client() ?? await getClient();
    return requireServerApiData(
      await client.query$GetApiVersion(
        Options$Query$GetApiVersion(
          context: const Context().withEntry(const PublicGraphQLRequest()),
        ),
      ),
    ).api.version;
  }

  Future<String?> _getApiVersion({
    final GraphQLTransport? clientTransport,
  }) async {
    try {
      return await _fetchApiVersion(clientTransport: clientTransport);
    } catch (e) {
      logger('Error in GraphQL GetApiVersion request: $e', error: e);
      return null;
    }
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

  Future<ServerMutationResult<void>> switchService({
    required final String serviceId,
    required final bool needTurnOn,
  }) => needTurnOn ? enableService(serviceId) : disableService(serviceId);

  Future<ServerMutationResult<AutoUpgradeSettings>> setAutoUpgradeSettings(
    final AutoUpgradeSettings settings,
  ) async {
    final client = await getClient();
    final response = await client.mutate$ChangeAutoUpgradeSettings(
      Options$Mutation$ChangeAutoUpgradeSettings(
        variables: Variables$Mutation$ChangeAutoUpgradeSettings(
          settings: Input$AutoUpgradeSettingsInput(
            allowReboot: settings.allowReboot,
            enableAutoUpgrade: settings.enable,
          ),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.system.changeAutoUpgradeSettings,
      decodePayload: (final mutation) => AutoUpgradeSettings(
        allowReboot: mutation.allowReboot,
        enable: mutation.enableAutoUpgrade,
      ),
    );
  }

  Future<ServerMutationResult<String>> setTimezone(
    final String timezone,
  ) async {
    final client = await getClient();
    final response = await client.mutate$ChangeTimezone(
      Options$Mutation$ChangeTimezone(
        variables: Variables$Mutation$ChangeTimezone(timezone: timezone),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.system.changeTimezone,
      decodePayload: (final mutation) => mutation.timezone,
    );
  }

  Future<ServerMutationResult<SshSettings>> setSshSettings(
    final SshSettings settings,
  ) async {
    final client = await getClient();
    final response = await client.mutate$ChangeSshSettings(
      Options$Mutation$ChangeSshSettings(
        variables: Variables$Mutation$ChangeSshSettings(
          settings: Input$SSHSettingsInput(enable: settings.enable),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.system.changeSshSettings,
      decodePayload: (final mutation) => SshSettings(enable: mutation.enable),
    );
  }

  Future<SystemSettings> getSystemSettings() async {
    final client = await getClient();
    return SystemSettings.fromGraphQL(
      requireServerApiData(await client.query$SystemSettings()).system,
    );
  }

  Future<RecoveryKeyStatus> getRecoveryTokenStatus() async {
    final client = await getClient();
    return RecoveryKeyStatus.fromGraphQL(
      requireServerApiData(await client.query$RecoveryKey()).api.recoveryKey,
    );
  }

  Future<ServerMutationResult<String>> generateRecoveryToken(
    final DateTime? expirationDate,
    final int? numberOfUses,
  ) async {
    final client = await getClient();
    final response = await client.mutate$GetNewRecoveryApiKey(
      Options$Mutation$GetNewRecoveryApiKey(
        variables: Variables$Mutation$GetNewRecoveryApiKey(
          limits: Input$RecoveryKeyLimitsInput(
            expirationDate: expirationDate?.toUtc(),
            uses: numberOfUses,
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.getNewRecoveryApiKey,
      decodePayload: (final mutation) => nonEmptySecret(mutation.key),
    );
  }

  Future<List<DnsRecord>?> getDnsRecords() async {
    List<DnsRecord>? records;
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
      records = response.parsedData!.system.domainInfo.requiredDnsRecords
          .map<DnsRecord>(DnsRecord.fromGraphQL)
          .toList();
    } catch (e) {
      logger('Error in GraphQL GetDnsRecords request: $e', error: e);
    }

    return records;
  }

  Future<List<ApiToken>> getApiTokens() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$GetApiTokens(),
    ).api.devices.map(ApiToken.fromGraphQL).toList();
  }

  Future<ServerMutationResult<void>> deleteApiToken(final String name) async {
    final client = await getClient();
    final response = await client.mutate$DeleteDeviceApiToken(
      Options$Mutation$DeleteDeviceApiToken(
        variables: Variables$Mutation$DeleteDeviceApiToken(device: name),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.deleteDeviceApiToken,
    );
  }

  Future<ServerMutationResult<String>> createDeviceToken() async {
    final client = await getClient();
    final response = await client.mutate$GetNewDeviceApiKey(
      Options$Mutation$GetNewDeviceApiKey(
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.getNewDeviceApiKey,
      decodePayload: (final mutation) => nonEmptySecret(mutation.key),
    );
  }

  Future<ServerMutationResult<String>> refreshDeviceApiToken() async {
    final client = await getClient();
    final response = await client.mutate$RefreshDeviceApiToken(
      Options$Mutation$RefreshDeviceApiToken(
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.refreshDeviceApiToken,
      decodePayload: (final mutation) => nonEmptySecret(mutation.token),
    );
  }

  Future<bool> isHttpServerWorking() async => (await getApiVersion()) != null;

  Future<ServerProbeResult> probe() async {
    if (isWithToken) {
      throw StateError('the readiness probe must not carry a token');
    }

    if (await _getApiVersion() != null) {
      return ServerProbeResult.reachable;
    }
    if (await _getApiVersion(
          clientTransport: transport.withTlsPolicy(TlsPolicy.allowUnverified),
        ) !=
        null) {
      return ServerProbeResult.untrustedCertificate;
    }
    return ServerProbeResult.unreachable;
  }

  Future<ServerMutationResult<String>> authorizeDevice(
    final DeviceToken deviceToken,
  ) async {
    final client = await getClient();
    final response = await client.mutate$AuthorizeWithNewDeviceApiKey(
      Options$Mutation$AuthorizeWithNewDeviceApiKey(
        variables: Variables$Mutation$AuthorizeWithNewDeviceApiKey(
          input: Input$UseNewDeviceKeyInput(
            deviceName: deviceToken.device,
            key: deviceToken.token,
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.authorizeWithNewDeviceApiKey,
      decodePayload: (final mutation) => nonEmptySecret(mutation.token),
    );
  }

  Future<ServerMutationResult<String>> useRecoveryToken(
    final DeviceToken deviceToken,
  ) async {
    final client = await getClient();
    final response = await client.mutate$UseRecoveryApiKey(
      Options$Mutation$UseRecoveryApiKey(
        variables: Variables$Mutation$UseRecoveryApiKey(
          input: Input$UseRecoveryKeyInput(
            deviceName: deviceToken.device,
            key: deviceToken.token,
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.api.useRecoveryApiKey,
      decodePayload: (final mutation) => nonEmptySecret(mutation.token),
    );
  }
}
