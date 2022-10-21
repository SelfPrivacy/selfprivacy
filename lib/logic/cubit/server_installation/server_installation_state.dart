part of '../server_installation/server_installation_cubit.dart';

abstract class ServerInstallationState extends Equatable {
  const ServerInstallationState({
    required this.providerApiToken,
    required this.serverTypeIdentificator,
    required this.cloudFlareKey,
    required this.backblazeCredential,
    required this.serverDomain,
    required this.rootUser,
    required this.serverDetails,
    required this.isServerStarted,
    required this.isServerResetedFirstTime,
    required this.isServerResetedSecondTime,
  });

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        cloudFlareKey,
        backblazeCredential,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
      ];

  final String? providerApiToken;
  final String? cloudFlareKey;
  final String? serverTypeIdentificator;
  final BackblazeCredential? backblazeCredential;
  final ServerDomain? serverDomain;
  final User? rootUser;
  final ServerHostingDetails? serverDetails;
  final bool isServerStarted;
  final bool isServerResetedFirstTime;
  final bool isServerResetedSecondTime;

  bool get isServerProviderApiKeyFilled => providerApiToken != null;
  bool get isServerTypeFilled => serverTypeIdentificator != null;
  bool get isDnsProviderFilled => cloudFlareKey != null;
  bool get isBackupsProviderFilled => backblazeCredential != null;
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
      isBackupsProviderFilled,
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
          cloudFlareKey: dataState.cloudFlareKey,
          backblazeCredential: dataState.backblazeCredential,
          serverDomain: dataState.serverDomain,
          rootUser: dataState.rootUser,
          serverDetails: dataState.serverDetails,
          isServerStarted: dataState.isServerStarted,
          isServerResetedFirstTime: dataState.isServerResetedFirstTime,
          isServerResetedSecondTime: dataState.isServerResetedSecondTime,
          dnsMatches: dataState.dnsMatches,
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
  cloudFlareFilled,
  backblazeFilled,
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
    super.cloudFlareKey,
    super.backblazeCredential,
    super.serverDomain,
    super.rootUser,
    super.serverDetails,
  });
  final bool isLoading;
  final Map<String, bool>? dnsMatches;

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        cloudFlareKey,
        backblazeCredential,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        isLoading,
        dnsMatches,
      ];

  ServerInstallationNotFinished copyWith({
    final String? providerApiToken,
    final String? serverTypeIdentificator,
    final String? cloudFlareKey,
    final BackblazeCredential? backblazeCredential,
    final ServerDomain? serverDomain,
    final User? rootUser,
    final ServerHostingDetails? serverDetails,
    final bool? isServerStarted,
    final bool? isServerResetedFirstTime,
    final bool? isServerResetedSecondTime,
    final bool? isLoading,
    final Map<String, bool>? dnsMatches,
  }) =>
      ServerInstallationNotFinished(
        providerApiToken: providerApiToken ?? this.providerApiToken,
        serverTypeIdentificator:
            serverTypeIdentificator ?? this.serverTypeIdentificator,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        backblazeCredential: backblazeCredential ?? this.backblazeCredential,
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
      );

  ServerInstallationFinished finish() => ServerInstallationFinished(
        providerApiToken: providerApiToken!,
        serverTypeIdentificator: serverTypeIdentificator!,
        cloudFlareKey: cloudFlareKey!,
        backblazeCredential: backblazeCredential!,
        serverDomain: serverDomain!,
        rootUser: rootUser!,
        serverDetails: serverDetails!,
        isServerStarted: isServerStarted,
        isServerResetedFirstTime: isServerResetedFirstTime,
        isServerResetedSecondTime: isServerResetedSecondTime,
      );
}

class ServerInstallationEmpty extends ServerInstallationNotFinished {
  const ServerInstallationEmpty()
      : super(
          providerApiToken: null,
          serverTypeIdentificator: null,
          cloudFlareKey: null,
          backblazeCredential: null,
          serverDomain: null,
          rootUser: null,
          serverDetails: null,
          isServerStarted: false,
          isServerResetedFirstTime: false,
          isServerResetedSecondTime: false,
          isLoading: false,
          dnsMatches: null,
        );
}

class ServerInstallationFinished extends ServerInstallationState {
  const ServerInstallationFinished({
    required String super.providerApiToken,
    required String super.serverTypeIdentificator,
    required String super.cloudFlareKey,
    required BackblazeCredential super.backblazeCredential,
    required ServerDomain super.serverDomain,
    required User super.rootUser,
    required ServerHostingDetails super.serverDetails,
    required super.isServerStarted,
    required super.isServerResetedFirstTime,
    required super.isServerResetedSecondTime,
  });

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        cloudFlareKey,
        backblazeCredential,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
      ];
}

enum RecoveryStep {
  selecting,
  recoveryKey,
  newDeviceKey,
  oldToken,
  serverProviderToken,
  serverSelection,
  cloudflareToken,
  backblazeToken,
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
    super.cloudFlareKey,
    super.backblazeCredential,
    super.serverDomain,
    super.rootUser,
    super.serverDetails,
  }) : super(
          isServerStarted: true,
          isServerResetedFirstTime: true,
          isServerResetedSecondTime: true,
        );
  final RecoveryStep currentStep;
  final ServerRecoveryCapabilities recoveryCapabilities;

  @override
  List<Object?> get props => [
        providerApiToken,
        serverTypeIdentificator,
        cloudFlareKey,
        backblazeCredential,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
        currentStep
      ];

  ServerInstallationRecovery copyWith({
    final String? providerApiToken,
    final String? serverTypeIdentificator,
    final String? cloudFlareKey,
    final BackblazeCredential? backblazeCredential,
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
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        backblazeCredential: backblazeCredential ?? this.backblazeCredential,
        serverDomain: serverDomain ?? this.serverDomain,
        rootUser: rootUser ?? this.rootUser,
        serverDetails: serverDetails ?? this.serverDetails,
        currentStep: currentStep ?? this.currentStep,
        recoveryCapabilities: recoveryCapabilities ?? this.recoveryCapabilities,
      );

  ServerInstallationFinished finish() => ServerInstallationFinished(
        providerApiToken: providerApiToken!,
        serverTypeIdentificator: serverTypeIdentificator!,
        cloudFlareKey: cloudFlareKey!,
        backblazeCredential: backblazeCredential!,
        serverDomain: serverDomain!,
        rootUser: rootUser!,
        serverDetails: serverDetails!,
        isServerStarted: true,
        isServerResetedFirstTime: true,
        isServerResetedSecondTime: true,
      );
}
