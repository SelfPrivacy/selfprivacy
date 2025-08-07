import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/hive/wizards_data/server_installation_wizard_data.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/network_utils.dart';

export 'package:provider/provider.dart';

part '../server_installation/server_installation_state.dart';

class ServerInstallationCubit extends Cubit<ServerInstallationState> {
  ServerInstallationCubit() : super(const ServerInstallationEmpty());

  final ServerInstallationRepository repository =
      ServerInstallationRepository();

  Timer? timer;

  final DiskSize initialStorage = DiskSize.fromGibibyte(10);

  static final logger = const AppLogger(name: 'server_installation_cubit').log;

  Future<void> load() async {
    final ServerInstallationState state = await repository.load();

    if (state is ServerInstallationFinished) {
      emit(state);
    } else if (state is ServerInstallationNotFinished) {
      if (state.progress == ServerSetupProgress.serverCreated) {
        await startServerIfDnsIsOkay(state: state);
      } else if (state.progress == ServerSetupProgress.serverStarted) {
        await resetServerIfServerIsOkay(state: state);
      } else if (state.progress == ServerSetupProgress.serverResetedFirstTime) {
        await oneMoreReset(state: state);
      } else if (state.progress ==
          ServerSetupProgress.serverResetedSecondTime) {
        await finishCheckIfServerIsOkay(state: state);
      } else {
        emit(state);
      }
    } else if (state is ServerInstallationRecovery) {
      emit(state);
    } else {
      throw StateError('wrong state');
    }
  }

  Future<void> setServerProviderType(
    final ServerProviderType providerType,
  ) async {
    await repository.saveServerProviderType(providerType);
    ProvidersController.initServerProvider(
      ServerProviderSettings(provider: providerType),
    );
  }

  Future<void> setDnsProviderType(final DnsProviderType providerType) async {
    await repository.saveDnsProviderType(providerType);
    ProvidersController.initDnsProvider(
      DnsProviderSettings(provider: providerType),
    );
  }

  Future<bool?> isServerProviderApiTokenValid(
    final String providerToken,
  ) async {
    final GenericResult<bool> apiResponse = await ProvidersController
        .currentServerProvider!
        .tryInitApiByToken(providerToken);

    if (!apiResponse.success) {
      getIt<NavigationService>().showSnackBar(
        apiResponse.message ?? 'initializing.could_not_connect'.tr(),
      );
      return null;
    }

    if (!apiResponse.data) {
      getIt<NavigationService>().showSnackBar(
        (apiResponse.message ?? 'initializing.provider_bad_key_error').tr(),
      );
    }

    return apiResponse.data;
  }

  Future<bool?> isDnsProviderApiTokenValid(final String providerToken) async {
    final GenericResult<bool> apiResponse = await ProvidersController
        .currentDnsProvider!
        .tryInitApiByToken(providerToken);

    if (!apiResponse.success) {
      getIt<NavigationService>().showSnackBar(
        apiResponse.message ?? 'initializing.could_not_connect'.tr(),
      );
      return null;
    }

    if (!apiResponse.data) {
      getIt<NavigationService>().showSnackBar(
        (apiResponse.message ?? 'initializing.provider_bad_key_error').tr(),
      );
    }

    return apiResponse.data;
  }

  Future<List<ServerProviderLocation>> fetchAvailableLocations() async {
    if (ProvidersController.currentServerProvider == null) {
      return [];
    }

    final GenericResult apiResponse =
        await ProvidersController.currentServerProvider!
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

  Future<AdditionalPricing?> fetchAvailableAdditionalPricing(
    final ServerProviderLocation location,
  ) async {
    AdditionalPricing? prices;
    final pricingResult = await ProvidersController.currentServerProvider!
        .getAdditionalPricing(location.identifier);
    if (pricingResult.data == null || !pricingResult.success) {
      getIt<NavigationService>().showSnackBar('server.pricing_error'.tr());
      return prices;
    }

    return pricingResult.data;
  }

  Future<void> setServerProviderKey(final String serverProviderKey) async {
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

  Future<void> setLocationIdentifier(final String locationId) async {
    emit(
      (state as ServerInstallationNotFinished).copyWith(
        serverLocation: locationId,
      ),
    );
  }

  Future<void> setServerType(final ServerType serverType) async {
    await repository.saveServerType(serverType);

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        serverTypeIdentificator: serverType.identifier,
        serverLocation: serverType.location.identifier,
      ),
    );
  }

