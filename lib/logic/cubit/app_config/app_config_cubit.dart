import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/ssh.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import 'app_config_repository.dart';

export 'package:provider/provider.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit() : super(AppConfigEmpty());

  final repository = AppConfigRepository();

  Timer? timer;

  Future<void> load() async {
    var state = await repository.load();

    if (state is AppConfigFinished) {
      emit(state);
    } else if (state is AppConfigNotFinished) {
      if (state.progress == ServerSetupProgress.serverCreated) {
        startServerIfDnsIsOkay(state: state);
      } else if (state.progress == ServerSetupProgress.serverStarted) {
        resetServerIfServerIsOkay(state: state);
      } else if (state.progress == ServerSetupProgress.serverResetedFirstTime) {
        oneMoreReset(state: state);
      } else if (state.progress ==
          ServerSetupProgress.serverResetedSecondTime) {
        finishCheckIfServerIsOkay(state: state);
      } else {
        emit(state);
      }
    } else if (state is AppConfigRecovery) {
      emit(state);
    } else {
      throw 'wrong state';
    }
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

  void setDomain(ServerDomain serverDomain) async {
    await repository.saveDomain(serverDomain);
    emit((state as AppConfigNotFinished).copyWith(serverDomain: serverDomain));
  }

  void setRootUser(User rootUser) async {
    await repository.saveRootUser(rootUser);
    emit((state as AppConfigNotFinished).copyWith(rootUser: rootUser));
  }

  void createServerAndSetDnsRecords() async {
    AppConfigNotFinished _stateCopy = state as AppConfigNotFinished;
    var onSuccess = (ServerHostingDetails serverDetails) async {
      await repository.createDnsRecords(
        serverDetails.ip4,
        state.serverDomain!,
      );

      emit((state as AppConfigNotFinished).copyWith(
        isLoading: false,
        serverDetails: serverDetails,
      ));
      runDelayed(startServerIfDnsIsOkay, Duration(seconds: 30), null);
    };

    var onCancel =
        () => emit((state as AppConfigNotFinished).copyWith(isLoading: false));

    try {
      emit((state as AppConfigNotFinished).copyWith(isLoading: true));
      await repository.createServer(
        state.rootUser!,
        state.serverDomain!.domainName,
        state.cloudFlareKey!,
        state.backblazeCredential!,
        onCancel: onCancel,
        onSuccess: onSuccess,
      );
    } catch (e) {
      emit(_stateCopy);
    }
  }

  void startServerIfDnsIsOkay({AppConfigNotFinished? state}) async {
    final dataState = state ?? this.state as AppConfigNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    var ip4 = dataState.serverDetails!.ip4;
    var domainName = dataState.serverDomain!.domainName;

    var matches = await repository.isDnsAddressesMatch(
        domainName, ip4, dataState.dnsMatches);

    if (matches.values.every((value) => value)) {
      var server = await repository.startServer(
        dataState.serverDetails!,
      );
      await repository.saveServerDetails(server);
      await repository.saveIsServerStarted(true);

      emit(
        dataState.copyWith(
          isServerStarted: true,
          isLoading: false,
          serverDetails: server,
        ),
      );
      runDelayed(resetServerIfServerIsOkay, Duration(seconds: 60), dataState);
    } else {
      emit(
        dataState.copyWith(
          isLoading: false,
          dnsMatches: matches,
        ),
      );
      runDelayed(startServerIfDnsIsOkay, Duration(seconds: 30), dataState);
    }
  }

  void oneMoreReset({AppConfigNotFinished? state}) async {
    final dataState = state ?? this.state as AppConfigNotFinished;

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
            serverDetails: hetznerServerDetails,
            isLoading: false,
          ),
        );
        runDelayed(finishCheckIfServerIsOkay, Duration(seconds: 60), dataState);
      });
    } else {
      runDelayed(oneMoreReset, Duration(seconds: 60), dataState);
    }
  }

  void resetServerIfServerIsOkay({
    AppConfigNotFinished? state,
  }) async {
    final dataState = state ?? this.state as AppConfigNotFinished;

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
            serverDetails: hetznerServerDetails,
            isLoading: false,
          ),
        );
        runDelayed(oneMoreReset, Duration(seconds: 60), dataState);
      });
    } else {
      runDelayed(resetServerIfServerIsOkay, Duration(seconds: 60), dataState);
    }
  }

  void finishCheckIfServerIsOkay({
    AppConfigNotFinished? state,
  }) async {
    final dataState = state ?? this.state as AppConfigNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    var isServerWorking = await repository.isHttpServerWorking();

    if (isServerWorking) {
      await repository.createDkimRecord(dataState.serverDomain!);
      await repository.saveHasFinalChecked(true);

      emit(dataState.finish());
    } else {
      runDelayed(finishCheckIfServerIsOkay, Duration(seconds: 60), dataState);
    }
  }

  void runDelayed(
      void Function() work, Duration delay, AppConfigNotFinished? state) async {
    final dataState = state ?? this.state as AppConfigNotFinished;

    emit(TimerState(
      dataState: dataState,
      timerStart: DateTime.now(),
      duration: delay,
      isLoading: false,
    ));
    timer = Timer(delay, work);
  }

  void clearAppConfig() {
    closeTimer();

    repository.clearAppConfig();
    emit(AppConfigEmpty());
  }

  Future<void> serverDelete() async {
    closeTimer();

    if (state.serverDetails != null) {
      await repository.deleteServer(state.serverDomain!);
      await getIt<SSHModel>().clear();
    }
    await repository.deleteRecords();
    emit(AppConfigNotFinished(
      hetznerKey: state.hetznerKey,
      serverDomain: state.serverDomain,
      cloudFlareKey: state.cloudFlareKey,
      backblazeCredential: state.backblazeCredential,
      rootUser: state.rootUser,
      serverDetails: null,
      isServerStarted: false,
      isServerResetedFirstTime: false,
      isServerResetedSecondTime: false,
      isLoading: false,
      dnsMatches: null,
    ));
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
