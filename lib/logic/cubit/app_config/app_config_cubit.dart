import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloud_flare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(InitialAppConfigState());

  Box box = Hive.box(BNames.appConfig);

  void load() {
    emit(
      state.copyWith(
        hetznerKey: box.get(BNames.hetznerKey),
        cloudFlareKey: box.get(BNames.cloudFlareKey),
        domain: box.get(BNames.domain),
        rootUser: box.get(BNames.rootUser),
        hetznerServer: box.get(BNames.hetznerServer),
        isDnsCheckedAndDkimSet: box.get(BNames.isDnsCheckedAndDkimSet),
      ),
    );
  }

  void reset() {
    box.clear();
    emit(InitialAppConfigState());
  }

  void setHetznerKey(String key) {
    box.put(BNames.hetznerKey, key);
    emit(state.copyWith(hetznerKey: key));
  }

  void setCloudFlare(String cloudFlareKey) {
    box.put(BNames.cloudFlareKey, cloudFlareKey);
    emit(state.copyWith(cloudFlareKey: cloudFlareKey));
  }

  void setDomain(CloudFlareDomain domain) {
    box.put(BNames.domain, domain);
    emit(state.copyWith(domain: domain));
  }

  void setRootUser(User rootUser) {
    box.put(BNames.rootUser, rootUser);
    emit(state.copyWith(rootUser: rootUser));
  }

  Future<void> checkDns() async {
    var ip4 = state.server.ip4;
    var domainName = state.cloudFlareDomain.name;
    var addresses = <String>[
      '$domainName',
      'api.$domainName',
      'cloud.$domainName',
      'meet.$domainName',
      'password.$domainName'
    ];
    var hasError = false;
    for (var address in addresses) {
      var res = await DnsUtils.lookupRecord(
        address,
        RRecordType.A,
        provider: DnsApiProvider.CLOUDFLARE,
      );
      getIt.get<ConsoleModel>().addMessage(
            Message(
              text:
                  'DnsLookup: address:$address, $RRecordType, provider: CLOUDFLARE',
            ),
          );
      getIt.get<ConsoleModel>().addMessage(
            Message(
              text:
                  'DnsLookup: address:$address, $RRecordType, provider: CLOUDFLARE',
            ),
          );
      if (res.isEmpty || res[0].data != ip4) {
        hasError = true;
        break;
      }
    }
    if (hasError) {
      emit(state.copyWith(error: Exception('dns cloudflare checking error')));
    } else {
      print('check complete');
    }
  }

  void createServer() async {
    emit(state.copyWith(isLoading: true));
    var hetznerApi = HetznerApi(state.hetznerKey);
    var cloudflareApi = CloudflareApi(state.cloudFlareKey);

    HetznerServerDetails serverDetails;

    try {
      serverDetails = await hetznerApi.createServer(
        rootUser: state.rootUser,
        domainName: state.cloudFlareDomain.name,
      );
    } catch (e) {
      addError(e);
    }

    try {
      cloudflareApi
          .createMultipleDnsRecords(
            ip4: serverDetails.ip4,
            cloudFlareDomain: state.cloudFlareDomain,
          )
          .then((_) => cloudflareApi.close());
    } catch (e) {
      addError(e);
    }

    await box.put(BNames.hetznerServer, serverDetails);

    hetznerApi.close();

    emit(state.copyWith(
      isLoading: false,
      hetznerServer: serverDetails,
    ));
  }
}