  Future<void> setDnsApiToken(final String dnsApiToken) async {
    if (state is ServerInstallationRecovery) {
      await setAndValidateDnsApiToken(dnsApiToken);
      return;
    }
    await repository.setDnsApiToken(dnsApiToken);

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        dnsApiToken: dnsApiToken,
      ),
    );
  }

  Future<void> setBackblazeKey(
    final String keyId,
    final String applicationKey,
  ) async {
    final BackupsCredential backblazeCredential = BackupsCredential(
      keyId: keyId,
      applicationKey: applicationKey,
      provider: BackupsProviderType.backblaze,
    );
    final BackblazeBucket? bucket;
    await repository.saveBackupsCredential(backblazeCredential);
    if (state is ServerInstallationRecovery) {
      final configuration =
          await ServerApi(
            customToken:
                (state as ServerInstallationRecovery).serverDetails!.apiToken,
            isWithToken: true,
            overrideDomain:
                (state as ServerInstallationRecovery).serverDomain!.domainName,
          ).getBackupsConfiguration();
      if (configuration != null) {
        try {
          final settings = BackupsProviderSettings(
            provider: BackupsProviderType.backblaze,
            tokenId: keyId,
            token: applicationKey,
            isAuthorized: true,
          );
          final provider =
              BackupsProviderFactory.createBackupsProviderInterface(settings);
          final result = await provider.getStorage(
            backblazeCredential,
            configuration,
          );
          bucket = result.data;
          await getIt<ApiConfigModel>().setBackblazeBucket(bucket!);
        } catch (e) {
          logger("Couldn't set backblaze key", error: e);
        }
      }
      await finishRecoveryProcess(backblazeCredential);
      return;
    }
    emit(
      (state as ServerInstallationNotFinished).copyWith(
        backblazeCredential: backblazeCredential,
      ),
    );
  }

  Future<void> setDomain(final ServerDomain serverDomain) async {
    await repository.saveDomain(serverDomain);
    emit(
      (state as ServerInstallationNotFinished).copyWith(
        serverDomain: serverDomain,
      ),
    );
  }

  Future<void> setRootUser(final User rootUser) async {
    await repository.saveRootUser(rootUser);
    emit((state as ServerInstallationNotFinished).copyWith(rootUser: rootUser));
  }

  Future<void> onCreateServerSuccess(
    final ServerHostingDetails serverDetails,
  ) async {
    await repository.saveServerDetails(serverDetails);

    // TODO(NaiJi): Error handling?
    await ProvidersController.currentDnsProvider!.removeDomainRecords(
      records: getProjectDnsRecords(
        domainName: state.serverDomain!.domainName,
        ip4: serverDetails.ip4,
        isCreating: false,
      ),
      domain: state.serverDomain!,
    );
    await ProvidersController.currentDnsProvider!.createDomainRecords(
      records: getProjectDnsRecords(
        domainName: state.serverDomain!.domainName,
        ip4: serverDetails.ip4,
        isCreating: true,
      ),
      domain: state.serverDomain!,
    );

    emit(
      (state as ServerInstallationNotFinished).copyWith(
        isLoading: false,
        serverDetails: serverDetails,
        installationDialoguePopUp: null,
      ),
    );
    unawaited(
      runDelayed(startServerIfDnsIsOkay, const Duration(seconds: 30), null),
    );
  }

  Future<void> setCustomSshKey(final String key) async {
    emit((state as ServerInstallationNotFinished).copyWith(customSshKey: key));
  }

  Future<void> createServerAndSetDnsRecords() async {
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
      customSshKey: (state as ServerInstallationNotFinished).customSshKey,
      location: state.serverLocation!,
    );

    final result = await ProvidersController.currentServerProvider!
        .launchInstallation(installationData);

    if (!result.success && result.data != null) {
      emit(
        (state as ServerInstallationNotFinished).copyWith(
          installationDialoguePopUp: result.data,
        ),
      );
    }
  }

  Future<void> startServerIfDnsIsOkay({
    final ServerInstallationNotFinished? state,
  }) async {
    final ServerInstallationNotFinished dataState =
        state ?? this.state as ServerInstallationNotFinished;

    emit(TimerState(dataState: dataState, isLoading: true));

    final String ip4 = dataState.serverDetails!.ip4;
    final String domainName = dataState.serverDomain!.domainName;

    final Map<String, DnsRecordStatus> matches = await validateDnsMatch(
      domainName,
      ['api'],
      ip4,
    );

    if (matches.values.every(
          (final DnsRecordStatus value) => value == DnsRecordStatus.ok,
        ) &&
        matches.values.isNotEmpty) {
      final ServerHostingDetails server = await repository.startServer(
        dataState.serverDetails!,
      );

      await repository.saveServerDetails(server);
      await repository.saveIsServerStarted(serverStarted: true);

      final ServerInstallationNotFinished newState = dataState.copyWith(
        isServerStarted: true,
        isLoading: false,
        serverDetails: server,
      );
      emit(newState);
      unawaited(
        runDelayed(
          resetServerIfServerIsOkay,
          const Duration(seconds: 60),
          newState,
        ),
      );
    } else {
      final ServerInstallationNotFinished newState = dataState.copyWith(
        isLoading: false,
        dnsMatches: matches,
      );
      emit(newState);
      unawaited(
        runDelayed(
          startServerIfDnsIsOkay,
          const Duration(seconds: 30),
          newState,
        ),
      );
    }
  }

  Future<void> resetServerIfServerIsOkay({
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
        await repository.saveIsServerRebootedFirstTime(
          serverRebootedFirstTime: true,
        );
        await repository.saveServerDetails(serverDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedFirstTime: true,
          serverDetails: serverDetails,
          isLoading: false,
        );

        emit(newState);
        unawaited(
          runDelayed(oneMoreReset, const Duration(seconds: 60), newState),
        );
      });
    } else {
      unawaited(
        runDelayed(
          resetServerIfServerIsOkay,
          const Duration(seconds: 60),
          dataState,
        ),
      );
    }
  }

  Future<void> oneMoreReset({
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
        await repository.saveIsServerRebootedSecondTime(
          serverRebootedSecondTime: true,
        );
        await repository.saveServerDetails(serverDetails);

        final ServerInstallationNotFinished newState = dataState.copyWith(
          isServerResetedSecondTime: true,
          serverDetails: serverDetails,
          isLoading: false,
        );

        emit(newState);
        unawaited(
          runDelayed(
            finishCheckIfServerIsOkay,
            const Duration(seconds: 60),
            newState,
          ),
        );
      });
    } else {
      unawaited(
        runDelayed(oneMoreReset, const Duration(seconds: 60), dataState),
      );
    }
  }

  Future<void> finishCheckIfServerIsOkay({
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
        await repository.saveHasFinalChecked(finalCheckCompleted: true);
        emit(dataState.finish());
        await getIt<ApiConnectionRepository>().init();
      } else {
        unawaited(
          runDelayed(
            finishCheckIfServerIsOkay,
            const Duration(seconds: 60),
            dataState,
          ),
        );
      }
    } else {
      unawaited(
        runDelayed(
          finishCheckIfServerIsOkay,
          const Duration(seconds: 60),
          dataState,
        ),
      );
    }
  }

  Future<void> runDelayed(
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

  Future<void> submitDomainForAccessRecovery(final String domain) async {
    final ServerDomain serverDomain = ServerDomain(
      domainName: domain,
      provider: DnsProviderType.unknown,
    );
    final ServerRecoveryCapabilities recoveryCapabilities = await repository
        .getRecoveryCapabilities(serverDomain);

    await repository.saveDomain(serverDomain);
    await repository.saveIsRecoveringServer(isRecoveringServer: true);

    emit(
      ServerInstallationRecovery(
        serverDomain: serverDomain,
        recoveryCapabilities: recoveryCapabilities,
        currentStep: RecoveryStep.selecting,
      ),
    );
  }

  void selectRecoveryMethod(final ServerRecoveryMethods method) {
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    switch (method) {
      case ServerRecoveryMethods.newDeviceKey:
        emit(dataState.copyWith(currentStep: RecoveryStep.newDeviceKey));
      case ServerRecoveryMethods.recoveryKey:
        emit(dataState.copyWith(currentStep: RecoveryStep.recoveryKey));
      case ServerRecoveryMethods.oldToken:
        emit(dataState.copyWith(currentStep: RecoveryStep.oldToken));
    }
  }

  Future<void> tryToRecover(
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
      )
      recoveryFunction;
      switch (method) {
        case ServerRecoveryMethods.newDeviceKey:
          recoveryFunction = repository.authorizeByNewDeviceKey;
        case ServerRecoveryMethods.recoveryKey:
          recoveryFunction = repository.authorizeByRecoveryKey;
        case ServerRecoveryMethods.oldToken:
          recoveryFunction = repository.authorizeByApiToken;
      }
      final ServerHostingDetails serverDetails = await recoveryFunction(
        serverDomain,
        token,
        dataState.recoveryCapabilities,
      );
      final ServerProviderType serverProvider =
          await ServerApi(
            customToken: serverDetails.apiToken,
            isWithToken: true,
            overrideDomain: serverDomain.domainName,
          ).getServerProviderType();
      final dnsProvider =
          await ServerApi(
            customToken: serverDetails.apiToken,
            isWithToken: true,
            overrideDomain: serverDomain.domainName,
          ).getDnsProviderType();
      if (dnsProvider == DnsProviderType.unknown) {
        getIt<NavigationService>().showSnackBar(
          'recovering.generic_error'.tr(),
        );
        return;
      }
      final newServerDetails = ServerHostingDetails(
        provider: serverProvider,
        apiToken: serverDetails.apiToken,
        createTime: serverDetails.createTime,
        id: serverDetails.id,
        ip4: serverDetails.ip4,
        volume: serverDetails.volume,
        startTime: serverDetails.startTime,
      );
      final newServerDomain = ServerDomain(
        domainName: serverDomain.domainName,
        provider: dnsProvider,
      );
      await repository.saveServerDetails(newServerDetails);
      await repository.saveDnsProviderType(dnsProvider);
      await repository.saveDomain(newServerDomain);
      await setServerProviderType(serverProvider);
      await setDnsProviderType(dnsProvider);
      emit(
        dataState.copyWith(
          serverDetails: newServerDetails,
          serverDomain: newServerDomain,
          currentStep: RecoveryStep.serverProviderToken,
        ),
      );
    } on ServerAuthorizationException {
      getIt<NavigationService>().showSnackBar(
        'recovering.authorization_failed'.tr(),
      );
      return;
    } on IpNotFoundException {
      getIt<NavigationService>().showSnackBar(
        'recovering.domain_recover_error'.tr(),
      );
      return;
    }
  }

  Future<void> revertRecoveryStep() async {
    if (state is ServerInstallationEmpty) {
      return;
    }
    final ServerInstallationRecovery dataState =
        state as ServerInstallationRecovery;
    switch (dataState.currentStep) {
      case RecoveryStep.selecting:
        await repository.deleteDomain();
        emit(const ServerInstallationEmpty());
      case RecoveryStep.recoveryKey:
      case RecoveryStep.newDeviceKey:
      case RecoveryStep.oldToken:
        emit(dataState.copyWith(currentStep: RecoveryStep.selecting));
      case RecoveryStep.dnsProviderToken:
        await repository.deleteServerDetails();
        emit(dataState.copyWith(currentStep: RecoveryStep.serverSelection));
      // We won't revert steps after client is authorized
      case RecoveryStep.serverProviderToken:
      case RecoveryStep.serverSelection:
      case RecoveryStep.backblazeToken:
        break;
    }
  }

  Future<void> skipSettingServerProviderKey() async {
    emit(
      (state as ServerInstallationRecovery).copyWith(
        providerApiToken: null,
        currentStep: RecoveryStep.dnsProviderToken,
      ),
    );
  }

  Future<List<ServerBasicInfoWithValidators>> getAvailableServers({
    final Server? server,
  }) async {
    List<ServerBasicInfoWithValidators> validatedList = [];
    if (server != null) {
      final List<ServerBasicInfo> servers =
          await repository.getServersOnProviderAccount();
      try {
        final Iterable<ServerBasicInfoWithValidators> validated = servers.map(
          (final ServerBasicInfo hostingServer) =>
              ServerBasicInfoWithValidators.fromServerBasicInfo(
                serverBasicInfo: hostingServer,
                isIpValid: hostingServer.ip == server.hostingDetails.ip4,
                isReverseDnsValid:
                    hostingServer.reverseDns == server.domain.domainName ||
                    hostingServer.reverseDns ==
                        server.domain.domainName.split('.')[0],
              ),
        );
        validatedList = validated.toList();
      } catch (e) {
        logger('Error while validating servers', error: e);
        getIt<NavigationService>().showSnackBar(
          'modals.server_validators_error'.tr(),
        );
      }
    } else {
      final ServerInstallationRecovery dataState =
          state as ServerInstallationRecovery;
      final List<ServerBasicInfo> servers =
          await repository.getServersOnProviderAccount();
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
        logger('Error while validating servers', error: e);
        getIt<NavigationService>().showSnackBar(
          'modals.server_validators_error'.tr(),
        );
      }
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
      volume: ServerProviderVolume(
        id: 0,
        name: 'recovered_volume',
        sizeByte: 0,
        serverId: server.id,
        linuxDevice: '',
      ),
      apiToken: dataState.serverDetails!.apiToken,
      provider: dataState.serverDetails!.provider,
      serverLocation: server.location,
    );
    await repository.saveDomain(serverDomain);
    await repository.saveServerDetails(serverDetails);
    emit(
      dataState.copyWith(
        serverDetails: serverDetails,
        serverLocation: server.location,
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
    final isTokenValidResult = await repository.validateDnsToken(
      token,
      serverDomain.domainName,
    );
    if (!isTokenValidResult.success) {
      getIt<NavigationService>().showSnackBar(
        isTokenValidResult.message ??
            'recovering.domain_not_available_on_token'.tr(),
      );
      return;
    }
    final dnsProviderType =
        await ServerApi(
          customToken: dataState.serverDetails!.apiToken,
          isWithToken: true,
          overrideDomain: serverDomain.domainName,
        ).getDnsProviderType();
    await repository.saveDomain(
      ServerDomain(
        domainName: serverDomain.domainName,
        provider: dnsProviderType,
      ),
    );
    await repository.setDnsApiToken(token);
    emit(
      dataState.copyWith(
        serverDomain: ServerDomain(
          domainName: serverDomain.domainName,
          provider: dnsProviderType,
        ),
        dnsApiToken: token,
        currentStep: RecoveryStep.backblazeToken,
      ),
    );
  }

  Future<void> finishRecoveryProcess(
    final BackupsCredential backblazeCredential,
  ) async {
    await repository.saveIsServerStarted(serverStarted: true);
    await repository.saveIsServerRebootedFirstTime(
      serverRebootedFirstTime: true,
    );
    await repository.saveIsServerRebootedSecondTime(
      serverRebootedSecondTime: true,
    );
    await repository.saveIsRecoveringServer(isRecoveringServer: false);
    late final GenericResult<ServerType?>? serverType;
    if (ProvidersController.currentServerProvider?.isAuthorized ?? false) {
      serverType = await ProvidersController.currentServerProvider
          ?.getServerType(state.serverDetails!.id);
      if (serverType != null) {
        await repository.saveServerType(serverType.data!);
      }
    } else {
      serverType = null;
    }
    await repository.saveHasFinalChecked(finalCheckCompleted: true);
    final ServerInstallationRecovery updatedState =
        (state as ServerInstallationRecovery).copyWith(
          backblazeCredential: backblazeCredential,
          serverTypeIdentificator: serverType?.data?.identifier,
        );
    emit(updatedState.finish());
    await getIt<ApiConnectionRepository>().init();
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

  Future<void> clearAppConfig() async {
    closeTimer();
    ProvidersController.clearProviders();
    TlsOptions.verifyCertificate = false;
    await repository.clearAppConfig();
    emit(const ServerInstallationEmpty());
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
