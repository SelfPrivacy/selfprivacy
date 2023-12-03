part of '../server_installation/server_installation_cubit.dart';

abstract class ServerInstallationState extends Equatable {
  const ServerInstallationState({
    required this.providerApiToken,
    required this.serverTypeIdentificator,
    required this.dnsApiToken,
    required this.serverDomain,
    required this.rootUser,
    required this.serverDetails,
    required this.isServerStarted,
    required this.isServerResetedFirstTime,
    required this.isServerResetedSecondTime,
    required this.installationDialoguePopUp,
  });

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        dnsApiToken,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        installationDialoguePopUp,
      ];

  final String? providerApiToken;
  final String? dnsApiToken;
  final String? serverTypeIdentificator;
  final ServerDomain? serverDomain;
  final User? rootUser;
  final ServerHostingDetails? serverDetails;
  final bool isServerStarted;
  final bool isServerResetedFirstTime;
  final bool isServerResetedSecondTime;
  final CallbackDialogueBranching? installationDialoguePopUp;

  bool get isServerProviderApiKeyFilled => providerApiToken != null;
  bool get isServerTypeFilled => serverTypeIdentificator != null;
  bool get isDnsProviderFilled => dnsApiToken != null;
  bool get isDomainSelected => serverDomain != null;
  bool get isPrimaryUserFilled => rootUser != null;
  bool get isServerCreated => serverDetails != null;

  bool get isFullyInitilized => _fulfilementList.every((final el) => el!);
  ServerSetupProgress get progress => ServerSetupProgress
      .values[_fulfilementList.where((final el) => el!).length];

  int get porgressBar {
    if (progress.index < 6) {
      return progress.index;
    } else if (progress.index < 10) {
      return 6;
    } else {
      return 7;
    }
  }

  List<bool?> get _fulfilementList {
    final List<bool> res = [
      isServerProviderApiKeyFilled,
      isServerTypeFilled,
      isDnsProviderFilled,
      isDomainSelected,
      isPrimaryUserFilled,
      isServerCreated,
      isServerStarted,
      isServerResetedFirstTime,
      isServerResetedSecondTime,
    ];

    return res;
  }
}

class TimerState extends ServerInstallationNotFinished {
  TimerState({
    required this.dataState,
    required super.isLoading,
    this.timerStart,
    this.duration,
  }) : super(
          providerApiToken: dataState.providerApiToken,
          serverTypeIdentificator: dataState.serverTypeIdentificator,
          dnsApiToken: dataState.dnsApiToken,
          serverDomain: dataState.serverDomain,
          rootUser: dataState.rootUser,
          serverDetails: dataState.serverDetails,
          isServerStarted: dataState.isServerStarted,
          isServerResetedFirstTime: dataState.isServerResetedFirstTime,
          isServerResetedSecondTime: dataState.isServerResetedSecondTime,
          dnsMatches: dataState.dnsMatches,
          installationDialoguePopUp: dataState.installationDialoguePopUp,
        );

  final ServerInstallationNotFinished dataState;
  final DateTime? timerStart;
  final Duration? duration;

  @override
  List<Object?> get props => [
        dataState,
        timerStart,
        duration,
      ];
}

enum ServerSetupProgress {
  nothingYet,
  serverProviderFilled,
  servertTypeFilled,
  dnsProviderFilled,
  domainFilled,
  userFilled,
  serverCreated,
  serverStarted,
  serverResetedFirstTime,
  serverResetedSecondTime,
}

class ServerInstallationNotFinished extends ServerInstallationState {
  const ServerInstallationNotFinished({
    required super.isServerStarted,
    required super.isServerResetedFirstTime,
    required super.isServerResetedSecondTime,
    required this.isLoading,
    required this.dnsMatches,
    super.providerApiToken,
    super.serverTypeIdentificator,
    super.dnsApiToken,
    super.serverDomain,
    super.rootUser,
    super.serverDetails,
    super.installationDialoguePopUp,
  });
  final bool isLoading;
  final Map<String, bool>? dnsMatches;

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        dnsApiToken,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        isLoading,
        dnsMatches,
        installationDialoguePopUp,
      ];

  ServerInstallationNotFinished copyWith({
    final String? providerApiToken,
    final String? serverTypeIdentificator,
    final String? dnsApiToken,
    final ServerDomain? serverDomain,
    final User? rootUser,
    final ServerHostingDetails? serverDetails,
    final bool? isServerStarted,
    final bool? isServerResetedFirstTime,
    final bool? isServerResetedSecondTime,
    final bool? isLoading,
    final Map<String, bool>? dnsMatches,
    final CallbackDialogueBranching? installationDialoguePopUp,
  }) =>
      ServerInstallationNotFinished(
        providerApiToken: providerApiToken ?? this.providerApiToken,
        serverTypeIdentificator:
            serverTypeIdentificator ?? this.serverTypeIdentificator,
        dnsApiToken: dnsApiToken ?? this.dnsApiToken,
        serverDomain: serverDomain ?? this.serverDomain,
        rootUser: rootUser ?? this.rootUser,
        serverDetails: serverDetails ?? this.serverDetails,
        isServerStarted: isServerStarted ?? this.isServerStarted,
        isServerResetedFirstTime:
            isServerResetedFirstTime ?? this.isServerResetedFirstTime,
        isServerResetedSecondTime:
            isServerResetedSecondTime ?? this.isServerResetedSecondTime,
        isLoading: isLoading ?? this.isLoading,
        dnsMatches: dnsMatches ?? this.dnsMatches,
        installationDialoguePopUp:
            installationDialoguePopUp ?? this.installationDialoguePopUp,
      );

  ServerInstallationFinished finish() => ServerInstallationFinished(
        providerApiToken: providerApiToken!,
        serverTypeIdentificator: serverTypeIdentificator!,
        dnsApiToken: dnsApiToken!,
        serverDomain: serverDomain!,
        rootUser: rootUser!,
        serverDetails: serverDetails!,
        isServerStarted: isServerStarted,
        isServerResetedFirstTime: isServerResetedFirstTime,
        isServerResetedSecondTime: isServerResetedSecondTime,
        installationDialoguePopUp: installationDialoguePopUp,
      );
}

