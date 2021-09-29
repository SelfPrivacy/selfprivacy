import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/ssh.dart';
import 'package:selfprivacy/logic/models/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';

import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

import 'app_config_repository.dart';
export 'package:provider/provider.dart';

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
/// 2.3. a. wait 60sec                                      |oneMoreReset()
///      d. reset server
///
/// 2.4. a. wait 30sec                                      |finishCheckIfServerIsOkay
///      b. checkServer
///      c. if server is okay set that fully checked

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(AppConfigEmpty());

  final repository = AppConfigRepository();

  Future<void> load() async {
    var state = await repository.load();

    if (state is AppConfigFinished) {
      emit(state);
    } else if (state is AppConfigNotFinished) {
      if (state.progress == 6) {
        startServerIfDnsIsOkay(state: state, isImmediate: true);
      } else if (state.progress == 7) {
        resetServerIfServerIsOkay(state: state, isImmediate: true);
      } else if (state.progress == 8) {
        oneMoreReset(state: state, isImmediate: true);
      } else if (state.progress == 9) {
        finishCheckIfServerIsOkay(state: state, isImmediate: true);
      }
    } else {
      throw 'wrong state';
    }
  }

  void startServerIfDnsIsOkay({
    AppConfigNotFinished? state,
    bool isImmediate = false,
  }) async {
    state = state ?? this.state as AppConfigNotFinished;

    final work = () async {
      emit(TimerState(dataState: state!, isLoading: true));

      var ip4 = state.hetznerServer!.ip4;
      var domainName = state.cloudFlareDomain!.domainName;

      var isMatch = await repository.isDnsAddressesMatch(domainName, ip4);

      if (isMatch) {
        var server = await repository.startServer(
          state.hetznerServer!,
        );
        await repository.saveServerDetails(server);
        await repository.saveIsServerStarted(true);

        emit(
          state.copyWith(
            isServerStarted: true,
            isLoading: false,
            hetznerServer: server,
          ),
        );
        resetServerIfServerIsOkay();
      } else {
        startServerIfDnsIsOkay();
      }
    };

    if (isImmediate) {
      work();
    } else {
      var pauseDuration = Duration(seconds: 60);
      emit(TimerState(
        dataState: state,
        timerStart: DateTime.now(),
        duration: pauseDuration,
        isLoading: false,
      ));
      timer = Timer(pauseDuration, work);
    }
  }

  void oneMoreReset({
    AppConfigNotFinished? state,
    bool isImmediate = false,
  }) async {
    var dataState = state ?? this.state as AppConfigNotFinished;

    var work = () async {
      emit(TimerState(dataState: dataState, isLoading: true));

      var isServerWorking = await repository.isHttpServerWorking();

      if (isServerWorking) {
        var pauseDuration = Duration(seconds: 30);
        emit(TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          isLoading: false,
          duration: pauseDuration,
        ));
        timer = Timer(pauseDuration, () async {
          var hetznerServerDetails = await repository.restart();
          await repository.saveIsServerResetedSecondTime(true);
          await repository.saveServerDetails(hetznerServerDetails);

          emit(
            dataState.copyWith(
              isServerResetedSecondTime: true,
              hetznerServer: hetznerServerDetails,
              isLoading: false,
            ),
          );
          finishCheckIfServerIsOkay();
        });
      } else {
        oneMoreReset();
      }
    };
    if (isImmediate) {
      work();
    } else {
      var pauseDuration = Duration(seconds: 60);
      emit(
        TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          duration: pauseDuration,
          isLoading: false,
        ),
      );
      timer = Timer(pauseDuration, work);
    }
  }

  void resetServerIfServerIsOkay({
    AppConfigNotFinished? state,
    bool isImmediate = false,
  }) async {
    var dataState = state ?? this.state as AppConfigNotFinished;

    var work = () async {
      emit(TimerState(dataState: dataState, isLoading: true));

      var isServerWorking = await repository.isHttpServerWorking();

      if (isServerWorking) {
        var pauseDuration = Duration(seconds: 30);
        emit(TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          isLoading: false,
          duration: pauseDuration,
        ));
        timer = Timer(pauseDuration, () async {
          var hetznerServerDetails = await repository.restart();
          await repository.saveIsServerResetedFirstTime(true);
          await repository.saveServerDetails(hetznerServerDetails);

          emit(
            dataState.copyWith(
              isServerResetedFirstTime: true,
              hetznerServer: hetznerServerDetails,
              isLoading: false,
            ),
          );
          oneMoreReset();
        });
      } else {
        resetServerIfServerIsOkay();
      }
    };
    if (isImmediate) {
      work();
    } else {
      var pauseDuration = Duration(seconds: 60);
      emit(
        TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          duration: pauseDuration,
          isLoading: false,
        ),
      );
      timer = Timer(pauseDuration, work);
    }
  }

  Timer? timer;

  void finishCheckIfServerIsOkay({
    AppConfigNotFinished? state,
    bool isImmediate = false,
  }) async {
    state = state ?? this.state as AppConfigNotFinished;

    var work = () async {
      emit(TimerState(dataState: state!, isLoading: true));

      var isServerWorking = await repository.isHttpServerWorking();

      if (isServerWorking) {
        await repository.saveHasFinalChecked(true);

        emit(state.finish());
      } else {
        finishCheckIfServerIsOkay();
      }
    };
    if (isImmediate) {
      work();
    } else {
      var pauseDuration = Duration(seconds: 60);
      emit(
        TimerState(
          dataState: state,
          timerStart: DateTime.now(),
          duration: pauseDuration,
          isLoading: false,
        ),
      );
      timer = Timer(pauseDuration, work);
    }
  }

  void clearAppConfig() {
    closeTimer();

    repository.clearAppConfig();
    emit(AppConfigEmpty());
  }

  Future<void> serverDelete() async {
    closeTimer();

    if (state.hetznerServer != null) {
      await repository.deleteServer(state.cloudFlareDomain!);
      await getIt<SSHModel>().clear();
    }
    await repository.deleteRecords();
    emit(AppConfigEmpty());
  }

  void setHetznerKey(String hetznerKey) async {
    await repository.saveHetznerKey(hetznerKey);
    emit((state as AppConfigNotFinished).copyWith(hetznerKey: hetznerKey));
  }

  void setCloudflareKey(String cloudFlareKey) async {
    await repository.saveCloudFlareKey(cloudFlareKey);
    emit(
        (state as AppConfigNotFinished).copyWith(cloudFlareKey: cloudFlareKey));
  }

  void setBackblazeKey(String keyId, String applicationKey) async {
    var backblazeCredential = BackblazeCredential(
      keyId: keyId,
      applicationKey: applicationKey,
    );
    await repository.saveBackblazeKey(backblazeCredential);
    emit((state as AppConfigNotFinished)
        .copyWith(backblazeCredential: backblazeCredential));
  }

  void setDomain(CloudFlareDomain cloudFlareDomain) async {
    await repository.saveDomain(cloudFlareDomain);
    emit((state as AppConfigNotFinished)
        .copyWith(cloudFlareDomain: cloudFlareDomain));
  }

  void setRootUser(User rootUser) async {
    await repository.saveRootUser(rootUser);
    emit((state as AppConfigNotFinished).copyWith(rootUser: rootUser));
  }

  void createServerAndSetDnsRecords() async {
    AppConfigNotFinished _stateCopy = state as AppConfigNotFinished;
    var onSuccess = (HetznerServerDetails serverDetails) async {
      await repository.createDnsRecords(
        serverDetails.ip4,
        state.cloudFlareDomain!,
      );

      emit((state as AppConfigNotFinished).copyWith(
        isLoading: false,
        hetznerServer: serverDetails,
      ));
      startServerIfDnsIsOkay();
    };

    var onCancel =
        () => emit((state as AppConfigNotFinished).copyWith(isLoading: false));

    try {
      emit((state as AppConfigNotFinished).copyWith(isLoading: true));
      await repository.createServer(
        state.rootUser!,
        state.cloudFlareDomain!.domainName,
        state.cloudFlareKey!,
        onCancel: onCancel,
        onSuccess: onSuccess,
      );
    } catch (e) {
      emit(_stateCopy);
    }
  }

  close() {
    closeTimer();
    return super.close();
  }

  void closeTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
