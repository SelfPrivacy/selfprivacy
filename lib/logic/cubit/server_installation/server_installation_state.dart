part of '../server_installation/server_installation_cubit.dart';

abstract class ServerInstallationState extends Equatable {
  const ServerInstallationState({
    required this.hetznerKey,
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
        hetznerKey,
        cloudFlareKey,
        backblazeCredential,
        serverDomain,
        rootUser,
        serverDetails,
        isServerStarted,
        isServerResetedFirstTime,
      ];

  final String? hetznerKey;
  final String? cloudFlareKey;
  final BackblazeCredential? backblazeCredential;
  final ServerDomain? serverDomain;
  final User? rootUser;
  final ServerHostingDetails? serverDetails;
  final bool isServerStarted;
  final bool isServerResetedFirstTime;
  final bool isServerResetedSecondTime;

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isBackblazeFilled => backblazeCredential != null;
  bool get isDomainFilled => serverDomain != null;
  bool get isUserFilled => rootUser != null;
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
      isHetznerFilled,
      isCloudFlareFilled,
      isBackblazeFilled,
      isDomainFilled,
      isUserFilled,
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
    required final super.isLoading,
    this.timerStart,
    this.duration,
  }) : super(
          hetznerKey: dataState.hetznerKey,
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
  hetznerFilled,
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
    required final super.isServerStarted,
    required final super.isServerResetedFirstTime,
    required final super.isServerResetedSecondTime,
    required final this.isLoading,
    required this.dnsMatches,
    final super.hetznerKey,
    final super.cloudFlareKey,
    final super.backblazeCredential,
    final super.serverDomain,
    final super.rootUser,
    final super.serverDetails,
  });
  final bool isLoading;
  final Map<String, bool>? dnsMatches;

  @override
  List<Object?> get props => [
        hetznerKey,
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
    final String? hetznerKey,
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
        hetznerKey: hetznerKey ?? this.hetznerKey,
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
        hetznerKey: hetznerKey!,
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
          hetznerKey: null,
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
    required final String super.hetznerKey,
    required final String super.cloudFlareKey,
    required final BackblazeCredential super.backblazeCredential,
    required final ServerDomain super.serverDomain,
    required final User super.rootUser,
    required final ServerHostingDetails super.serverDetails,
    required final super.isServerStarted,
    required final super.isServerResetedFirstTime,
    required final super.isServerResetedSecondTime,
  });

  @override
  List<Object?> get props => [
        hetznerKey,
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
  hetznerToken,
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
    final super.hetznerKey,
    final super.cloudFlareKey,
    final super.backblazeCredential,
    final super.serverDomain,
    final super.rootUser,
    final super.serverDetails,
  }) : super(
          isServerStarted: true,
          isServerResetedFirstTime: true,
          isServerResetedSecondTime: true,
        );
  final RecoveryStep currentStep;
  final ServerRecoveryCapabilities recoveryCapabilities;

  @override
  List<Object?> get props => [
        hetznerKey,
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
    final String? hetznerKey,
    final String? cloudFlareKey,
    final BackblazeCredential? backblazeCredential,
    final ServerDomain? serverDomain,
    final User? rootUser,
    final ServerHostingDetails? serverDetails,
    final RecoveryStep? currentStep,
    final ServerRecoveryCapabilities? recoveryCapabilities,
  }) =>
      ServerInstallationRecovery(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        backblazeCredential: backblazeCredential ?? this.backblazeCredential,
        serverDomain: serverDomain ?? this.serverDomain,
        rootUser: rootUser ?? this.rootUser,
        serverDetails: serverDetails ?? this.serverDetails,
        currentStep: currentStep ?? this.currentStep,
        recoveryCapabilities: recoveryCapabilities ?? this.recoveryCapabilities,
      );

  ServerInstallationFinished finish() => ServerInstallationFinished(
        hetznerKey: hetznerKey!,
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
