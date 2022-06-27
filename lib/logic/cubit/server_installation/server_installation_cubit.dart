import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';

import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';

export 'package:provider/provider.dart';

part '../server_installation/server_installation_state.dart';

class ServerInstallationCubit extends Cubit<ServerInstallationState> {
  ServerInstallationCubit() : super(const ServerInstallationEmpty());

  final ServerInstallationRepository repository =
      ServerInstallationRepository();

  Timer? timer;

  Future<void> load() async {
    final ServerInstallationState state = await repository.load();

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

  void setHetznerKey(final String hetznerKey) async {
    await repository.saveHetznerKey(hetznerKey);

    if (state is ServerInstallationRecovery) {
      emit(
        (state as ServerInstallationRecovery).copyWith(
          hetznerKey: hetznerKey,
          currentStep: RecoveryStep.serverSelection,
        ),
      );
      return;
    }

    emit(
      (state as ServerInstallationNotFinished).copyWith(hetznerKey: hetznerKey),
    );
  }

  void setCloudflareKey(final String cloudFlareKey) async {
    if (state is ServerInstallationRecovery) {
      setAndValidateCloudflareToken(cloudFlareKey);
      return;
    }
    await repository.saveCloudFlareKey(cloudFlareKey);
    emit(
      (state as ServerInstallationNotFinished)
          .copyWith(cloudFlareKey: cloudFlareKey),
    );
  }

  void setBackblazeKey(final String keyId, final String applicationKey) async {
    final BackblazeCredential backblazeCredential = BackblazeCredential(
      keyId: keyId,
      applicationKey: applicationKey,
    );
    await repository.saveBackblazeKey(backblazeCredential);
    if (state is ServerInstallationRecovery) {
      finishRecoveryProcess(backblazeCredential);
      return;
    }
    emit(
      (state as ServerInstallationNotFinished)
          .copyWith(backblazeCredential: backblazeCredential),
    );
  }

  void setDomain(final ServerDomain serverDomain) async {
    await repository.saveDomain(serverDomain);
    emit(
      (state as ServerInstallationNotFinished)
          .copyWith(serverDomain: serverDomain),
    );
  }

  void setRootUser(final User rootUser) async {
    await repository.saveRootUser(rootUser);
    emit((state as ServerInstallationNotFinished).copyWith(rootUser: rootUser));
  }

  void createServerAndSetDnsRecords() async {
    final ServerInstallationNotFinished stateCopy =
        state as ServerInstallationNotFinished;
    void onCancel() => emit(
          (state as ServerInstallationNotFinished).copyWith(isLoading: false),
        );

    Future<void> onSuccess(final ServerHostingDetails serverDetails) async {
      await repository.createDnsRecords(
        serverDetails.ip4,
        state.serverDomain!,
        onCancel: onCancel,
      );

      emit(
        (state as ServerInstallationNotFinished).copyWith(
          isLoading: false,
          serverDetails: serverDetails,
        ),
      );
      runDelayed(startServerIfDnsIsOkay, const Duration(seconds: 30), null);
    }

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
      emit(stateCopy);
    }
  }

  void startServerIfDnsIsOkay({
    final ServerInstallationNotFinished? state,
  }) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    final String ip4 = dataState.serverDetails!.ip4;
    final String domainName = dataState.serverDomain!.domainName;

    final Map<String, bool> matches = await repository.isDnsAddressesMatch(
      domainName,
      ip4,
      dataState.dnsMatches ?? {},
    );

