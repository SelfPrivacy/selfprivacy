import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'app_config_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class AppConfigRepository {
  Box box = Hive.box(BNames.appConfig);

  Future<AppConfigState> load() async {
    late AppConfigState res;
    if (box.get(BNames.hasFinalChecked, defaultValue: false)) {
      res = AppConfigFinished(
        hetznerKey: getIt<ApiConfigModel>().hetznerKey!,
        cloudFlareKey: getIt<ApiConfigModel>().cloudFlareKey!,
        cloudFlareDomain: getIt<ApiConfigModel>().cloudFlareDomain!,
        backblazeCredential: getIt<ApiConfigModel>().backblazeCredential!,
        hetznerServer: getIt<ApiConfigModel>().hetznerServer!,
        rootUser: box.get(BNames.rootUser),
        isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
        isServerResetedFirstTime:
            box.get(BNames.isServerResetedFirstTime, defaultValue: false),
        isServerResetedSecondTime:
            box.get(BNames.isServerResetedSecondTime, defaultValue: false),
      );
    } else {
      res = AppConfigNotFinished(
        hetznerKey: getIt<ApiConfigModel>().hetznerKey,
        cloudFlareKey: getIt<ApiConfigModel>().cloudFlareKey,
        cloudFlareDomain: getIt<ApiConfigModel>().cloudFlareDomain,
        backblazeCredential: getIt<ApiConfigModel>().backblazeCredential,
        hetznerServer: getIt<ApiConfigModel>().hetznerServer,
        rootUser: box.get(BNames.rootUser),
        isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
        isServerResetedFirstTime:
            box.get(BNames.isServerResetedFirstTime, defaultValue: false),
        isServerResetedSecondTime:
            box.get(BNames.isServerResetedSecondTime, defaultValue: false),
        isLoading: box.get(BNames.isLoading, defaultValue: false),
      );
    }

    return res;
  }

  void clearAppConfig() {
    box.clear();
  }

  Future<HetznerServerDetails> startServer(
    HetznerServerDetails hetznerServer,
  ) async {
    var hetznerApi = HetznerApi();
    var serverDetails = await hetznerApi.powerOn();

    return serverDetails;
  }

  Future<bool> isDnsAddressesMatch(String? domainName, String? ip4) async {
    var addresses = <String>[
      '$domainName',
      'api.$domainName',
      'cloud.$domainName',
      'meet.$domainName',
      'password.$domainName'
    ];

    for (var address in addresses) {
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
        return false;
      }
    }

    return true;
  }

  Future<void> createServer(
    User rootUser,
    String domainName,
    String cloudFlareKey,
    BackblazeCredential backblazeCredential, {
    required void Function() onCancel,
    required Future<void> Function(HetznerServerDetails serverDetails)
        onSuccess,
  }) async {
    var hetznerApi = HetznerApi();
    late HetznerDataBase dataBase;

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
    CloudFlareDomain cloudFlareDomain,
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

  Future<bool> isHttpServerWorking() async {
    var api = ServerApi();
    var isHttpServerWorking = await api.isHttpServerWorking();
    return isHttpServerWorking;
  }

  Future<HetznerServerDetails> restart() async {
    var hetznerApi = HetznerApi();
    return await hetznerApi.reset();
  }

  Future<HetznerServerDetails> powerOn() async {
    var hetznerApi = HetznerApi();
    return await hetznerApi.powerOn();
  }

  Future<void> saveServerDetails(HetznerServerDetails serverDetails) async {
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

  Future<void> saveDomain(CloudFlareDomain cloudFlareDomain) async {
    await getIt<ApiConfigModel>().storeCloudFlareDomain(cloudFlareDomain);
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

  Future<void> deleteServer(CloudFlareDomain cloudFlareDomain) async {
    var hetznerApi = HetznerApi();
    var cloudFlare = CloudflareApi();

    await hetznerApi.deleteSelfprivacyServerAndAllVolumes(
      domainName: cloudFlareDomain.domainName,
    );

    await box.put(BNames.hasFinalChecked, false);
    await box.put(BNames.isServerStarted, false);
    await box.put(BNames.isServerResetedFirstTime, false);
    await box.put(BNames.isServerResetedSecondTime, false);
    await box.put(BNames.isLoading, false);
    await box.put(BNames.hetznerServer, null);

    await cloudFlare.removeSimilarRecords(cloudFlareDomain: cloudFlareDomain);
  }

  Future<void> deleteRecords() async {
    await box.deleteAll([
      BNames.hetznerServer,
      BNames.isServerStarted,
      BNames.isServerResetedFirstTime,
      BNames.isServerResetedSecondTime,
      BNames.hasFinalChecked,
      BNames.isLoading,
    ]);
    getIt<ApiConfigModel>().init();
  }
}
