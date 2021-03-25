import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/get_it/api_config.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'app_config_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class AppConfigRepository {
  Box box = Hive.box(BNames.appConfig);

  AppConfigState load() {
    return AppConfigState(
      hetznerKey: getIt<ApiConfigModel>().hetznerKey,
      cloudFlareKey: getIt<ApiConfigModel>().cloudFlareKey,
      cloudFlareDomain: getIt<ApiConfigModel>().cloudFlareDomain,
      backblazeCredential: getIt<ApiConfigModel>().backblazeCredential,
      hetznerServer: getIt<ApiConfigModel>().hetznerServer,
      rootUser: box.get(BNames.rootUser),
      isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
      isServerReseted: box.get(BNames.isServerReseted, defaultValue: false),
      hasFinalChecked: box.get(BNames.hasFinalChecked, defaultValue: false),
      error: null,
      isLoading: box.get(BNames.isLoading, defaultValue: false),
    );
  }

  void clearAppConfig() {
    box.clear();
  }

  Future<HetznerServerDetails> startServer(
    String? hetznerKey,
    HetznerServerDetails hetznerServer,
  ) async {
    var hetznerApi = HetznerApi(hetznerKey);
    var serverDetails = await hetznerApi.startServer(server: hetznerServer);
    hetznerApi.close();

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
    String? hetznerKey,
    User rootUser,
    String? domainName,
    String? cloudFlareKey, {
    void Function()? onCancel,
    required Future<void> Function(HetznerServerDetails serverDetails)
        onSuccess,
  }) async {
    var hetznerApi = HetznerApi(hetznerKey);

    try {
      var serverDetails = await hetznerApi.createServer(
        cloudFlareKey: cloudFlareKey,
        rootUser: rootUser,
        domainName: domainName,
      );
      hetznerApi.close();
      saveServerDetails(serverDetails);
      onSuccess(serverDetails);
    } on DioError catch (e) {
      if (e.response!.data['error']['code'] == 'uniqueness_error') {
        var nav = getIt.get<NavigationService>();
        nav.showPopUpDialog(
          BrandAlert(
            title: 'modals.1'.tr(),
            contentText: 'modals.2'.tr(),
            acitons: [
              ActionButton(
                text: 'basis.delete'.tr(),
                isRed: true,
                onPressed: () async {
                  await hetznerApi.deleteSelfprivacyServer(
                    cloudFlareKey: cloudFlareKey,
                  );

                  var serverDetails = await hetznerApi.createServer(
                    cloudFlareKey: cloudFlareKey,
                    rootUser: rootUser,
                    domainName: domainName,
                  );
                  hetznerApi.close();

                  await saveServerDetails(serverDetails);
                  onSuccess(serverDetails);
                },
              ),
              ActionButton(
                text: 'basis.cancel'.tr(),
                onPressed: () {
                  hetznerApi.close();
                  onCancel!();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> createDnsRecords(
    String? cloudFlareKey,
    String? ip4,
    CloudFlareDomain cloudFlareDomain,
  ) async {
    var cloudflareApi = CloudflareApi(cloudFlareKey);

    await cloudflareApi.removeSimilarRecords(
      ip4: ip4,
      cloudFlareDomain: cloudFlareDomain,
    );

    await cloudflareApi.createMultipleDnsRecords(
      ip4: ip4,
      cloudFlareDomain: cloudFlareDomain,
    );

    cloudflareApi.close();
  }

  Future<bool> isHttpServerWorking(String? domainName) async {
    var api = ServerApi(domainName);
    var isHttpServerWorking = await api.isHttpServerWorking();
    api.close();
    return isHttpServerWorking;
  }

  Future<HetznerServerDetails> restart(
    String? hetznerKey,
    HetznerServerDetails server,
  ) async {
    var hetznerApi = HetznerApi(hetznerKey);
    return await hetznerApi.restart(server: server);
  }

  Future<void> saveServerDetails(HetznerServerDetails serverDetails) async {
    await getIt<ApiConfigModel>().storeServerDetails(serverDetails);
  }

  Future<void> saveHetznerKey(String key) async {
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

  Future<void> saveIsServerReseted(bool value) async {
    await box.put(BNames.isServerReseted, value);
  }

  void saveRootUser(User rootUser) async {
    await box.put(BNames.rootUser, rootUser);
  }

  void saveHasFinalChecked(bool value) async {
    await box.put(BNames.hasFinalChecked, value);
  }
}
