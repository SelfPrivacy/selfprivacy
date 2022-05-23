import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';

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

    if (state is ServerInstallationRecovery) {
      emit((state as ServerInstallationRecovery).copyWith(
        hetznerKey: hetznerKey,
        currentStep: RecoveryStep.ServerSelection,
      ));
      return;
    }

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
    if (state is ServerInstallationRecovery) {
      final mainUser = await repository.getMainUser();
      final updatedState = (state as ServerInstallationRecovery).copyWith(
        backblazeCredential: backblazeCredential,
        rootUser: mainUser,
      );
      emit(updatedState.finish());
      return;
    }
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

    await repository.saveDomain(serverDomain);

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
      await repository.saveServerDetails(serverDetails);
      emit(dataState.copyWith(
        serverDetails: serverDetails,
        currentStep: RecoveryStep.HetznerToken,
      ));
    } on ServerAuthorizationException {
      getIt<NavigationService>()
          .showSnackBar('recovering.authorization_failed'.tr());
      return;
    } on IpNotFoundException {
      getIt<NavigationService>()
          .showSnackBar('recovering.domain_recover_error'.tr());
      return;
    }
  }

  void revertRecoveryStep() {
    final dataState = this.state as ServerInstallationRecovery;
    switch (dataState.currentStep) {
      case RecoveryStep.Selecting:
        repository.deleteDomain();
        emit(ServerInstallationEmpty());
        break;
      case RecoveryStep.RecoveryKey:
      case RecoveryStep.NewDeviceKey:
      case RecoveryStep.OldToken:
        emit(dataState.copyWith(
          currentStep: RecoveryStep.Selecting,
        ));
        break;
      case RecoveryStep.ServerSelection:
        repository.deleteHetznerKey();
        emit(dataState.copyWith(
          currentStep: RecoveryStep.HetznerToken,
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

  Future<List<ServerBasicInfoWithValidators>>
      getServersOnHetznerAccount() async {
    final dataState = this.state as ServerInstallationRecovery;
    final servers = await repository.getServersOnHetznerAccount();
    final validated = servers
        .map((server) => ServerBasicInfoWithValidators.fromServerBasicInfo(
              serverBasicInfo: server,
              isIpValid: server.ip == dataState.serverDetails?.ip4,
              isReverseDnsValid:
                  server.reverseDns == dataState.serverDomain?.domainName,
            ));
    return validated.toList();
  }

  Future<void> setServerId(ServerBasicInfo server) async {
    final dataState = this.state as ServerInstallationRecovery;
    final serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    final serverDetails = ServerHostingDetails(
      ip4: server.ip,
      id: server.id,
      createTime: server.created,
      volume: ServerVolume(
        id: server.volumeId,
        name: "recovered_volume",
      ),
      apiToken: dataState.serverDetails!.apiToken,
      provider: ServerProvider.Hetzner,
    );
    await repository.saveDomain(serverDomain);
    await repository.saveServerDetails(serverDetails);
    emit(dataState.copyWith(
      serverDetails: serverDetails,
      currentStep: RecoveryStep.CloudflareToken,
    ));
  }

  Future<void> setAndValidateCloudflareToken(String token) async {
    final dataState = this.state as ServerInstallationRecovery;
    final serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    final zoneId = await repository.getDomainId(token, serverDomain.domainName);
    if (zoneId == null) {
      getIt<NavigationService>()
          .showSnackBar('recovering.domain_not_available_on_token'.tr());
      return;
    }
    emit(dataState.copyWith(
      serverDomain: ServerDomain(
        domainName: serverDomain.domainName,
        zoneId: zoneId,
        provider: DnsProvider.Cloudflare,
      ),
      currentStep: RecoveryStep.BackblazeToken,
    ));
  }

  @override
  void onChange(Change<ServerInstallationState> change) {
    super.onChange(change);
    print('================================');
    print('ServerInstallationState changed!');
    print('Current type: ${change.nextState.runtimeType}');
    print('Hetzner key: ${change.nextState.hetznerKey}');
    print('Cloudflare key: ${change.nextState.cloudFlareKey}');
    print('Domain: ${change.nextState.serverDomain}');
    print('BackblazeCredential: ${change.nextState.backblazeCredential}');
    if (change.nextState is ServerInstallationRecovery) {
      print(
          'Recovery Step: ${(change.nextState as ServerInstallationRecovery).currentStep}');
      print(
          'Recovery Capabilities: ${(change.nextState as ServerInstallationRecovery).recoveryCapabilities}');
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
