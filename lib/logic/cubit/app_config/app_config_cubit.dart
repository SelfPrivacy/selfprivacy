import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/cloud_flare.dart';
import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

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
        hetznerServer: box.get(BNames.server),
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

  void setIsDnsCheckedAndDkimSet() {
    box.put(BNames.isDnsCheckedAndDkimSet, true);
    emit(state.copyWith(isDnsCheckedAndDkimSet: true));
  }

  void createServer() async {
    emit(state.copyWith(isLoading: true));
    var hetznerApi = HetznerApi(state.hetznerKey);
    var cloudflareApi = CloudflareApi(state.cloudFlareKey);

    var serverDetails = await hetznerApi.createServer(
      rootUser: state.rootUser,
      domainName: state.cloudFlareDomain.name,
    );

    cloudflareApi
        .createMultipleDnsRecords(
          ip4: serverDetails.ip4,
          cloudFlareDomain: state.cloudFlareDomain,
        )
        .then((_) => cloudflareApi.close());
    await box.put(BNames.server, serverDetails);

    hetznerApi.close();

    emit(state.copyWith(
      isLoading: false,
      hetznerServer: serverDetails,
    ));
  }
}