class ServerInstallationEmpty extends ServerInstallationNotFinished {
  const ServerInstallationEmpty()
      : super(
          providerApiToken: null,
          serverTypeIdentificator: null,
          dnsApiToken: null,
          serverDomain: null,
          rootUser: null,
          serverDetails: null,
          isServerStarted: false,
          isServerResetedFirstTime: false,
          isServerResetedSecondTime: false,
          isLoading: false,
          dnsMatches: null,
          installationDialoguePopUp: null,
        );
}

class ServerInstallationFinished extends ServerInstallationState {
  const ServerInstallationFinished({
    required String super.providerApiToken,
    required String super.serverTypeIdentificator,
    required String super.dnsApiToken,
    required ServerDomain super.serverDomain,
    required User super.rootUser,
    required ServerHostingDetails super.serverDetails,
    required super.isServerStarted,
    required super.isServerResetedFirstTime,
    required super.isServerResetedSecondTime,
    required super.installationDialoguePopUp,
  });

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        dnsApiToken,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        installationDialoguePopUp,
      ];
}

enum RecoveryStep {
  selecting,
  recoveryKey,
  newDeviceKey,
  oldToken,
  serverProviderToken,
  serverSelection,
  dnsProviderToken,
}

enum ServerRecoveryCapabilities {
  none,
  legacy,
  loginTokens,
}

enum ServerRecoveryMethods {
  newDeviceKey,
  recoveryKey,
  oldToken,
}

class ServerInstallationRecovery extends ServerInstallationState {
  const ServerInstallationRecovery({
    required this.currentStep,
    required this.recoveryCapabilities,
    super.providerApiToken,
    super.serverTypeIdentificator,
    super.dnsApiToken,
    super.serverDomain,
    super.rootUser,
    super.serverDetails,
  }) : super(
          isServerStarted: true,
          isServerResetedFirstTime: true,
          isServerResetedSecondTime: true,
          installationDialoguePopUp: null,
        );
  final RecoveryStep currentStep;
  final ServerRecoveryCapabilities recoveryCapabilities;

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        dnsApiToken,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        currentStep,
        installationDialoguePopUp,
      ];

  ServerInstallationRecovery copyWith({
    final String? providerApiToken,
    final String? serverTypeIdentificator,
    final String? dnsApiToken,
    final ServerDomain? serverDomain,
    final User? rootUser,
    final ServerHostingDetails? serverDetails,
    final RecoveryStep? currentStep,
    final ServerRecoveryCapabilities? recoveryCapabilities,
  }) =>
      ServerInstallationRecovery(
        providerApiToken: providerApiToken ?? this.providerApiToken,
        serverTypeIdentificator:
            serverTypeIdentificator ?? this.serverTypeIdentificator,
        dnsApiToken: dnsApiToken ?? this.dnsApiToken,
        serverDomain: serverDomain ?? this.serverDomain,
        rootUser: rootUser ?? this.rootUser,
        serverDetails: serverDetails ?? this.serverDetails,
        currentStep: currentStep ?? this.currentStep,
        recoveryCapabilities: recoveryCapabilities ?? this.recoveryCapabilities,
      );

  ServerInstallationFinished finish() => ServerInstallationFinished(
        providerApiToken: providerApiToken!,
        serverTypeIdentificator: serverTypeIdentificator!,
        dnsApiToken: dnsApiToken!,
        serverDomain: serverDomain!,
        rootUser: rootUser!,
        serverDetails: serverDetails!,
        isServerStarted: true,
        isServerResetedFirstTime: true,
        isServerResetedSecondTime: true,
        installationDialoguePopUp: null,
      );
}
