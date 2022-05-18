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
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';

import '../server_installation/server_installation_cubit.dart';

class IpNotFoundException implements Exception {
  final String message;

  IpNotFoundException(this.message);
}

class ServerAuthorizationException implements Exception {
  final String message;

  ServerAuthorizationException(this.message);
}

class ServerInstallationRepository {
  Box box = Hive.box(BNames.serverInstallationBox);

  Future<ServerInstallationState> load() async {
    final hetznerToken = getIt<ApiConfigModel>().hetznerKey;
    final cloudflareToken = getIt<ApiConfigModel>().cloudFlareKey;
    final serverDomain = getIt<ApiConfigModel>().serverDomain;
    final backblazeCredential = getIt<ApiConfigModel>().backblazeCredential;
    final serverDetails = getIt<ApiConfigModel>().serverDetails;

    if (box.get(BNames.hasFinalChecked, defaultValue: false)) {
      return ServerInstallationFinished(
        hetznerKey: hetznerToken!,
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

    if (serverDomain != null && serverDomain.provider == DnsProvider.Unknown) {
      return ServerInstallationRecovery(
        hetznerKey: hetznerToken,
        cloudFlareKey: cloudflareToken,
        serverDomain: serverDomain,
        backblazeCredential: backblazeCredential,
        serverDetails: serverDetails,
        rootUser: box.get(BNames.rootUser),
        currentStep: _getCurrentRecoveryStep(
            hetznerToken, cloudflareToken, serverDomain, serverDetails),
        recoveryCapabilities: await getRecoveryCapabilities(serverDomain),
      );
    }

    return ServerInstallationNotFinished(
      hetznerKey: hetznerToken,
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
    String? hetznerToken,
    String? cloudflareToken,
    ServerDomain serverDomain,
    ServerHostingDetails? serverDetails,
  ) {
    if (serverDetails != null) {
      if (hetznerToken != null) {
        if (cloudflareToken != null) {
          return RecoveryStep.BackblazeToken;
        }
        return RecoveryStep.CloudflareToken;
      }
      return RecoveryStep.HetznerToken;
    }
    return RecoveryStep.Selecting;
  }

  void clearAppConfig() {
    box.clear();
  }

  Future<ServerHostingDetails> startServer(
    ServerHostingDetails hetznerServer,
  ) async {
    var hetznerApi = HetznerApi();
    var serverDetails = await hetznerApi.powerOn();

    return serverDetails;
  }

  Future<Map<String, bool>> isDnsAddressesMatch(String? domainName, String? ip4,
      Map<String, bool>? skippedMatches) async {
    var addresses = <String>[
      '$domainName',
      'api.$domainName',
      'cloud.$domainName',
      'meet.$domainName',
      'password.$domainName'
    ];

    var matches = <String, bool>{};

    for (var address in addresses) {
      if (skippedMatches != null && skippedMatches[address] == true) {
        matches[address] = true;
        continue;
      }
      var lookupRecordRes = await DnsUtils.lookupRecord(
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
    User rootUser,
    String domainName,
    String cloudFlareKey,
    BackblazeCredential backblazeCredential, {
    required void Function() onCancel,
    required Future<void> Function(ServerHostingDetails serverDetails)
        onSuccess,
  }) async {
    var hetznerApi = HetznerApi();
    late ServerVolume dataBase;

    try {
      dataBase = await hetznerApi.createVolume();

      var serverDetails = await hetznerApi.createServer(
        cloudFlareKey: cloudFlareKey,
        rootUser: rootUser,
        domainName: domainName,
        dataBase: dataBase,
      );
      saveServerDetails(serverDetails);
      onSuccess(serverDetails);
    } on DioError catch (e) {
      if (e.response!.data['error']['code'] == 'uniqueness_error') {
        var nav = getIt.get<NavigationService>();
        nav.showPopUpDialog(
          BrandAlert(
            title: 'modals.1'.tr(),
            contentText: 'modals.2'.tr(),
            actions: [
              ActionButton(
                text: 'basis.delete'.tr(),
                isRed: true,
                onPressed: () async {
                  await hetznerApi.deleteSelfprivacyServerAndAllVolumes(
                      domainName: domainName);

                  var serverDetails = await hetznerApi.createServer(
                    cloudFlareKey: cloudFlareKey,
                    rootUser: rootUser,
                    domainName: domainName,
                    dataBase: dataBase,
                  );

                  await saveServerDetails(serverDetails);
                  onSuccess(serverDetails);
                },
              ),
              ActionButton(
                text: 'basis.cancel'.tr(),
                onPressed: () {
                  onCancel();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> createDnsRecords(
    String ip4,
    ServerDomain cloudFlareDomain, {
    required void Function() onCancel,
  }) async {
    var cloudflareApi = CloudflareApi();

    await cloudflareApi.removeSimilarRecords(
      ip4: ip4,
      cloudFlareDomain: cloudFlareDomain,
    );

    try {
      await cloudflareApi.createMultipleDnsRecords(
        ip4: ip4,
        cloudFlareDomain: cloudFlareDomain,
      );
    } on DioError catch (e) {
      var hetznerApi = HetznerApi();
      var nav = getIt.get<NavigationService>();
      nav.showPopUpDialog(
        BrandAlert(
          title: e.response!.data["errors"][0]["code"] == 1038
              ? 'modals.10'.tr()
              : 'providers.domain.states.error'.tr(),
          contentText: 'modals.6'.tr(),
          actions: [
            ActionButton(
              text: 'basis.delete'.tr(),
              isRed: true,
              onPressed: () async {
                await hetznerApi.deleteSelfprivacyServerAndAllVolumes(
                    domainName: cloudFlareDomain.domainName);

                onCancel();
              },
            ),
            ActionButton(
              text: 'basis.cancel'.tr(),
              onPressed: () {
                onCancel();
              },
            ),
          ],
        ),
      );
    }

    await HetznerApi().createReverseDns(
      ip4: ip4,
      domainName: cloudFlareDomain.domainName,
    );
  }

  Future<void> createDkimRecord(ServerDomain cloudFlareDomain) async {
    var cloudflareApi = CloudflareApi();
    var api = ServerApi();

    var dkimRecordString = await api.getDkim();

    await cloudflareApi.setDkim(dkimRecordString ?? "", cloudFlareDomain);
  }

  Future<bool> isHttpServerWorking() async {
    var api = ServerApi();
    var isHttpServerWorking = await api.isHttpServerWorking();
    try {
      await api.getDkim();
    } catch (e) {
      return false;
    }
    return isHttpServerWorking;
  }

  Future<ServerHostingDetails> restart() async {
    var hetznerApi = HetznerApi();
    return await hetznerApi.reset();
  }

  Future<ServerHostingDetails> powerOn() async {
    var hetznerApi = HetznerApi();
    return await hetznerApi.powerOn();
  }

  Future<ServerRecoveryCapabilities> getRecoveryCapabilities(
    ServerDomain serverDomain,
  ) async {
    var serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final serverApiVersion = await serverApi.getApiVersion();
    if (serverApiVersion == null) {
      return ServerRecoveryCapabilities.none;
    }
    try {
      final parsedVersion = Version.parse(serverApiVersion);
      if (parsedVersion.major == 1 && parsedVersion.minor < 2) {
        return ServerRecoveryCapabilities.legacy;
      }
      return ServerRecoveryCapabilities.loginTokens;
    } on FormatException {
      return ServerRecoveryCapabilities.none;
    }
  }

  Future<String> getServerIpFromDomain(ServerDomain serverDomain) async {
    final lookup = await DnsUtils.lookupRecord(
        serverDomain.domainName, RRecordType.A,
        provider: DnsApiProvider.CLOUDFLARE);
    if (lookup == null || lookup.isEmpty) {
      throw IpNotFoundException('No IP found for domain $serverDomain');
    }
    return lookup[0].data;
  }

  Future<String> getDeviceName() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      return await deviceInfo.webBrowserInfo
          .then((value) => '${value.browserName} ${value.platform}');
    } else {
      if (Platform.isAndroid) {
        return await deviceInfo.androidInfo
            .then((value) => '${value.model} ${value.version.release}');
      } else if (Platform.isIOS) {
        return await deviceInfo.iosInfo.then((value) =>
            '${value.utsname.machine} ${value.systemName} ${value.systemVersion}');
      } else if (Platform.isLinux) {
        return await deviceInfo.linuxInfo.then((value) => value.prettyName);
      } else if (Platform.isMacOS) {
        return await deviceInfo.macOsInfo
            .then((value) => '${value.hostName} ${value.computerName}');
      } else if (Platform.isWindows) {
        return await deviceInfo.windowsInfo.then((value) => value.computerName);
      }
    }
    return 'Unidentified';
  }

  Future<ServerHostingDetails> authorizeByLoginToken(
    ServerDomain serverDomain,
    String loginToken,
  ) async {
    var serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final serverIp = await getServerIpFromDomain(serverDomain);
    final apiResponse = await serverApi.authorizeDevice(
        DeviceToken(device: await getDeviceName(), token: loginToken));

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
        ),
        provider: ServerProvider.Unknown,
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

  Future<ServerHostingDetails> authorizeByRecoveryToken(
    ServerDomain serverDomain,
    String recoveryToken,
  ) async {
    var serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
    );
    final apiResponse = await serverApi.useRecoveryToken(
        DeviceToken(device: await getDeviceName(), token: recoveryToken));

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
        ),
        provider: ServerProvider.Unknown,
        id: 0,
        ip4: '',
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(
      apiResponse.errorMessage ?? apiResponse.data,
    );
  }

  Future<ServerHostingDetails> authorizeByApiToken(
    ServerDomain serverDomain,
    String apiToken,
  ) async {
    var serverApi = ServerApi(
      isWithToken: false,
      overrideDomain: serverDomain.domainName,
      customToken: apiToken,
    );
    final deviceAuthKey = await serverApi.createDeviceToken();
    final apiResponse = await serverApi.authorizeDevice(
        DeviceToken(device: await getDeviceName(), token: deviceAuthKey.data));

    if (apiResponse.isSuccess) {
      return ServerHostingDetails(
        apiToken: apiResponse.data,
        volume: ServerVolume(
          id: 0,
          name: '',
        ),
        provider: ServerProvider.Unknown,
        id: 0,
        ip4: '',
        startTime: null,
        createTime: null,
      );
    }

    throw ServerAuthorizationException(
      apiResponse.errorMessage ?? apiResponse.data,
    );
  }

  Future<void> saveServerDetails(ServerHostingDetails serverDetails) async {
    await getIt<ApiConfigModel>().storeServerDetails(serverDetails);
  }

  Future<void> saveHetznerKey(String key) async {
    print('saved');
    await getIt<ApiConfigModel>().storeHetznerKey(key);
  }

  Future<void> saveBackblazeKey(BackblazeCredential backblazeCredential) async {
    await getIt<ApiConfigModel>().storeBackblazeCredential(backblazeCredential);
  }

  Future<void> saveCloudFlareKey(String key) async {
    await getIt<ApiConfigModel>().storeCloudFlareKey(key);
  }

  Future<void> saveDomain(ServerDomain serverDomain) async {
    await getIt<ApiConfigModel>().storeServerDomain(serverDomain);
  }

  Future<void> saveIsServerStarted(bool value) async {
    await box.put(BNames.isServerStarted, value);
  }

  Future<void> saveIsServerResetedFirstTime(bool value) async {
    await box.put(BNames.isServerResetedFirstTime, value);
  }

  Future<void> saveIsServerResetedSecondTime(bool value) async {
    await box.put(BNames.isServerResetedSecondTime, value);
  }

  Future<void> saveRootUser(User rootUser) async {
    await box.put(BNames.rootUser, rootUser);
  }

  Future<void> saveHasFinalChecked(bool value) async {
    await box.put(BNames.hasFinalChecked, value);
  }

  Future<void> deleteServer(ServerDomain serverDomain) async {
    var hetznerApi = HetznerApi();
    var cloudFlare = CloudflareApi();

    await hetznerApi.deleteSelfprivacyServerAndAllVolumes(
      domainName: serverDomain.domainName,
    );

    await box.put(BNames.hasFinalChecked, false);
    await box.put(BNames.isServerStarted, false);
    await box.put(BNames.isServerResetedFirstTime, false);
    await box.put(BNames.isServerResetedSecondTime, false);
    await box.put(BNames.isLoading, false);
    await box.put(BNames.serverDetails, null);

    await cloudFlare.removeSimilarRecords(cloudFlareDomain: serverDomain);
  }

  Future<void> deleteRecords() async {
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
