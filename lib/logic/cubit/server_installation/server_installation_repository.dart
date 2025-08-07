import 'dart:async';
import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/network_utils.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class IpNotFoundException implements Exception {
  IpNotFoundException(this.message);
  final String message;
}

class ServerAuthorizationException implements Exception {
  ServerAuthorizationException(this.message);
  final String message;
}

class ServerInstallationRepository {
  Box box = Hive.box(BNames.serverInstallationBox);

  static final logger =
      const AppLogger(name: 'server_installation_repository').log;

  Future<ServerInstallationState> load() async {
    final ServerInstallationWizardData? wizardData =
        getIt<WizardDataModel>().serverInstallation;
    final List<Server> servers = getIt<ResourcesModel>().servers;
    final String? providerApiToken = getIt<ResourcesModel>().serverProviderKey;
    final String? location = getIt<ResourcesModel>().serverLocation;
    final String? dnsApiToken = getIt<ResourcesModel>().dnsProviderKey;
    final String? serverTypeIdentificator = getIt<ResourcesModel>().serverType;
    final ServerDomain? serverDomain = getIt<ResourcesModel>().serverDomain;
    final DnsProviderType? dnsProvider = getIt<ResourcesModel>().dnsProvider;
    final ServerProviderType? serverProvider =
        getIt<ResourcesModel>().serverProvider;
    final BackupsCredential? backblazeCredential =
        getIt<ResourcesModel>().backblazeCredential;
    final ServerHostingDetails? serverDetails =
        getIt<ResourcesModel>().serverDetails;

    // TODO(inex): Init server providers in another place
    if (serverProvider != null ||
        (serverDetails != null &&
            serverDetails.provider != ServerProviderType.unknown)) {
      ProvidersController.initServerProvider(
        ServerProviderSettings(
          provider: serverProvider ?? serverDetails!.provider,
          isAuthorized: providerApiToken != null,
          token: providerApiToken,
        ),
      );
    }

    if (dnsProvider != null ||
        (serverDomain != null &&
            serverDomain.provider != DnsProviderType.unknown)) {
      ProvidersController.initDnsProvider(
        DnsProviderSettings(
          isAuthorized: dnsApiToken != null,
          provider: dnsProvider ?? serverDomain!.provider,
          token: dnsApiToken,
        ),
      );
    }

    // If we don't have any wizard data, we either have a server set up, or we are starting from scratch
    // This behaviour shall change when we introduce multitenancy
    if (wizardData == null) {
      if (servers.isEmpty) {
        // We don't have anything set up, so we start from scratch
        return ServerInstallationNotFinished.fromWizardData(
          ServerInstallationWizardData.empty(),
        );
      } else {
        // We have a server set up, so we load it
        TlsOptions.verifyCertificate = true;
        return ServerInstallationFinished(
          providerApiToken: providerApiToken,
          serverTypeIdentificator: serverTypeIdentificator,
          dnsApiToken: dnsApiToken!,
          serverDomain: serverDomain!,
          backblazeCredential: backblazeCredential!,
          serverDetails: serverDetails!,
          serverLocation: location,
        );
      }
    }

    // If wizard data has info on the providers, init them
    if (wizardData.serverProviderType != null &&
        wizardData.serverProviderType != ServerProviderType.unknown) {
      ProvidersController.initServerProvider(
        ServerProviderSettings(
          provider: wizardData.serverProviderType!,
          isAuthorized: wizardData.serverProviderKey != null,
          token: wizardData.serverProviderKey,
        ),
      );
    }

    if (wizardData.dnsProviderType != null &&
        wizardData.dnsProviderType != DnsProviderType.unknown) {
      ProvidersController.initDnsProvider(
        DnsProviderSettings(
          provider: wizardData.dnsProviderType!,
          isAuthorized: wizardData.dnsProviderKey != null,
          token: wizardData.dnsProviderKey,
        ),
      );
    }

    if (wizardData.isRecoveringServer && wizardData.serverDomain != null) {
      return ServerInstallationRecovery(
        providerApiToken: wizardData.serverProviderKey,
        dnsApiToken: wizardData.dnsProviderKey,
        serverDomain: wizardData.serverDomain,
        serverTypeIdentificator: wizardData.serverTypeIdentifier,
        serverLocation: wizardData.serverLocation,
        backblazeCredential: wizardData.backupsCredential,
        serverDetails: wizardData.serverDetails,
        currentStep: _getCurrentRecoveryStep(
          wizardData.serverProviderKey,
          wizardData.dnsProviderKey,
          wizardData.serverDomain!,
          wizardData.serverDetails,
        ),
        recoveryCapabilities: await getRecoveryCapabilities(
          wizardData.serverDomain!,
        ),
      );
    }

    return ServerInstallationNotFinished.fromWizardData(wizardData);
  }