    if (matches.values.every((final bool value) => value)) {
      final ServerHostingDetails server = await repository.startServer(
        dataState.serverDetails!,
      );
      await repository.saveServerDetails(server);
      await repository.saveIsServerStarted(true);

      final ServerInstallationNotFinished newState = dataState.copyWith(
        isServerStarted: true,
        isLoading: false,
        serverDetails: server,
      );
      emit(newState);
      runDelayed(
        resetServerIfServerIsOkay,
        const Duration(seconds: 60),
        newState,
      );
    } else {
      final ServerInstallationNotFinished newState = dataState.copyWith(
        isLoading: false,
        dnsMatches: matches,
      );
      emit(newState);
      runDelayed(
        startServerIfDnsIsOkay,
        const Duration(seconds: 30),
        newState,
      );
    }
  }

  void resetServerIfServerIsOkay({
    final ServerInstallationNotFinished? state,
  }) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    final bool isServerWorking = await repository.isHttpServerWorking();

    if (isServerWorking) {
      const Duration pauseDuration = Duration(seconds: 30);
      emit(
        TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          isLoading: false,
          duration: pauseDuration,
        ),
      );
      timer = Timer(pauseDuration, () async {
        final ServerHostingDetails hetznerServerDetails =
            await repository.restart();
        await repository.saveIsServerResetedFirstTime(true);
        await repository.saveServerDetails(hetznerServerDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedFirstTime: true,
          serverDetails: hetznerServerDetails,
          isLoading: false,
        );

        emit(newState);
        runDelayed(oneMoreReset, const Duration(seconds: 60), newState);
      });
    } else {
      runDelayed(
        resetServerIfServerIsOkay,
        const Duration(seconds: 60),
        dataState,
      );
    }
  }

  void oneMoreReset({final ServerInstallationNotFinished? state}) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    final bool isServerWorking = await repository.isHttpServerWorking();

    if (isServerWorking) {
      const Duration pauseDuration = Duration(seconds: 30);
      emit(
        TimerState(
          dataState: dataState,
          timerStart: DateTime.now(),
          isLoading: false,
          duration: pauseDuration,
        ),
      );
      timer = Timer(pauseDuration, () async {
        final ServerHostingDetails hetznerServerDetails =
            await repository.restart();
        await repository.saveIsServerResetedSecondTime(true);
        await repository.saveServerDetails(hetznerServerDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedSecondTime: true,
          serverDetails: hetznerServerDetails,
          isLoading: false,
        );

        emit(newState);
        runDelayed(
          finishCheckIfServerIsOkay,
          const Duration(seconds: 60),
          newState,
        );
      });
    } else {
      runDelayed(oneMoreReset, const Duration(seconds: 60), dataState);
    }
  }

  void finishCheckIfServerIsOkay({
    final ServerInstallationNotFinished? state,
  }) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    final bool isServerWorking = await repository.isHttpServerWorking();

    if (isServerWorking) {
      await repository.createDkimRecord(dataState.serverDomain!);
      await repository.saveHasFinalChecked(true);

      emit(dataState.finish());
    } else {
      runDelayed(
        finishCheckIfServerIsOkay,
        const Duration(seconds: 60),
        dataState,
      );
    }
  }

  void runDelayed(
    final void Function() work,
    final Duration delay,
    final ServerInstallationNotFinished? state,
  ) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(
      TimerState(
        dataState: dataState,
        timerStart: DateTime.now(),
        duration: delay,
        isLoading: false,
      ),
    );
    timer = Timer(delay, work);
  }

  void submitDomainForAccessRecovery(final String domain) async {
    final ServerDomain serverDomain = ServerDomain(
      domainName: domain,
      provider: DnsProvider.unknown,
      zoneId: '',
    );
    final ServerRecoveryCapabilities recoveryCapabilities =
        await repository.getRecoveryCapabilities(serverDomain);

    await repository.saveDomain(serverDomain);
    await repository.saveIsRecoveringServer(true);

    emit(
      ServerInstallationRecovery(
        serverDomain: serverDomain,
        recoveryCapabilities: recoveryCapabilities,
        currentStep: RecoveryStep.selecting,
      ),
    );
  }

  void tryToRecover(
    final String token,
    final ServerRecoveryMethods method,
  ) async {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    final ServerDomain? serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    try {
      Future<ServerHostingDetails> Function(
        ServerDomain,
        String,
        ServerRecoveryCapabilities,
      ) recoveryFunction;
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
      final ServerHostingDetails serverDetails = await recoveryFunction(
        serverDomain,
        token,
        dataState.recoveryCapabilities,
      );
      await repository.saveServerDetails(serverDetails);
      emit(
        dataState.copyWith(
          serverDetails: serverDetails,
          currentStep: RecoveryStep.hetznerToken,
        ),
      );
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
    if (state is ServerInstallationEmpty) {
      return;
    }
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    switch (dataState.currentStep) {
      case RecoveryStep.selecting:
        repository.deleteDomain();
        emit(const ServerInstallationEmpty());
        break;
      case RecoveryStep.recoveryKey:
      case RecoveryStep.newDeviceKey:
      case RecoveryStep.oldToken:
        emit(
          dataState.copyWith(
            currentStep: RecoveryStep.selecting,
          ),
        );
        break;
      case RecoveryStep.cloudflareToken:
        repository.deleteServerDetails();
        emit(
          dataState.copyWith(
            currentStep: RecoveryStep.serverSelection,
          ),
        );
        break;
      // We won't revert steps after client is authorized
      default:
        break;
    }
  }

  void selectRecoveryMethod(final ServerRecoveryMethods method) {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    switch (method) {
      case ServerRecoveryMethods.newDeviceKey:
        emit(
          dataState.copyWith(
            currentStep: RecoveryStep.newDeviceKey,
          ),
        );
        break;
      case ServerRecoveryMethods.recoveryKey:
        emit(
          dataState.copyWith(
            currentStep: RecoveryStep.recoveryKey,
          ),
        );
        break;
      case ServerRecoveryMethods.oldToken:
        emit(
          dataState.copyWith(
            currentStep: RecoveryStep.oldToken,
          ),
        );
        break;
    }
  }

  Future<List<ServerBasicInfoWithValidators>>
      getServersOnHetznerAccount() async {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    final List<ServerBasicInfo> servers =
        await repository.getServersOnHetznerAccount();
    final Iterable<ServerBasicInfoWithValidators> validated = servers.map(
      (final ServerBasicInfo server) =>
          ServerBasicInfoWithValidators.fromServerBasicInfo(
        serverBasicInfo: server,
        isIpValid: server.ip == dataState.serverDetails?.ip4,
        isReverseDnsValid:
            server.reverseDns == dataState.serverDomain?.domainName,
      ),
    );
    return validated.toList();
  }

  Future<void> setServerId(final ServerBasicInfo server) async {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    final ServerDomain? serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    final ServerHostingDetails serverDetails = ServerHostingDetails(
      ip4: server.ip,
      id: server.id,
      createTime: server.created,
      volume: ServerVolume(
        id: server.volumeId,
        name: 'recovered_volume',
        sizeGb: 10, // ?????
        serverId: server.id,
      ),
      apiToken: dataState.serverDetails!.apiToken,
      provider: ServerProvider.hetzner,
    );
    await repository.saveDomain(serverDomain);
    await repository.saveServerDetails(serverDetails);
    emit(
      dataState.copyWith(
        serverDetails: serverDetails,
        currentStep: RecoveryStep.cloudflareToken,
      ),
    );
  }

  Future<void> setAndValidateCloudflareToken(final String token) async {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    final ServerDomain? serverDomain = dataState.serverDomain;
    if (serverDomain == null) {
      return;
    }
    final String? zoneId =
        await repository.getDomainId(token, serverDomain.domainName);
    if (zoneId == null) {
      getIt<NavigationService>()
          .showSnackBar('recovering.domain_not_available_on_token'.tr());
      return;
    }
    await repository.saveDomain(
      ServerDomain(
        domainName: serverDomain.domainName,
        zoneId: zoneId,
        provider: DnsProvider.cloudflare,
      ),
    );
    await repository.saveCloudFlareKey(token);
    emit(
      dataState.copyWith(
        serverDomain: ServerDomain(
          domainName: serverDomain.domainName,
          zoneId: zoneId,
          provider: DnsProvider.cloudflare,
        ),
        cloudFlareKey: token,
        currentStep: RecoveryStep.backblazeToken,
      ),
    );
  }

  void finishRecoveryProcess(
    final BackblazeCredential backblazeCredential,
  ) async {
    await repository.saveIsServerStarted(true);
    await repository.saveIsServerResetedFirstTime(true);
    await repository.saveIsServerResetedSecondTime(true);
    await repository.saveHasFinalChecked(true);
    await repository.saveIsRecoveringServer(false);
    final User mainUser = await repository.getMainUser();
    await repository.saveRootUser(mainUser);
    final ServerInstallationRecovery updatedState =
        (state as ServerInstallationRecovery).copyWith(
      backblazeCredential: backblazeCredential,
      rootUser: mainUser,
    );
    emit(updatedState.finish());
  }

  @override
  void onChange(final Change<ServerInstallationState> change) {
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
        'Recovery Step: ${(change.nextState as ServerInstallationRecovery).currentStep}',
      );
      print(
        'Recovery Capabilities: ${(change.nextState as ServerInstallationRecovery).recoveryCapabilities}',
      );
    }
    if (change.nextState is TimerState) {
      print('Timer: ${(change.nextState as TimerState).duration}');
    }
  }

  void clearAppConfig() {
    closeTimer();

    repository.clearAppConfig();
    emit(const ServerInstallationEmpty());
  }

  Future<void> serverDelete() async {
    closeTimer();

    if (state.serverDetails != null) {
      await repository.deleteServer(state.serverDomain!);
    }
    await repository.deleteServerRelatedRecords();
    emit(
      ServerInstallationNotFinished(
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
      ),
    );
  }

  @override
  Future<void> close() {
    closeTimer();
    return super.close();
  }

  void closeTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
