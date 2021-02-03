import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:basic_utils/basic_utils.dart';
import 'app_config_cubit.dart';

class AppConfigRepository {
  Box box = Hive.box(BNames.appConfig);

  AppConfigState load() {
    return AppConfigState(
      hetznerKey: box.get(BNames.hetznerKey),
      cloudFlareKey: box.get(BNames.cloudFlareKey),
      cloudFlareDomain: box.get(BNames.cloudFlareDomain),
      backblazeKey: box.get(BNames.backblazeKey),
      rootUser: box.get(BNames.rootUser),
      hetznerServer: box.get(BNames.hetznerServer),
      isServerStarted: box.get(BNames.isServerStarted, defaultValue: false),
      isDnsChecked: box.get(BNames.isDnsChecked, defaultValue: false),
      isDkimSetted: box.get(BNames.isDkimSetted, defaultValue: false),
    );
  }

  void clearAppConfig() {
    box.clear();
  }

  void saveHetznerKey(String key) {
    box.put(BNames.hetznerKey, key);
  }

  void saveBackblazeKey(String key) {
    box.put(BNames.backblazeKey, key);
  }

  void saveCloudFlare(String key) {
    box.put(BNames.cloudFlareKey, key);
  }

  void saveDomain(CloudFlareDomain cloudFlareDomain) {
    box.put(BNames.cloudFlareDomain, cloudFlareDomain);
  }

  void saveRootUser(User rootUser) {
    box.put(BNames.rootUser, rootUser);
  }

  Future<HetznerServerDetails> startServer(
    String hetznerKey,
    HetznerServerDetails hetznerServer,
  ) async {
    var hetznerApi = HetznerApi(hetznerKey);
    var serverDetails = await hetznerApi.startServer(server: hetznerServer);
    hetznerApi.close();
    box.put(BNames.isServerStarted, true);

    return serverDetails;
  }

  Future<void> saveServerDetails(HetznerServerDetails serverDetails) async {
    await box.put(BNames.hetznerServer, serverDetails);
  }

  Future<bool> isDnsAddressesMatch(String domainName, String ip4) async {
    print(domainName);
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

    box.put(BNames.isDnsChecked, true);

    return true;
  }

  Future<HetznerServerDetails> createServer(String hetznerKey, User rootUser,
      String domainName, String cloudFlareKey) async {
    var hetznerApi = HetznerApi(hetznerKey);
    var serverDetails = await hetznerApi.createServer(
      cloudFlareKey: cloudFlareKey,
      rootUser: rootUser,
      domainName: domainName,
    );
    await box.put(BNames.hetznerServer, serverDetails);

    hetznerApi.close();

    return serverDetails;
  }

  Future<void> createDnsRecords(
    String cloudFlareKey,
    String ip4,
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

  Future<bool> isHttpServerWorking(String domainName) async {
    var api = ServerApi(domainName);
    var isHttpServerWorking = await api.isHttpServerWorking();
    api.close();
    return isHttpServerWorking;
  }

  Future<void> setDkim(
    String domainName,
    String cloudFlareKey,
    String zoneId,
  ) async {
    var api = ServerApi(domainName);
    var dkimRecordString = await api.getDkim(domainName);
    var cloudflareApi = CloudflareApi(cloudFlareKey);

    await cloudflareApi.setDkim(dkimRecordString, zoneId);
    box.put(BNames.isDkimSetted, true);

    cloudflareApi.close();
  }

  Future<HetznerServerDetails> reset(
    String hetznerKey,
    HetznerServerDetails server,
  ) async {
    var hetznerApi = HetznerApi(hetznerKey);
    return await hetznerApi.reset(server: server);
  }
}
