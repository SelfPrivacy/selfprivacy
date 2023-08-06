import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

export 'package:provider/provider.dart';

part '../server_installation/server_installation_state.dart';

class ServerInstallationCubit extends Cubit<ServerInstallationState> {
  ServerInstallationCubit() : super(const ServerInstallationEmpty());

  final ServerInstallationRepository repository =
      ServerInstallationRepository();

  Timer? timer;

  final DiskSize initialStorage = DiskSize.fromGibibyte(10);

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

  void setServerProviderType(final ServerProviderType providerType) async {
    await repository.saveServerProviderType(providerType);
    ProvidersController.initServerProvider(
      ServerProviderSettings(provider: providerType),
    );
  }

  void setDnsProviderType(final DnsProviderType providerType) async {
    await repository.saveDnsProviderType(providerType);
    ProvidersController.initDnsProvider(
      DnsProviderSettings(
        provider: providerType,
      ),
    );
  }

  Future<bool?> isServerProviderApiTokenValid(
    final String providerToken,
  ) async {
    final GenericResult<bool> apiResponse =
        await ProvidersController.currentServerProvider!.tryInitApiByToken(
      providerToken,
    );

    if (!apiResponse.success) {
      getIt<NavigationService>().showSnackBar(
        'initializing.could_not_connect'.tr(),
      );
      return null;
    }

    return apiResponse.data;
  }

  Future<bool?> isDnsProviderApiTokenValid(
    final String providerToken,
  ) async {
    final GenericResult<bool> apiResponse =
        await ProvidersController.currentDnsProvider!.tryInitApiByToken(
      providerToken,
    );

    if (!apiResponse.success) {
      getIt<NavigationService>().showSnackBar(
        'initializing.could_not_connect'.tr(),
      );
      return null;
    }

    return apiResponse.data;
  }

  Future<List<ServerProviderLocation>> fetchAvailableLocations() async {
    if (ProvidersController.currentServerProvider == null) {
      return [];
    }

    final GenericResult apiResponse = await ProvidersController
        .currentServerProvider!
        .getAvailableLocations();

    if (!apiResponse.success) {
      getIt<NavigationService>().showSnackBar(
        'initializing.could_not_connect'.tr(),
      );
    }

    return apiResponse.data;
  }

  Future<List<ServerType>> fetchAvailableTypesByLocation(
    final ServerProviderLocation location,
  ) async {
    if (ProvidersController.currentServerProvider == null) {
      return [];
    }

    final GenericResult apiResult = await ProvidersController
        .currentServerProvider!
        .getServerTypes(location: location);

    if (!apiResult.success) {
      getIt<NavigationService>().showSnackBar(
        'initializing.could_not_connect'.tr(),
      );
    }

    return apiResult.data;
  }

