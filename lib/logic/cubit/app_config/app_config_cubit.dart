import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';

import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

import 'app_config_repository.dart';

part 'app_config_state.dart';

/// Initializing steps:
///
/// The set phase.
/// 1.1. Hetzner key                              |setHetznerKey
/// 1.2. Cloudflare key                           |setCloudflareKey
/// 1.3. Backblaze Id + Key                       |setBackblazeKey
/// 1.4. Set Domain address                       |setDomain
/// 1.5. Set Root user name password              |setRootUser
/// 1.6. Set Create server ans set DNS-Records    |createServerAndSetDnsRecords
///    (without start)
///
/// The check phase.
///
/// 2.1. a. wait 60sec checkDnsAndStartServer               |startServerIfDnsIsOkay
///      b. checkDns
///      c. if dns is okay start server
///
/// 2.2. a. wait 60sec                                      |resetServerIfServerIsOkay
///      b. checkServer
///      c. if server is ok wait 30 sec
///      d. reset server
///
/// 2.3. a. wait 60sec                                      |finishCheckIfServerIsOkay
///      b. checkServer
///      c. if server is okay set that fully checked

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(InitialAppConfigState());

  final repository = AppConfigRepository();

  void load() {
    var state = repository.load();
    emit(state);
  }

  void clearAppConfig() {
    repository.clearAppConfig();
    emit(InitialAppConfigState());
  }

  void setHetznerKey(String hetznerKey) {
    repository.saveHetznerKey(hetznerKey);
    emit(state.copyWith(hetznerKey: hetznerKey));
  }

  void setCloudflareKey(String cloudFlareKey) {
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

  void serverReset() async {
    var callBack = () async {
      var isServerWorking = await repository.isHttpServerWorking(
        state.cloudFlareDomain.domainName,
      );
      if (!isServerWorking) {
        var last = DateTime.now();
        emit(state.copyWith(lastServerStatusCheckTime: last));
        return;
      }

      var hetznerServerDetails = await repository.restart(
        state.hetznerKey,
        state.hetznerServer,
      );
      emit(state.copyWith(hetznerServer: hetznerServerDetails));
    };

    _tryOrAddError(state, callBack);
  }

  void checkDnsAndStartServer() async {
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
          isDnsChecked: true,
          isServerStarted: true,
          isLoading: false,
          hetznerServer: server,
        ),
      );
    } else {
      emit(state.copyWith(lastDnsCheckTime: DateTime.now()));
    }
  }

  void createServerAndSetDnsRecords() async {
    var onSuccess = (serverDetails) async {
      await repository.createDnsRecords(
        state.cloudFlareKey,
        serverDetails.ip4,
        state.cloudFlareDomain,
      );

      emit(state.copyWith(
        isLoading: false,
        hetznerServer: serverDetails,
      ));
    };

    var onCancel = () => emit(state.copyWith(isLoading: false));

    var callback = () async {
      await repository.createServer(
        state.hetznerKey,
        state.rootUser,
        state.cloudFlareDomain.domainName,
        state.cloudFlareKey,
        onCancel: onCancel,
        onSuccess: onSuccess,
      );
    };
    _tryOrAddError(state, callback);
  }

  FutureOr<void> _tryOrAddError(
    AppConfigState state,
    AsyncCallback callback,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await callback();
    } catch (e) {
      addError(e);
      emit(state);
    }
  }

  void setBackblazeKey(String keyId, String applicationKey) {
    var backblazeCredential = BackblazeCredential(
      keyId: keyId,
      applicationKey: applicationKey,
    );
    repository.saveBackblazeKey(backblazeCredential);
    emit(state.copyWith(backblazeCredential: backblazeCredential));
  }
}
