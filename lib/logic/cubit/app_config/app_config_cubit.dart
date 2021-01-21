import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';

import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

import 'app_config_repository.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(InitialAppConfigState());

  final repository = AppConfigRepository();

  void load() {
    var state = repository.load();
    emit(state);
  }

  void reset() {
    repository.reset();
    emit(InitialAppConfigState());
  }

  void setHetznerKey(String hetznerKey) {
    repository.saveHetznerKey(hetznerKey);
    emit(state.copyWith(hetznerKey: hetznerKey));
  }

  void setCloudFlare(String cloudFlareKey) {
    repository.saveCloudFlare(cloudFlareKey);
    emit(state.copyWith(cloudFlareKey: cloudFlareKey));
  }

  void setDomain(CloudFlareDomain cloudFlareDomain) {
    repository.saveDomain(cloudFlareDomain);
    emit(state.copyWith(cloudFlareDomain: cloudFlareDomain));
  }

  void setRootUser(User rootUser) {
    repository.saveRootUser(rootUser);
    emit(state.copyWith(rootUser: rootUser));
  }

  Future<void> checkDns() async {
    var ip4 = state.hetznerServer.ip4;
    var domainName = state.cloudFlareDomain.domainName;

    var isMatch = await repository.isDnsAddressesMatch(domainName, ip4);

    if (isMatch) {
      var server = await repository.startServer(
        state.hetznerKey,
        state.hetznerServer,
      );
      repository.saveServerDetails(server);
      emit(
        state.copyWith(
          isDnsCheckedAndServerStarted: true,
          isLoading: false,
          hetznerServer: server,
        ),
      );
    } else {
      emit(state.copyWith(lastDnsCheckTime: DateTime.now()));
    }
  }

  void createServer() async {
    emit(state.copyWith(isLoading: true));

    try {
      var serverDetails = await repository.createServer(
        state.hetznerKey,
        state.rootUser,
        state.cloudFlareDomain.domainName,
      );

      await repository.createDnsRecords(
        state.cloudFlareKey,
        serverDetails.ip4,
        state.cloudFlareDomain,
      );

      emit(state.copyWith(
        isLoading: false,
        hetznerServer: serverDetails,
      ));
    } catch (e) {
      addError(e);

      emit(state.copyWith(isLoading: false));
    }
  }
}