  void setServerProviderKey(final String serverProviderKey) async {
    await repository.saveServerProviderKey(serverProviderKey);

    if (state is ServerInstallationRecovery) {
      emit(
        (state as ServerInstallationRecovery).copyWith(
          providerApiToken: serverProviderKey,
          currentStep: RecoveryStep.serverSelection,
        ),
      );
      return;
    }

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        providerApiToken: serverProviderKey,
      ),
    );
  }

  void setServerType(final ServerType serverType) async {
    await repository.saveServerType(serverType);

    await ProvidersController.currentServerProvider!
        .trySetServerLocation(serverType.location.identifier);

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        serverTypeIdentificator: serverType.identifier,
      ),
    );
  }

  void setDnsApiToken(final String dnsApiToken) async {
    if (state is ServerInstallationRecovery) {
      await setAndValidateDnsApiToken(dnsApiToken);
      return;
    }
    await repository.setDnsApiToken(dnsApiToken);

    emit(
      (state as ServerInstallationNotFinished)
          .copyWith(dnsApiToken: dnsApiToken),
    );
  }

  void setBackblazeKey(final String keyId, final String applicationKey) async {
    final BackupsCredential backblazeCredential = BackupsCredential(
      keyId: keyId,
      applicationKey: applicationKey,
      provider: BackupsProviderType.backblaze,
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

  Future<void> onCreateServerSuccess(
    final ServerHostingDetails serverDetails,
  ) async {
    await repository.saveServerDetails(serverDetails);
    await ProvidersController.currentDnsProvider!.removeDomainRecords(
      ip4: serverDetails.ip4,
      domain: state.serverDomain!,
    );
    await ProvidersController.currentDnsProvider!.createDomainRecords(
      ip4: serverDetails.ip4,
      domain: state.serverDomain!,
    );

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        isLoading: false,
        serverDetails: serverDetails,
        installationDialoguePopUp: null,
      ),
    );
    runDelayed(startServerIfDnsIsOkay, const Duration(seconds: 30), null);
  }

  void createServerAndSetDnsRecords() async {
    emit((state as ServerInstallationNotFinished).copyWith(isLoading: true));

    final installationData = LaunchInstallationData(
      rootUser: state.rootUser!,
      dnsApiToken: state.dnsApiToken!,
      dnsProviderType: state.serverDomain!.provider,
      serverDomain: state.serverDomain!,
      serverTypeId: state.serverTypeIdentificator!,
      errorCallback: clearAppConfig,
      successCallback: onCreateServerSuccess,
      storageSize: initialStorage,
    );

    final result =
        await ProvidersController.currentServerProvider!.launchInstallation(
      installationData,
    );

    if (!result.success && result.data != null) {
      emit(
        (state as ServerInstallationNotFinished).copyWith(
          installationDialoguePopUp: result.data,
        ),
      );
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
        final ServerHostingDetails serverDetails = await repository.restart();
        await repository.saveIsServerResetedFirstTime(true);
        await repository.saveServerDetails(serverDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedFirstTime: true,
          serverDetails: serverDetails,
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
        final ServerHostingDetails serverDetails = await repository.restart();
        await repository.saveIsServerResetedSecondTime(true);
        await repository.saveServerDetails(serverDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedSecondTime: true,
          serverDetails: serverDetails,
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
    TlsOptions.verifyCertificate = true;

    if (isServerWorking) {
      bool dkimCreated = true;
      try {
        await repository.createDkimRecord(dataState.serverDomain!);
      } catch (e) {
        dkimCreated = false;
      }
      if (dkimCreated) {
        await repository.saveHasFinalChecked(true);
        emit(dataState.finish());
      } else {
        runDelayed(
          finishCheckIfServerIsOkay,
          const Duration(seconds: 60),
          dataState,
        );
      }
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
      provider: DnsProviderType.unknown,
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
      final ServerProviderType serverProvider = await ServerApi(
        customToken: serverDetails.apiToken,
        isWithToken: true,
      ).getServerProviderType();
      final dnsProvider = await ServerApi(
        customToken: serverDetails.apiToken,
        isWithToken: true,
      ).getDnsProviderType();
      if (serverProvider == ServerProviderType.unknown ||
          dnsProvider == DnsProviderType.unknown) {
        getIt<NavigationService>()
            .showSnackBar('recovering.generic_error'.tr());
        return;
      }
      await repository.saveServerDetails(serverDetails);
      await repository.saveDnsProviderType(dnsProvider);
      setServerProviderType(serverProvider);
      setDnsProviderType(dnsProvider);
      emit(
        dataState.copyWith(
          serverDetails: serverDetails,
          currentStep: RecoveryStep.serverProviderToken,
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
      case RecoveryStep.dnsProviderToken:
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

  Future<List<ServerBasicInfoWithValidators>> getAvailableServers() async {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    final List<ServerBasicInfo> servers =
        await repository.getServersOnProviderAccount();
    List<ServerBasicInfoWithValidators> validatedList = [];
    try {
      final Iterable<ServerBasicInfoWithValidators> validated = servers.map(
        (final ServerBasicInfo server) =>
            ServerBasicInfoWithValidators.fromServerBasicInfo(
          serverBasicInfo: server,
          isIpValid: server.ip == dataState.serverDetails?.ip4,
          isReverseDnsValid:
              server.reverseDns == dataState.serverDomain?.domainName ||
                  server.reverseDns ==
                      dataState.serverDomain?.domainName.split('.')[0],
        ),
      );
      validatedList = validated.toList();
    } catch (e) {
      print(e);
      getIt<NavigationService>()
          .showSnackBar('modals.server_validators_error'.tr());
    }

    return validatedList;
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
        id: 0,
        name: 'recovered_volume',
        sizeByte: 0,
        serverId: server.id,
        linuxDevice: '',
      ),
      apiToken: dataState.serverDetails!.apiToken,
      provider: ServerProviderType.hetzner,
    );
    await repository.saveDomain(serverDomain);
    await repository.saveServerDetails(serverDetails);
    emit(
      dataState.copyWith(
        serverDetails: serverDetails,
        currentStep: RecoveryStep.dnsProviderToken,
      ),
    );
  }

  Future<void> setAndValidateDnsApiToken(final String token) async {
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
    final dnsProviderType = await ServerApi(
      customToken: dataState.serverDetails!.apiToken,
      isWithToken: true,
    ).getDnsProviderType();
    await repository.saveDomain(
      ServerDomain(
        domainName: serverDomain.domainName,
        zoneId: zoneId,
        provider: dnsProviderType,
      ),
    );
    // await repository.setDnsApiToken(token);
    emit(
      dataState.copyWith(
        serverDomain: ServerDomain(
          domainName: serverDomain.domainName,
          zoneId: zoneId,
          provider: dnsProviderType,
        ),
        dnsApiToken: token,
        currentStep: RecoveryStep.backblazeToken,
      ),
    );
  }

  void finishRecoveryProcess(
    final BackupsCredential backblazeCredential,
  ) async {
    await repository.saveIsServerStarted(true);
    await repository.saveIsServerResetedFirstTime(true);
    await repository.saveIsServerResetedSecondTime(true);
    await repository.saveHasFinalChecked(true);
    await repository.saveIsRecoveringServer(false);
    final serverType = await ProvidersController.currentServerProvider!
        .getServerType(state.serverDetails!.id);
    await repository.saveServerType(serverType.data!);
    await ProvidersController.currentServerProvider!
        .trySetServerLocation(serverType.data!.location.identifier);
    final User mainUser = await repository.getMainUser();
    await repository.saveRootUser(mainUser);
    final ServerInstallationRecovery updatedState =
        (state as ServerInstallationRecovery).copyWith(
      backblazeCredential: backblazeCredential,
      rootUser: mainUser,
      serverTypeIdentificator: serverType.data!.identifier,
    );
    emit(updatedState.finish());
  }

  @override
  void onChange(final Change<ServerInstallationState> change) {
    if (change.nextState.installationDialoguePopUp != null &&
        change.currentState.installationDialoguePopUp !=
            change.nextState.installationDialoguePopUp) {
      final branching = change.nextState.installationDialoguePopUp;
      showPopUpAlert(
        alertTitle: branching!.title,
        description: branching.description,
        actionButtonTitle: branching.choices[1].title,
        actionButtonOnPressed: () async {
          final branchingResult = await branching.choices[1].callback!();
          if (!branchingResult.success) {
            emit(
              (state as ServerInstallationNotFinished).copyWith(
                installationDialoguePopUp: branchingResult.data,
              ),
            );
          }
        },
        cancelButtonTitle: branching.choices[0].title,
        cancelButtonOnPressed: () async {
          final branchingResult = await branching.choices[0].callback!();
          if (!branchingResult.success) {
            emit(
              (state as ServerInstallationNotFinished).copyWith(
                installationDialoguePopUp: branchingResult.data,
              ),
            );
          }
        },
      );
    }
    super.onChange(change);
  }

  void clearAppConfig() {
    closeTimer();
    ProvidersController.clearProviders();
    TlsOptions.verifyCertificate = false;
    repository.clearAppConfig();
    emit(const ServerInstallationEmpty());
  }

  Future<void> serverDelete() async {
    closeTimer();

    if (state.serverDetails != null) {
      final bool deletionResult =
          await repository.deleteServer(state.serverDomain!);
      if (!deletionResult) {
        return;
      }
    }
    await repository.deleteServerRelatedRecords();
    emit(
      ServerInstallationNotFinished(
        providerApiToken: state.providerApiToken,
        serverDomain: state.serverDomain,
        dnsApiToken: state.dnsApiToken,
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