  RecoveryStep _getCurrentRecoveryStep(
    final String? serverProviderToken,
    final String? dnsProviderToken,
    final ServerDomain serverDomain,
    final ServerHostingDetails? serverDetails,
  ) {
    if (serverDetails == null) {
      return RecoveryStep.selecting;
    }

    if (serverProviderToken == null) {
      return RecoveryStep.serverProviderToken;
    }

    if (serverDetails.serverLocation == null) {
      return RecoveryStep.serverSelection;
    }

    if (dnsProviderToken == null) {
      return RecoveryStep.dnsProviderToken;
    }

    return RecoveryStep.backblazeToken;
  }

  Future<void> clearAppConfig() async {
    await box.clear();
    await getIt<ResourcesModel>().clear();
    await getIt<WizardDataModel>().clear();
    await getIt<ApiConnectionRepository>().clear();
  }

  Future<ServerHostingDetails> startServer(
    final ServerHostingDetails server,
  ) async {
    final result = await ProvidersController.currentServerProvider!.powerOn(
      server.id,
    );

    if (result.success && result.data != null) {
      server.copyWith(startTime: result.data);
    }

    return server;
  }

  Future<GenericResult<bool>> validateDnsToken(
    final String token,
    final String domain,
  ) async {
    final result = await ProvidersController.currentDnsProvider!
        .tryInitApiByToken(token);
    if (!result.success) {
      return result;
    }
    await setDnsApiToken(token);
    final domainResult =
        await ProvidersController.currentDnsProvider!.domainList();
    if (!domainResult.success || domainResult.data.isEmpty) {
      return GenericResult(
        success: false,
        data: false,
        message: domainResult.message,
      );
    }
    await getIt<ResourcesModel>().removeDnsProviderToken(
      getIt<ResourcesModel>().dnsProviderCredentials.first,
    );

    return GenericResult(
      success: true,
      data: domainResult.data.any(
        (final serverDomain) => serverDomain.domainName == domain,
      ),
    );
  }

  Future<void> createDkimRecord(final ServerDomain domain) async {
    final ServerApi api = ServerApi(
      overrideDomain: domain.domainName,
      customToken:
          getIt<WizardDataModel>().serverInstallation!.serverDetails!.apiToken,
      isWithToken: true,
    );

    late DnsRecord record;
    try {
      record = extractDkimRecord(await api.getDnsRecords())!;
    } catch (e) {
      logger('Failed to extract DKIM record: $e');
      rethrow;
    }

    await ProvidersController.currentDnsProvider!.setDnsRecord(record, domain);
  }

  Future<bool> isHttpServerWorking() {
    final ServerApi api = ServerApi(
      overrideDomain:
          getIt<WizardDataModel>().serverInstallation!.serverDomain!.domainName,
      customToken:
          getIt<WizardDataModel>().serverInstallation!.serverDetails!.apiToken,
      isWithToken: true,
    );
    return api.isHttpServerWorking();
  }

  Future<ServerHostingDetails> restart() async {
    final server = getIt<WizardDataModel>().serverInstallation!.serverDetails!;

    final result =
        await ServerApi(
          overrideDomain:
              getIt<WizardDataModel>()
                  .serverInstallation!
                  .serverDomain!
                  .domainName,
          customToken:
              getIt<WizardDataModel>()
                  .serverInstallation!
                  .serverDetails!
                  .apiToken,
          isWithToken: true,
        ).reboot();

    if (result.success && result.data != null) {
      server.copyWith(startTime: result.data);
    } else {
      // getIt<NavigationService>().showSnackBar('jobs.reboot_failed'.tr());
    }

    return server;
  }

  Future<ServerHostingDetails> powerOn() {
    final server = getIt<ResourcesModel>().serverDetails!;
    return startServer(server);
  }

