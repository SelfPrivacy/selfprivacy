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

  bool get isFullyInitilized => _fulfilementList.every((el) => el!);
  ServerSetupProgress get progress =>
      ServerSetupProgress.values[_fulfilementList.where((el) => el!).length];

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
    var res = [
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
    this.timerStart,
    this.duration,
    required bool isLoading,
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
          isLoading: isLoading,
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
  final bool isLoading;
  final Map<String, bool>? dnsMatches;

  ServerInstallationNotFinished({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    required bool isServerStarted,
    required bool isServerResetedFirstTime,
    required bool isServerResetedSecondTime,
    required this.isLoading,
    required this.dnsMatches,
  }) : super(
          hetznerKey: hetznerKey,
          cloudFlareKey: cloudFlareKey,
          backblazeCredential: backblazeCredential,
          serverDomain: serverDomain,
          rootUser: rootUser,
          serverDetails: serverDetails,
          isServerStarted: isServerStarted,
          isServerResetedFirstTime: isServerResetedFirstTime,
          isServerResetedSecondTime: isServerResetedSecondTime,
        );

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
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    bool? isServerStarted,
    bool? isServerResetedFirstTime,
    bool? isServerResetedSecondTime,
    bool? isLoading,
    Map<String, bool>? dnsMatches,
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
  ServerInstallationEmpty()
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
    required String hetznerKey,
    required String cloudFlareKey,
    required BackblazeCredential backblazeCredential,
    required ServerDomain serverDomain,
    required User rootUser,
    required ServerHostingDetails serverDetails,
    required bool isServerStarted,
    required bool isServerResetedFirstTime,
    required bool isServerResetedSecondTime,
  }) : super(
          hetznerKey: hetznerKey,
          cloudFlareKey: cloudFlareKey,
          backblazeCredential: backblazeCredential,
          serverDomain: serverDomain,
          rootUser: rootUser,
          serverDetails: serverDetails,
          isServerStarted: isServerStarted,
          isServerResetedFirstTime: isServerResetedFirstTime,
          isServerResetedSecondTime: isServerResetedSecondTime,
        );

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
  Selecting,
  RecoveryKey,
  NewDeviceKey,
  OldToken,
  HetznerToken,
  ServerSelection,
  CloudflareToken,
  BackblazeToken,
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
  final RecoveryStep currentStep;
  final ServerRecoveryCapabilities recoveryCapabilities;

  const ServerInstallationRecovery({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    required RecoveryStep this.currentStep,
    required ServerRecoveryCapabilities this.recoveryCapabilities,
  }) : super(
          hetznerKey: hetznerKey,
          cloudFlareKey: cloudFlareKey,
          backblazeCredential: backblazeCredential,
          serverDomain: serverDomain,
          rootUser: rootUser,
          serverDetails: serverDetails,
          isServerStarted: true,
          isServerResetedFirstTime: true,
          isServerResetedSecondTime: true,
        );

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
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    RecoveryStep? currentStep,
    ServerRecoveryCapabilities? recoveryCapabilities,
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

  ServerInstallationFinished finish() {
    return ServerInstallationFinished(
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
}
