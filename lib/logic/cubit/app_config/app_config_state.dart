part of 'app_config_cubit.dart';

abstract class AppConfigState extends Equatable {
  const AppConfigState({
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

class TimerState extends AppConfigNotFinished {
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

  final AppConfigNotFinished dataState;
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

class AppConfigNotFinished extends AppConfigState {
  final bool isLoading;
  final Map<String, bool>? dnsMatches;

  AppConfigNotFinished({
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

  AppConfigNotFinished copyWith({
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
      AppConfigNotFinished(
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

  AppConfigFinished finish() => AppConfigFinished(
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

class AppConfigEmpty extends AppConfigNotFinished {
  AppConfigEmpty()
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

class AppConfigFinished extends AppConfigState {
  const AppConfigFinished({
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
  CloudflareToken,
  BackblazeToken,
}

class AppConfigRecovery extends AppConfigState {
  final RecoveryStep currentStep;

  const AppConfigRecovery({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    required RecoveryStep this.currentStep,
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

  AppConfigRecovery copyWith({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    ServerDomain? serverDomain,
    User? rootUser,
    ServerHostingDetails? serverDetails,
    RecoveryStep? currentStep,
  }) =>
      AppConfigRecovery(
          hetznerKey: hetznerKey ?? this.hetznerKey,
          cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
          backblazeCredential: backblazeCredential ?? this.backblazeCredential,
          serverDomain: serverDomain ?? this.serverDomain,
          rootUser: rootUser ?? this.rootUser,
          serverDetails: serverDetails ?? this.serverDetails,
          currentStep: currentStep ?? this.currentStep);
}
