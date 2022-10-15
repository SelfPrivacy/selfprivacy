import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';

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
  Box<User> usersBox = Hive.box(BNames.usersBox);
  ServerProviderApiFactory? serverProviderApiFactory;
  DnsProviderApiFactory? dnsProviderApiFactory =
      ApiFactoryCreator.createDnsProviderApiFactory(
    DnsProvider.cloudflare, // TODO: HARDCODE FOR NOW!!!
  );

  Future<ServerInstallationState> load() async {
    final String? providerApiToken = getIt<ApiConfigModel>().serverProviderKey;
    final String? cloudflareToken = getIt<ApiConfigModel>().cloudFlareKey;
    final String? serverTypeIdentificator = getIt<ApiConfigModel>().serverType;
    final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
    final BackblazeCredential? backblazeCredential =
        getIt<ApiConfigModel>().backblazeCredential;
    final ServerHostingDetails? serverDetails =
        getIt<ApiConfigModel>().serverDetails;

    if (serverDetails != null &&
        serverDetails.provider != ServerProvider.unknown) {
      serverProviderApiFactory =
          ApiFactoryCreator.createServerProviderApiFactory(
        serverDetails.provider,
      );
    }

    if (serverDomain != null && serverDomain.provider != DnsProvider.unknown) {
      dnsProviderApiFactory = ApiFactoryCreator.createDnsProviderApiFactory(
        serverDomain.provider,
      );
    }

    if (box.get(BNames.hasFinalChecked, defaultValue: false)) {
      return ServerInstallationFinished(
        providerApiToken: providerApiToken!,
        serverTypeIdentificator: serverTypeIdentificator!,
        cloudFlareKey: cloudflareToken!,
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

    if (box.get(BNames.isRecoveringServer, defaultValue: false) &&
        serverDomain != null) {
      return ServerInstallationRecovery(
        providerApiToken: providerApiToken,
        cloudFlareKey: cloudflareToken,
        serverDomain: serverDomain,
        backblazeCredential: backblazeCredential,
        serverDetails: serverDetails,
        rootUser: box.get(BNames.rootUser),
        currentStep: _getCurrentRecoveryStep(
          providerApiToken,
          cloudflareToken,
          serverDomain,
          serverDetails,
        ),
        recoveryCapabilities: await getRecoveryCapabilities(serverDomain),
      );
    }

    return ServerInstallationNotFinished(
      providerApiToken: providerApiToken,
      cloudFlareKey: cloudflareToken,
      serverDomain: serverDomain,
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
    );
  }

  RecoveryStep _getCurrentRecoveryStep(
    final String? serverProviderToken,
    final String? cloudflareToken,
    final ServerDomain serverDomain,
    final ServerHostingDetails? serverDetails,
  ) {
    if (serverDetails != null) {
      if (serverProviderToken != null) {
        if (serverDetails.provider != ServerProvider.unknown) {
          if (serverDomain.provider != DnsProvider.unknown) {
            return RecoveryStep.backblazeToken;
          }
          return RecoveryStep.cloudflareToken;
        }
        return RecoveryStep.serverSelection;
      }
      return RecoveryStep.serverProviderToken;
    }
    return RecoveryStep.selecting;
  }

  void clearAppConfig() {
    box.clear();
    usersBox.clear();
  }

  Future<ServerHostingDetails> startServer(
    final ServerHostingDetails server,
  ) async {
    ServerHostingDetails serverDetails;

    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    serverDetails = await api.powerOn();

    return serverDetails;
  }

  Future<String?> getDomainId(final String token, final String domain) async {
    final DnsProviderApi dnsProviderApi = dnsProviderApiFactory!.getDnsProvider(
      settings: DnsProviderApiSettings(
        isWithToken: false,
        customToken: token,
      ),
    );

    final String? domainId = await dnsProviderApi.getZoneId(domain);
    return domainId;
  }

  Future<Map<String, bool>> isDnsAddressesMatch(
    final String? domainName,
    final String? ip4,
    final Map<String, bool> skippedMatches,
  ) async {
    final List<String> addresses = <String>[
      '$domainName',
      'api.$domainName',
      'cloud.$domainName',
      'meet.$domainName',
      'password.$domainName'
    ];

    final Map<String, bool> matches = <String, bool>{};

    for (final String address in addresses) {
      if (skippedMatches[address] ?? false) {
        matches[address] = true;
        continue;
      }
      final List<RRecord>? lookupRecordRes = await DnsUtils.lookupRecord(
        address,
        RRecordType.A,
        provider: DnsApiProvider.CLOUDFLARE,
      );
      getIt.get<ConsoleModel>().addMessage(
            Message(
              text:
                  'DnsLookup: address: $address, $RRecordType, provider: CLOUDFLARE, ip4: $ip4',
            ),
          );
      getIt.get<ConsoleModel>().addMessage(
            Message(
              text:
                  'DnsLookup: ${lookupRecordRes == null ? 'empty' : (lookupRecordRes[0].data != ip4 ? 'wrong ip4' : 'right ip4')}',
            ),
          );
      if (lookupRecordRes == null ||
          lookupRecordRes.isEmpty ||
          lookupRecordRes[0].data != ip4) {
        matches[address] = false;
      } else {
        matches[address] = true;
      }
    }

    return matches;
  }

  Future<void> createServer(
    final User rootUser,
    final String domainName,
    final String cloudFlareKey,
    final BackblazeCredential backblazeCredential, {
    required final void Function() onCancel,
    required final Future<void> Function(ServerHostingDetails serverDetails)
        onSuccess,
  }) async {
    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    try {
      final ServerHostingDetails? serverDetails = await api.createServer(
        dnsApiToken: cloudFlareKey,
        rootUser: rootUser,
        domainName: domainName,
      );

      if (serverDetails == null) {
        print('Server is not initialized!');
        return;
      }
      saveServerDetails(serverDetails);
      onSuccess(serverDetails);
    } on DioError catch (e) {
      if (e.response!.data['error']['code'] == 'uniqueness_error') {
        final NavigationService nav = getIt.get<NavigationService>();
        nav.showPopUpDialog(
          BrandAlert(
            title: 'modals.already_exists'.tr(),
            contentText: 'modals.destroy_server'.tr(),
            actions: [
              ActionButton(
                text: 'basis.delete'.tr(),
                isRed: true,
                onPressed: () async {
                  await api.deleteServer(
                    domainName: domainName,
                  );

                  ServerHostingDetails? serverDetails;
                  try {
                    serverDetails = await api.createServer(
                      dnsApiToken: cloudFlareKey,
                      rootUser: rootUser,
                      domainName: domainName,
                    );
                  } catch (e) {
                    print(e);
                  }

                  if (serverDetails == null) {
                    print('Server is not initialized!');
                    return;
                  }
                  await saveServerDetails(serverDetails);
                  onSuccess(serverDetails);
                },
              ),
              ActionButton(
                text: 'basis.cancel'.tr(),
                onPressed: onCancel,
              ),
            ],
          ),
        );
      } else if (e.response!.data['error']['code'] == 'resource_unavailable') {
        final NavigationService nav = getIt.get<NavigationService>();
        nav.showPopUpDialog(
          BrandAlert(
            title: 'modals.unexpected_error'.tr(),
            contentText: 'modals.try_again'.tr(),
            actions: [
              ActionButton(
                text: 'modals.yes'.tr(),
                isRed: true,
                onPressed: () async {
                  ServerHostingDetails? serverDetails;
                  try {
                    serverDetails = await api.createServer(
                      dnsApiToken: cloudFlareKey,
                      rootUser: rootUser,
                      domainName: domainName,
                    );
                  } catch (e) {
                    print(e);
                  }

                  if (serverDetails == null) {
                    print('Server is not initialized!');
                    return;
                  }
                  await saveServerDetails(serverDetails);
                  onSuccess(serverDetails);
                },
              ),
              ActionButton(
                text: 'basis.cancel'.tr(),
                onPressed: onCancel,
              ),
            ],
          ),
        );
      }
    }
  }

  Future<bool> createDnsRecords(
    final ServerHostingDetails serverDetails,
    final ServerDomain domain, {
    required final void Function() onCancel,
  }) async {
    final DnsProviderApi dnsProviderApi =
        dnsProviderApiFactory!.getDnsProvider();
    final ServerProviderApi serverApi =
        serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );

    await dnsProviderApi.removeSimilarRecords(
      ip4: serverDetails.ip4,
      domain: domain,
    );

    try {
      await dnsProviderApi.createMultipleDnsRecords(
        ip4: serverDetails.ip4,
        domain: domain,
      );
    } on DioError catch (e) {
      final NavigationService nav = getIt.get<NavigationService>();
      nav.showPopUpDialog(
        BrandAlert(
          title: e.response!.data['errors'][0]['code'] == 1038
              ? 'modals.you_cant_use_this_api'.tr()
              : 'domain.states.error'.tr(),
          contentText: 'modals.delete_server_volume'.tr(),
          actions: [
            ActionButton(
              text: 'basis.delete'.tr(),
              isRed: true,
              onPressed: () async {
                await serverApi.deleteServer(
                  domainName: domain.domainName,
                );

                onCancel();
              },
            ),
            ActionButton(
              text: 'basis.cancel'.tr(),
              onPressed: onCancel,
            ),
          ],
        ),
      );
      return false;
    }

    await serverApi.createReverseDns(
      serverDetails: serverDetails,
      domain: domain,
    );

    return true;
  }

  Future<void> createDkimRecord(final ServerDomain cloudFlareDomain) async {
    final DnsProviderApi dnsProviderApi =
        dnsProviderApiFactory!.getDnsProvider();
    final ServerApi api = ServerApi();

    String dkimRecordString = '';
    try {
      dkimRecordString = (await api.getDkim())!;
    } catch (e) {
      print(e);
      rethrow;
    }

    await dnsProviderApi.setDkim(dkimRecordString, cloudFlareDomain);
  }

  Future<bool> isHttpServerWorking() async {
    final ServerApi api = ServerApi();
    return api.isHttpServerWorking();
  }

  Future<ServerHostingDetails> restart() async {
    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    return api.restart();
  }

  Future<ServerHostingDetails> powerOn() async {
    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    return api.powerOn();
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
    final List<RRecord>? lookup = await DnsUtils.lookupRecord(
      serverDomain.domainName,
      RRecordType.A,
      provider: DnsApiProvider.CLOUDFLARE,
    );
    if (lookup == null || lookup.isEmpty) {
      throw IpNotFoundException('No IP found for domain $serverDomain');
    }
    return lookup[0].data;
  }

  Future<String> getDeviceName() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      return deviceInfo.webBrowserInfo.then(
        (final WebBrowserInfo value) =>
            '${value.browserName} ${value.platform}',
      );
    } else {
      if (Platform.isAndroid) {
        return deviceInfo.androidInfo.then(
          (final AndroidDeviceInfo value) =>
              '${value.model} ${value.version.release}',
        );
      } else if (Platform.isIOS) {
        return deviceInfo.iosInfo.then(
          (final IosDeviceInfo value) =>
              '${value.utsname.machine} ${value.systemName} ${value.systemVersion}',
        );
      } else if (Platform.isLinux) {
        return deviceInfo.linuxInfo
            .then((final LinuxDeviceInfo value) => value.prettyName);
      } else if (Platform.isMacOS) {
        return deviceInfo.macOsInfo.then(
          (final MacOsDeviceInfo value) =>
              '${value.hostName} ${value.computerName}',
        );
      } else if (Platform.isWindows) {
        return deviceInfo.windowsInfo
            .then((final WindowsDeviceInfo value) => value.computerName);
      }
    }
    return 'Unidentified';
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
    final ApiResponse<String> apiResponse = await serverApi.authorizeDevice(
      DeviceToken(device: await getDeviceName(), token: newDeviceKey),
    );

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProvider.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(
      apiResponse.errorMessage ?? apiResponse.data,
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
    final ApiResponse<String> apiResponse = await serverApi.useRecoveryToken(
      DeviceToken(device: await getDeviceName(), token: recoveryKey),
    );

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProvider.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(
      apiResponse.errorMessage ?? apiResponse.data,
    );
  }

  Future<ServerHostingDetails> authorizeByApiToken(
    final ServerDomain serverDomain,
    final String apiToken,
    final ServerRecoveryCapabilities recoveryCapabilities,
  ) async {
    final ServerApi serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
      customToken: apiToken,
    );
    final String serverIp = await getServerIpFromDomain(serverDomain);
    if (recoveryCapabilities == ServerRecoveryCapabilities.legacy) {
      final Map<String, bool> apiResponse =
          await serverApi.servicesPowerCheck();
      if (apiResponse.isNotEmpty) {
        return ServerHostingDetails(
          apiToken: apiToken,
          volume: ServerVolume(
            id: 0,
            name: '',
            serverId: 0,
            sizeByte: 0,
            linuxDevice: '',
          ),
          provider: ServerProvider.unknown,
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
    final ApiResponse<String> deviceAuthKey =
        await serverApi.createDeviceToken();
    final ApiResponse<String> apiResponse = await serverApi.authorizeDevice(
      DeviceToken(device: await getDeviceName(), token: deviceAuthKey.data),
    );

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
          sizeByte: 0,
          serverId: 0,
          linuxDevice: '',
        ),
        provider: ServerProvider.unknown,
        id: 0,
        ip4: serverIp,
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(
      apiResponse.errorMessage ?? apiResponse.data,
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
    final ApiResponse<List<String>> users =
        await serverApi.getUsersList(withMainUser: true);
    if (serverApiVersion == null || !users.isSuccess) {
      return fallbackUser;
    }
    try {
      final Version parsedVersion = Version.parse(serverApiVersion);
      if (!VersionConstraint.parse('>=1.2.5').allows(parsedVersion)) {
        return fallbackUser;
      }
      return User(
        isFoundOnServer: true,
        login: users.data[0],
        type: UserType.primary,
      );
    } on FormatException {
      return fallbackUser;
    }
  }

  Future<List<ServerBasicInfo>> getServersOnProviderAccount() async {
    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    return api.getServers();
  }

  Future<void> saveServerDetails(
    final ServerHostingDetails serverDetails,
  ) async {
    await getIt<ApiConfigModel>().storeServerDetails(serverDetails);
  }

  Future<void> deleteServerDetails() async {
    await box.delete(BNames.serverDetails);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveServerProviderKey(final String key) async {
    await getIt<ApiConfigModel>().storeServerProviderKey(key);
  }

  Future<void> saveServerType(final String serverType) async {
    await getIt<ApiConfigModel>().storeServerTypeIdentifier(serverType);
  }

  Future<void> deleteServerProviderKey() async {
    await box.delete(BNames.hetznerKey);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveBackblazeKey(
    final BackblazeCredential backblazeCredential,
  ) async {
    await getIt<ApiConfigModel>().storeBackblazeCredential(backblazeCredential);
  }

  Future<void> deleteBackblazeKey() async {
    await box.delete(BNames.backblazeCredential);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveCloudFlareKey(final String key) async {
    await getIt<ApiConfigModel>().storeCloudFlareKey(key);
  }

  Future<void> deleteCloudFlareKey() async {
    await box.delete(BNames.cloudFlareKey);
    getIt<ApiConfigModel>().init();
  }

  Future<void> saveDomain(final ServerDomain serverDomain) async {
    await getIt<ApiConfigModel>().storeServerDomain(serverDomain);
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

  Future<void> deleteServer(final ServerDomain serverDomain) async {
    final ServerProviderApi api = serverProviderApiFactory!.getServerProvider(
      settings: const ServerProviderApiSettings(
        region: 'fra1',
      ),
    );
    final DnsProviderApi dnsProviderApi =
        dnsProviderApiFactory!.getDnsProvider();

    await api.deleteServer(
      domainName: serverDomain.domainName,
    );

    await box.put(BNames.hasFinalChecked, false);
    await box.put(BNames.isServerStarted, false);
    await box.put(BNames.isServerResetedFirstTime, false);
    await box.put(BNames.isServerResetedSecondTime, false);
    await box.put(BNames.isLoading, false);
    await box.put(BNames.serverDetails, null);

    await dnsProviderApi.removeSimilarRecords(domain: serverDomain);
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
