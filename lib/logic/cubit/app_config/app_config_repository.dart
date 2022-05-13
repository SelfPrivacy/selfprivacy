import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/server_domain.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';

import 'app_config_cubit.dart';

class AppConfigRepository {
  Box box = Hive.box(BNames.appConfig);

  Future<AppConfigState> load() async {
    final hetznerToken = getIt<ApiConfigModel>().hetznerKey;
    final cloudflareToken = getIt<ApiConfigModel>().cloudFlareKey;
    final serverDomain = getIt<ApiConfigModel>().serverDomain;
    final backblazeCredential = getIt<ApiConfigModel>().backblazeCredential;
    final serverDetails = getIt<ApiConfigModel>().serverDetails;

    if (box.get(BNames.hasFinalChecked, defaultValue: false)) {
      return AppConfigFinished(
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

    if (getIt<ApiConfigModel>().serverDomain?.provider == DnsProvider.Unknown) {
      return AppConfigRecovery(
        hetznerKey: hetznerToken,
        cloudFlareKey: cloudflareToken,
        serverDomain: serverDomain,
        backblazeCredential: backblazeCredential,
        serverDetails: serverDetails,
        rootUser: box.get(BNames.rootUser),
        currentStep: getCurrentRecoveryStep(
            hetznerToken, cloudflareToken, serverDomain!, serverDetails),
      );
    }

    return AppConfigNotFinished(
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

  RecoveryStep getCurrentRecoveryStep(
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
    ServerDomain cloudFlareDomain,
  ) async {
    var cloudflareApi = CloudflareApi();

    await cloudflareApi.removeSimilarRecords(
      ip4: ip4,
      cloudFlareDomain: cloudFlareDomain,
    );

    await cloudflareApi.createMultipleDnsRecords(
      ip4: ip4,
      cloudFlareDomain: cloudFlareDomain,
    );

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
