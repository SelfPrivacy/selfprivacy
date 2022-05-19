import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../server_installation/server_installation_repository.dart';

export 'package:provider/provider.dart';

part '../server_installation/server_installation_state.dart';

class ServerInstallationCubit extends Cubit<ServerInstallationState> {
  ServerInstallationCubit() : super(ServerInstallationEmpty());

  final repository = ServerInstallationRepository();

  Timer? timer;

  Future<void> load() async {
    var state = await repository.load();

    if (state is ServerInstallationFinished) {
      emit(state);
    } else if (state is ServerInstallationNotFinished) {
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
    } else if (state is ServerInstallationRecovery) {
      emit(state);
    } else {
      throw 'wrong state';
    }
  }

  void setHetznerKey(String hetznerKey) async {
    await repository.saveHetznerKey(hetznerKey);
    emit((state as ServerInstallationNotFinished)
        .copyWith(hetznerKey: hetznerKey));
  }

  void setCloudflareKey(String cloudFlareKey) async {
    await repository.saveCloudFlareKey(cloudFlareKey);
    emit((state as ServerInstallationNotFinished)
        .copyWith(cloudFlareKey: cloudFlareKey));
  }

  void setBackblazeKey(String keyId, String applicationKey) async {
    var backblazeCredential = BackblazeCredential(
      keyId: keyId,
      applicationKey: applicationKey,
    );
    await repository.saveBackblazeKey(backblazeCredential);
    emit((state as ServerInstallationNotFinished)
        .copyWith(backblazeCredential: backblazeCredential));
  }

  void setDomain(ServerDomain serverDomain) async {
    await repository.saveDomain(serverDomain);
    emit((state as ServerInstallationNotFinished)
        .copyWith(serverDomain: serverDomain));
  }

  void setRootUser(User rootUser) async {
    await repository.saveRootUser(rootUser);
    emit((state as ServerInstallationNotFinished).copyWith(rootUser: rootUser));
  }

  void createServerAndSetDnsRecords() async {
    ServerInstallationNotFinished _stateCopy =
        state as ServerInstallationNotFinished;
    var onCancel = () => emit(
        (state as ServerInstallationNotFinished).copyWith(isLoading: false));

    var onSuccess = (ServerHostingDetails serverDetails) async {
      await repository.createDnsRecords(
        serverDetails.ip4,
        state.serverDomain!,
        onCancel: onCancel,
      );

      emit((state as ServerInstallationNotFinished).copyWith(
        isLoading: false,
        serverDetails: serverDetails,
      ));
      runDelayed(startServerIfDnsIsOkay, Duration(seconds: 30), null);
    };

    try {
      emit((state as ServerInstallationNotFinished).copyWith(isLoading: true));
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

  void startServerIfDnsIsOkay({ServerInstallationNotFinished? state}) async {
    final dataState = state ?? this.state as ServerInstallationNotFinished;

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

  void oneMoreReset({ServerInstallationNotFinished? state}) async {
    final dataState = state ?? this.state as ServerInstallationNotFinished;

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
    ServerInstallationNotFinished? state,
  }) async {
    final dataState = state ?? this.state as ServerInstallationNotFinished;

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
    ServerInstallationNotFinished? state,
  }) async {
    final dataState = state ?? this.state as ServerInstallationNotFinished;

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

  void runDelayed(void Function() work, Duration delay,
      ServerInstallationNotFinished? state) async {
    final dataState = state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(
      dataState: dataState,
      timerStart: DateTime.now(),
      duration: delay,
      isLoading: false,
    ));
    timer = Timer(delay, work);
  }

  void submitDomainForAccessRecovery(String domain) async {
    var serverDomain = ServerDomain(
      domainName: domain,
      provider: DnsProvider.Unknown,
      zoneId: '',
    );
    final recoveryCapabilities =
        await repository.getRecoveryCapabilities(serverDomain);

    emit(ServerInstallationRecovery(
      serverDomain: serverDomain,
      recoveryCapabilities: recoveryCapabilities,
      currentStep: RecoveryStep.Selecting,
    ));
  }

  void tryToRecover(String token, ServerRecoveryMethods method) async {
    final dataState = this.state as ServerInstallationRecovery;
    final serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    try {
      Future<ServerHostingDetails> Function(ServerDomain, String)
          recoveryFunction;
      switch (method) {
        case ServerRecoveryMethods.newDeviceKey:
          recoveryFunction = repository.authorizeByNewDeviceKey;
          break;
        case ServerRecoveryMethods.recoveryKey:
          recoveryFunction = repository.authorizeByRecoveryKey;
          break;
        case ServerRecoveryMethods.oldToken:
          recoveryFunction = repository.authorizeByApiToken;
          break;
        default:
          throw Exception('Unknown recovery method');
      }
      final serverDetails = await recoveryFunction(
        serverDomain,
        token,
      );
      emit(dataState.copyWith(
        serverDetails: serverDetails,
        currentStep: RecoveryStep.HetznerToken,
      ));
    } on ServerAuthorizationException {
      return;
    } on IpNotFoundException {
      return;
    }
  }

  void revertRecoveryStep() {
    final dataState = this.state as ServerInstallationRecovery;
    switch (dataState.currentStep) {
      case RecoveryStep.Selecting:
        emit(ServerInstallationEmpty());
        break;
      case RecoveryStep.RecoveryKey:
      case RecoveryStep.NewDeviceKey:
      case RecoveryStep.OldToken:
        emit(dataState.copyWith(
          currentStep: RecoveryStep.Selecting,
        ));
        break;
      // We won't revert steps after client is authorized
      default:
        break;
    }
  }

  void selectRecoveryMethod(ServerRecoveryMethods method) {
    final dataState = this.state as ServerInstallationRecovery;
    switch (method) {
      case ServerRecoveryMethods.newDeviceKey:
        emit(dataState.copyWith(
          currentStep: RecoveryStep.NewDeviceKey,
        ));
        break;
      case ServerRecoveryMethods.recoveryKey:
        emit(dataState.copyWith(
          currentStep: RecoveryStep.RecoveryKey,
        ));
        break;
      case ServerRecoveryMethods.oldToken:
        emit(dataState.copyWith(
          currentStep: RecoveryStep.OldToken,
        ));
        break;
    }
  }

  void clearAppConfig() {
    closeTimer();

    repository.clearAppConfig();
    emit(ServerInstallationEmpty());
  }

  Future<void> serverDelete() async {
    closeTimer();

    if (state.serverDetails != null) {
      await repository.deleteServer(state.serverDomain!);
    }
    await repository.deleteRecords();
    emit(ServerInstallationNotFinished(
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
