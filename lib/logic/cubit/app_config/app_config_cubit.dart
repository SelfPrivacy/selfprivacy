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
/// 1. Hetzner key                              |setHetznerKey
/// 2. Cloudflare key                           |setCloudflareKey
/// 3. Backblaze Id + Key                       |setBackblazeKey

/// 4. Set Domain address                       |setDomain
/// 5. Set Root user name password              |setRootUser
/// 6. Set Create server ans set DNS-Records    |createServerAndSetDnsRecords
///    (without start)
/// 7. ChecksAndSets:
///   7.1 checkDnsAndStartServer                |checkDnsAndStartServer
///   7.2 setDkim                               |setDkim
///       a. checkServer
///       b. getDkim
///       c. Set DKIM
///       d. server restart                              


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

  void setDkim() async {
    var callBack = () async {
      var isServerWorking = await repository.isHttpServerWorking(
        state.cloudFlareDomain.domainName,
      );
      if (!isServerWorking) {
        var last = DateTime.now();
        print(last);
        emit(state.copyWith(lastServerStatusCheckTime: last));
        return;
      }

      await repository.setDkim(
        state.cloudFlareDomain.domainName,
        state.cloudFlareKey,
        state.cloudFlareDomain.zoneId,
      );

      var hetznerServerDetails = await repository.restart(
        state.hetznerKey,
        state.hetznerServer,
      );
      emit(
        state.copyWith(
          isDkimSetted: true,
          hetznerServer: hetznerServerDetails,
        ),
      );
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
    var callback = () async {
      var serverDetails = await repository.createServer(
        state.hetznerKey,
        state.rootUser,
        state.cloudFlareDomain.domainName,
        state.cloudFlareKey,
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
