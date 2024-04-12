import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
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

  Future<ServerInstallationState> load() async {
    final String? providerApiToken = getIt<ApiConfigModel>().serverProviderKey;
    final String? location = getIt<ApiConfigModel>().serverLocation;
    final String? dnsApiToken = getIt<ApiConfigModel>().dnsProviderKey;
    final String? serverTypeIdentificator = getIt<ApiConfigModel>().serverType;
    final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
    final DnsProviderType? dnsProvider = getIt<ApiConfigModel>().dnsProvider;
    final ServerProviderType? serverProvider =
        getIt<ApiConfigModel>().serverProvider;
    final BackupsCredential? backblazeCredential =
        getIt<ApiConfigModel>().backblazeCredential;
    final ServerHostingDetails? serverDetails =
        getIt<ApiConfigModel>().serverDetails;

    if (serverProvider != null ||
        (serverDetails != null &&
            serverDetails.provider != ServerProviderType.unknown)) {
      ProvidersController.initServerProvider(
        ServerProviderSettings(
          provider: serverProvider ?? serverDetails!.provider,
          isAuthorized: providerApiToken != null,
          location: location,
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
        ),
      );
    }

    if (box.get(BNames.hasFinalChecked, defaultValue: false)) {
      TlsOptions.verifyCertificate = true;
      if (serverTypeIdentificator == null && serverDetails != null) {
        final finalServerType = await ProvidersController.currentServerProvider!
            .getServerType(serverDetails.id);
        await saveServerType(finalServerType.data!);
        await ProvidersController.currentServerProvider!
            .trySetServerLocation(finalServerType.data!.location.identifier);
        return ServerInstallationFinished(
          installationDialoguePopUp: null,
          providerApiToken: providerApiToken!,
          serverTypeIdentificator: finalServerType.data!.identifier,
          dnsApiToken: dnsApiToken!,
          serverDomain: serverDomain!,
          backblazeCredential: backblazeCredential!,
          serverDetails: serverDetails,
          rootUser: box.get(BNames.rootUser),
          isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
          isServerResetedFirstTime:
              box.get(BNames.isServerResetedFirstTime, defaultValue: false),
          isServerResetedSecondTime:
              box.get(BNames.isServerResetedSecondTime, defaultValue: false),
        );
      } else {
        return ServerInstallationFinished(
          installationDialoguePopUp: null,
          providerApiToken: providerApiToken!,
          serverTypeIdentificator: serverTypeIdentificator!,
          dnsApiToken: dnsApiToken!,
          serverDomain: serverDomain!,
          backblazeCredential: backblazeCredential!,
          serverDetails: serverDetails!,
          rootUser: box.get(BNames.rootUser),
          isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
          isServerResetedFirstTime:
              box.get(BNames.isServerResetedFirstTime, defaultValue: false),
          isServerResetedSecondTime:
              box.get(BNames.isServerResetedSecondTime, defaultValue: false),
        );
      }
    }

    if (box.get(BNames.isRecoveringServer, defaultValue: false) &&
        serverDomain != null) {
      return ServerInstallationRecovery(
        providerApiToken: providerApiToken,
        dnsApiToken: dnsApiToken,
        serverDomain: serverDomain,
        serverTypeIdentificator: serverTypeIdentificator,
        backblazeCredential: backblazeCredential,
        serverDetails: serverDetails,
        rootUser: box.get(BNames.rootUser),
        currentStep: _getCurrentRecoveryStep(
          providerApiToken,
          dnsApiToken,
          serverDomain,
          serverDetails,
        ),
        recoveryCapabilities: await getRecoveryCapabilities(serverDomain),
      );
    }

    return ServerInstallationNotFinished(
      providerApiToken: providerApiToken,
      dnsApiToken: dnsApiToken,
      serverDomain: serverDomain,
      serverTypeIdentificator: serverTypeIdentificator,
      backblazeCredential: backblazeCredential,
      serverDetails: serverDetails,
      rootUser: box.get(BNames.rootUser),
      isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
      isServerResetedFirstTime:
          box.get(BNames.isServerResetedFirstTime, defaultValue: false),
      isServerResetedSecondTime:
          box.get(BNames.isServerResetedSecondTime, defaultValue: false),
      isLoading: box.get(BNames.isLoading, defaultValue: false),
      dnsMatches: null,
      customSshKey: null,
    );
  }

  RecoveryStep _getCurrentRecoveryStep(
    final String? serverProviderToken,
    final String? dnsProviderToken,
    final ServerDomain serverDomain,
    final ServerHostingDetails? serverDetails,
  ) {
    if (serverDetails != null) {
      if (serverProviderToken != null) {
        if (serverDetails.provider != ServerProviderType.unknown) {
          if (serverDomain.provider != DnsProviderType.unknown) {
            return RecoveryStep.backblazeToken;
          }
          return RecoveryStep.dnsProviderToken;
        }
        return RecoveryStep.serverSelection;
      }
      return RecoveryStep.serverProviderToken;
    }
    return RecoveryStep.selecting;
  }

  void clearAppConfig() {
    box.clear();
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

  Future<bool> validateDnsToken(
    final String token,
    final String domain,
  ) async {
    final result =
        await ProvidersController.currentDnsProvider!.tryInitApiByToken(token);
    if (!result.success) {
      return false;
    }
    await setDnsApiToken(token);
    final domainResult =
        await ProvidersController.currentDnsProvider!.domainList();
    if (!domainResult.success || domainResult.data.isEmpty) {
      return false;
    }

    return domainResult.data.any(
      (final serverDomain) => serverDomain.domainName == domain,
    );
  }

  Future<void> createDkimRecord(final ServerDomain domain) async {
    final ServerApi api = ServerApi();

    late DnsRecord record;
    try {
      record = extractDkimRecord(await api.getDnsRecords())!;
    } catch (e) {
      print(e);
      rethrow;
    }

    await ProvidersController.currentDnsProvider!.setDnsRecord(
      record,
      domain,
    );
  }

  Future<bool> isHttpServerWorking() async {
    final ServerApi api = ServerApi();
    return api.isHttpServerWorking();
  }

  Future<ServerHostingDetails> restart() async {
    final server = getIt<ApiConfigModel>().serverDetails!;

    final result = await ServerApi().reboot();

    if (result.success && result.data != null) {
      server.copyWith(startTime: result.data);
    } else {
      getIt<NavigationService>().showSnackBar('jobs.reboot_failed'.tr());
    }

    return server;
  }

  Future<ServerHostingDetails> powerOn() async {
    final server = getIt<ApiConfigModel>().serverDetails!;
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
    await InternetAddress.lookup(serverDomain.domainName).then(
      (final records) {
        for (final record in records) {
          domain = record.address;
        }
      },
    );
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

    throw ServerAuthorizationException(
      result.message ?? result.data,
    );
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

    throw ServerAuthorizationException(
      result.message ?? result.data,
    );
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

    throw ServerAuthorizationException(
      result.message ?? result.data,
    );
  }

  Future<User> getMainUser() async {
    final ServerApi serverApi = ServerApi();
    const User fallbackUser = User(
      isFoundOnServer: false,
      type: UserType.primary,
      note: "Couldn't find main user on server, API is outdated",
      login: 'UNKNOWN',
      sshKeys: [],
    );

    final String? serverApiVersion = await serverApi.getApiVersion();
    final users = await serverApi.getAllUsers();
    if (serverApiVersion == null || users.isEmpty) {
      return fallbackUser;
    }
    try {
      final Version parsedVersion = Version.parse(serverApiVersion);
      if (!VersionConstraint.parse('>=1.2.5').allows(parsedVersion)) {
        return fallbackUser;
      }
      return users.firstWhere(
        (final User user) => user.type == UserType.primary,
      );
    } on FormatException {
      return fallbackUser;
    }
  }

  Future<List<ServerBasicInfo>> getServersOnProviderAccount() async =>
      (await ProvidersController.currentServerProvider!.getServers()).data;

  Future<void> saveServerDetails(
    final ServerHostingDetails serverDetails,
  ) async {
    await getIt<ApiConfigModel>().setServerDetails(serverDetails);
  }

  Future<void> deleteServerDetails() async {
    await box.delete(BNames.serverDetails);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveServerProviderType(final ServerProviderType type) async {
    await getIt<ApiConfigModel>().storeServerProviderType(type);
  }

  Future<void> saveDnsProviderType(final DnsProviderType type) async {
    await getIt<ApiConfigModel>().setDnsProviderType(type);
  }

  Future<void> saveServerProviderKey(final String key) async {
    await getIt<ApiConfigModel>().setServerProviderKey(key);
  }

  Future<void> saveServerType(final ServerType serverType) async {
    await getIt<ApiConfigModel>().setServerTypeIdentifier(
      serverType.identifier,
    );
    await getIt<ApiConfigModel>().setServerLocation(
      serverType.location.identifier,
    );
  }

  Future<void> deleteServerProviderKey() async {
    await box.delete(BNames.hetznerKey);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveBackblazeKey(
    final BackupsCredential backblazeCredential,
  ) async {
    await getIt<ApiConfigModel>().setBackblazeCredential(backblazeCredential);
  }

  Future<void> deleteBackblazeKey() async {
    await box.delete(BNames.backblazeCredential);
    getIt<ApiConfigModel>().init();
  }

  Future<void> setDnsApiToken(final String key) async {
    await getIt<ApiConfigModel>().setDnsProviderKey(key);
  }

  Future<void> deleteDnsProviderKey() async {
    await box.delete(BNames.cloudFlareKey);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveDomain(final ServerDomain serverDomain) async {
    await getIt<ApiConfigModel>().setServerDomain(serverDomain);
  }

  Future<void> deleteDomain() async {
    await box.delete(BNames.serverDomain);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveIsServerStarted(final bool value) async {
    await box.put(BNames.isServerStarted, value);
  }

  Future<void> saveIsServerResetedFirstTime(final bool value) async {
    await box.put(BNames.isServerResetedFirstTime, value);
  }

  Future<void> saveIsServerResetedSecondTime(final bool value) async {
    await box.put(BNames.isServerResetedSecondTime, value);
  }

  Future<void> saveRootUser(final User rootUser) async {
    await box.put(BNames.rootUser, rootUser);
  }

  Future<void> saveIsRecoveringServer(final bool value) async {
    await box.put(BNames.isRecoveringServer, value);
  }

  Future<void> saveHasFinalChecked(final bool value) async {
    await box.put(BNames.hasFinalChecked, value);
  }

  Future<bool> deleteServer(final ServerDomain serverDomain) async {
    final ServerApi api = ServerApi();
    final dnsRecords = await api.getDnsRecords();
    final GenericResult<void> removalResult =
        await ProvidersController.currentDnsProvider!.removeDomainRecords(
      domain: serverDomain,
      records: dnsRecords,
    );

    if (!removalResult.success) {
      getIt<NavigationService>().showSnackBar(
        'modals.dns_removal_error'.tr(),
      );
      return false;
    }

    final deletionResult =
        await ProvidersController.currentServerProvider!.deleteServer(
      serverDomain.domainName,
    );

    if (!deletionResult.success) {
      getIt<NavigationService>().showSnackBar(
        'modals.server_validators_error'.tr(),
      );
      return false;
    }

    await box.put(BNames.hasFinalChecked, false);
    await box.put(BNames.isServerStarted, false);
    await box.put(BNames.isServerResetedFirstTime, false);
    await box.put(BNames.isServerResetedSecondTime, false);
    await box.put(BNames.isLoading, false);
    await box.put(BNames.serverDetails, null);

    return true;
  }

  Future<void> deleteServerRelatedRecords() async {
    await box.deleteAll([
      BNames.serverDetails,
      BNames.isServerStarted,
      BNames.isServerResetedFirstTime,
      BNames.isServerResetedSecondTime,
      BNames.hasFinalChecked,
      BNames.isLoading,
    ]);
    getIt<ApiConfigModel>().init();
  }
}