  Future<ServerRecoveryCapabilities> getRecoveryCapabilities(
    final ServerDomain serverDomain,
  ) async {
    final ServerApi serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final String? serverApiVersion = await serverApi.getApiVersion();
    if (serverApiVersion == null) {
      return ServerRecoveryCapabilities.none;
    }
    try {
      final Version parsedVersion = Version.parse(serverApiVersion);
      if (!VersionConstraint.parse('>=1.2.0').allows(parsedVersion)) {
        return ServerRecoveryCapabilities.legacy;
      }
      return ServerRecoveryCapabilities.loginTokens;
    } on FormatException {
      return ServerRecoveryCapabilities.none;
    }
  }

  Future<String> getServerIpFromDomain(final ServerDomain serverDomain) async {
    String? domain;
    await InternetAddress.lookup(serverDomain.domainName).then((final records) {
      for (final record in records) {
        domain = record.address;
      }
    });
    if (domain == null || domain!.isEmpty) {
      throw IpNotFoundException('No IP found for domain $serverDomain');
    }
    return domain!;
  }

  Future<ServerHostingDetails> authorizeByNewDeviceKey(
    final ServerDomain serverDomain,
    final String newDeviceKey,
    final ServerRecoveryCapabilities recoveryCapabilities,
  ) async {
    final ServerApi serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final String serverIp = await getServerIpFromDomain(serverDomain);
    final GenericResult<String> result = await serverApi.authorizeDevice(
      DeviceToken(
        device: await PlatformAdapter.deviceName,
        token: newDeviceKey,
      ),
    );

    if (result.success) {
      return ServerHostingDetails(
        apiToken: result.data,
        volume: ServerProviderVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProviderType.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(result.message ?? result.data);
  }

  Future<ServerHostingDetails> authorizeByRecoveryKey(
    final ServerDomain serverDomain,
    final String recoveryKey,
    final ServerRecoveryCapabilities recoveryCapabilities,
  ) async {
    final ServerApi serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final String serverIp = await getServerIpFromDomain(serverDomain);
    final GenericResult<String> result = await serverApi.useRecoveryToken(
      DeviceToken(device: await PlatformAdapter.deviceName, token: recoveryKey),
    );

    if (result.success) {
      return ServerHostingDetails(
        apiToken: result.data,
        volume: ServerProviderVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProviderType.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(result.message ?? result.data);
  }

  Future<ServerHostingDetails> authorizeByApiToken(
    final ServerDomain serverDomain,
    final String apiToken,
    final ServerRecoveryCapabilities recoveryCapabilities,
  ) async {
    final ServerApi serverApi = ServerApi(
      isWithToken: true,
      overrideDomain: serverDomain.domainName,
      customToken: apiToken,
    );
    final String serverIp = await getServerIpFromDomain(serverDomain);
    if (recoveryCapabilities == ServerRecoveryCapabilities.legacy) {
      if (await serverApi.isHttpServerWorking()) {
        return ServerHostingDetails(
          apiToken: apiToken,
          volume: ServerProviderVolume(
            id: 0,
            name: '',
            serverId: 0,
            sizeByte: 0,
            linuxDevice: '',
          ),
          provider: ServerProviderType.unknown,
          id: 0,
          ip4: serverIp,
          startTime: null,
          createTime: null,
        );
      } else {
        throw ServerAuthorizationException(
          "Couldn't connect to server with this token",
        );
      }
    }
    final GenericResult<String> deviceAuthKey =
        await serverApi.createDeviceToken();
    final GenericResult<String> result = await serverApi.authorizeDevice(
      DeviceToken(
        device: await PlatformAdapter.deviceName,
        token: deviceAuthKey.data,
      ),
    );

    if (result.success) {
      return ServerHostingDetails(
        apiToken: result.data,
        volume: ServerProviderVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProviderType.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(result.message ?? result.data);
  }

  Future<List<ServerBasicInfo>> getServersOnProviderAccount() async =>
      (await ProvidersController.currentServerProvider!.getServers()).data;

  Future<void> saveServerDetails(
    final ServerHostingDetails serverDetails,
  ) async {
    await getIt<WizardDataModel>().setServerDetails(serverDetails);
  }

  Future<void> deleteServerDetails() async {
    await getIt<WizardDataModel>().deleteServerDetails();
  }

  Future<void> saveServerProviderType(final ServerProviderType type) async {
    await getIt<WizardDataModel>().setServerProviderType(type);
  }

  Future<void> saveDnsProviderType(final DnsProviderType type) async {
    await getIt<WizardDataModel>().setDnsProviderType(type);
  }

  Future<void> saveServerProviderKey(final String key) async {
    await getIt<WizardDataModel>().setServerProviderKey(key);
    await getIt<ResourcesModel>().addServerProviderToken(
      ServerProviderCredential(
        tokenId: null,
        token: key,
        provider:
            getIt<WizardDataModel>().serverInstallation!.serverProviderType!,
        associatedServerIds: [],
      ),
    );
    ProvidersController.initServerProvider(
      ServerProviderSettings(
        provider:
            getIt<WizardDataModel>().serverInstallation!.serverProviderType!,
        token: key,
        isAuthorized: true,
      ),
    );
  }

  Future<void> saveServerType(final ServerType serverType) async {
    await getIt<WizardDataModel>().setServerTypeIdentifier(
      serverType.identifier,
    );
    await getIt<WizardDataModel>().setServerLocation(
      serverType.location.identifier,
    );
  }

  Future<void> saveBackupsCredential(
    final BackupsCredential backupsCredential,
  ) async {
    await getIt<WizardDataModel>().setBackupsCredential(backupsCredential);
  }

  Future<void> setDnsApiToken(final String key) async {
    await getIt<WizardDataModel>().setDnsProviderKey(key);
    await getIt<ResourcesModel>().addDnsProviderToken(
      DnsProviderCredential(
        tokenId: null,
        token: key,
        provider: getIt<WizardDataModel>().serverInstallation!.dnsProviderType!,
        associatedDomainNames: [],
      ),
    );
    ProvidersController.initDnsProvider(
      DnsProviderSettings(
        provider: getIt<WizardDataModel>().serverInstallation!.dnsProviderType!,
        token: key,
        isAuthorized: true,
      ),
    );
  }

  Future<void> saveDomain(final ServerDomain serverDomain) async {
    await getIt<WizardDataModel>().setServerDomain(serverDomain);
  }

  Future<void> deleteDomain() async {
    await getIt<WizardDataModel>().deleteServerDomain();
  }

  Future<void> saveIsServerStarted({required final bool serverStarted}) async {
    await getIt<WizardDataModel>().setIsServerStarted(isStarted: serverStarted);
  }

  Future<void> saveIsServerRebootedFirstTime({
    required final bool serverRebootedFirstTime,
  }) async {
    await getIt<WizardDataModel>().setIsServerRebootedFirstTime(
      isRebooted: serverRebootedFirstTime,
    );
  }

  Future<void> saveIsServerRebootedSecondTime({
    required final bool serverRebootedSecondTime,
  }) async {
    await getIt<WizardDataModel>().setIsServerRebootedSecondTime(
      isRebooted: serverRebootedSecondTime,
    );
  }

  Future<void> saveRootUser(final User rootUser) async {
    await getIt<WizardDataModel>().setRootUser(rootUser);
  }

  Future<void> saveIsRecoveringServer({
    required final bool isRecoveringServer,
  }) async {
    await getIt<WizardDataModel>().setIsRecoveringServer(
      isRecovering: isRecoveringServer,
    );
  }

  Future<void> saveHasFinalChecked({
    required final bool finalCheckCompleted,
  }) async {
    // We are finished here. Time to save the state and finish the wizard
    // TODO(inex): A lot of null checks are skipped here. Implication that every value exists might become false in the future.
    // TODO(inex): We would actually want to handle token creation elsewhere.
    await getIt<WizardDataModel>().moveServerTypeToServerDetails();
    final ServerInstallationWizardData wizardData =
        getIt<WizardDataModel>().serverInstallation!;
    await getIt<ResourcesModel>().addServer(
      Server(
        hostingDetails: wizardData.serverDetails!,
        domain: wizardData.serverDomain!,
      ),
    );
    if (wizardData.serverProviderKey != null) {
      await getIt<ResourcesModel>().associateServerWithToken(
        wizardData.serverDetails!.id,
        wizardData.serverProviderKey!,
      );
    }
    if (wizardData.dnsProviderKey != null) {
      await getIt<ResourcesModel>().associateDomainWithToken(
        wizardData.serverDomain!.domainName,
        wizardData.dnsProviderKey!,
      );
    }
    if (wizardData.backupsCredential != null) {
      await getIt<ResourcesModel>().addBackupsCredential(
        wizardData.backupsCredential!,
      );
    }
    await getIt<WizardDataModel>().clearServerInstallation();
  }
}
