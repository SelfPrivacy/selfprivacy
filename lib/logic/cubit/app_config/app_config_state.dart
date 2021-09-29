part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    required this.hetznerKey,
    required this.cloudFlareKey,
    required this.backblazeCredential,
    required this.cloudFlareDomain,
    required this.rootUser,
    required this.hetznerServer,
    required this.isServerStarted,
    required this.isServerResetedFirstTime,
    required this.isServerResetedSecondTime,
  });

  @override
  List<Object?> get props => [
        hetznerKey,
        cloudFlareKey,
        backblazeCredential,
        cloudFlareDomain,
        rootUser,
        hetznerServer,
        isServerStarted,
        isServerResetedFirstTime,
      ];

  final String? hetznerKey;
  final String? cloudFlareKey;
  final BackblazeCredential? backblazeCredential;
  final CloudFlareDomain? cloudFlareDomain;
  final User? rootUser;
  final HetznerServerDetails? hetznerServer;
  final bool isServerStarted;
  final bool isServerResetedFirstTime;
  final bool isServerResetedSecondTime;

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isBackblazeFilled => backblazeCredential != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerCreated => hetznerServer != null;

  // bool get isFullyInitilized => _fulfilementList.every((el) => el!);
  int get progress => _fulfilementList.where((el) => el!).length;

  int get porgressBar {
    if (progress < 6) {
      return progress;
    } else if (progress < 10) {
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
          cloudFlareDomain: dataState.cloudFlareDomain,
          rootUser: dataState.rootUser,
          hetznerServer: dataState.hetznerServer,
          isServerStarted: dataState.isServerStarted,
          isServerResetedFirstTime: dataState.isServerResetedFirstTime,
          isServerResetedSecondTime: dataState.isServerResetedSecondTime,
          isLoading: isLoading,
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

class AppConfigNotFinished extends AppConfigState {
  final bool isLoading;

  AppConfigNotFinished({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    CloudFlareDomain? cloudFlareDomain,
    User? rootUser,
    HetznerServerDetails? hetznerServer,
    required bool isServerStarted,
    required bool isServerResetedFirstTime,
    required bool isServerResetedSecondTime,
    required this.isLoading,
  }) : super(
          hetznerKey: hetznerKey,
          cloudFlareKey: cloudFlareKey,
          backblazeCredential: backblazeCredential,
          cloudFlareDomain: cloudFlareDomain,
          rootUser: rootUser,
          hetznerServer: hetznerServer,
          isServerStarted: isServerStarted,
          isServerResetedFirstTime: isServerResetedFirstTime,
          isServerResetedSecondTime: isServerResetedSecondTime,
        );

  @override
  List<Object?> get props => [
        hetznerKey,
        cloudFlareKey,
        backblazeCredential,
        cloudFlareDomain,
        rootUser,
        hetznerServer,
        isServerStarted,
        isServerResetedFirstTime,
        isLoading
      ];

  AppConfigNotFinished copyWith({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    CloudFlareDomain? cloudFlareDomain,
    User? rootUser,
    HetznerServerDetails? hetznerServer,
    bool? isServerStarted,
    bool? isServerResetedFirstTime,
    bool? isServerResetedSecondTime,
    bool? isLoading,
  }) =>
      AppConfigNotFinished(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        backblazeCredential: backblazeCredential ?? this.backblazeCredential,
        cloudFlareDomain: cloudFlareDomain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        hetznerServer: hetznerServer ?? this.hetznerServer,
        isServerStarted: isServerStarted ?? this.isServerStarted,
        isServerResetedFirstTime:
            isServerResetedFirstTime ?? this.isServerResetedFirstTime,
        isServerResetedSecondTime:
            isServerResetedSecondTime ?? this.isServerResetedSecondTime,
        isLoading: isLoading ?? this.isLoading,
      );

  AppConfigFinished finish() => AppConfigFinished(
        hetznerKey: hetznerKey!,
        cloudFlareKey: cloudFlareKey!,
        backblazeCredential: backblazeCredential!,
        cloudFlareDomain: cloudFlareDomain!,
        rootUser: rootUser!,
        hetznerServer: hetznerServer!,
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
          cloudFlareDomain: null,
          rootUser: null,
          hetznerServer: null,
          isServerStarted: false,
          isServerResetedFirstTime: false,
          isServerResetedSecondTime: false,
          isLoading: false,
        );
}

class AppConfigFinished extends AppConfigState {
  const AppConfigFinished({
    required String hetznerKey,
    required String cloudFlareKey,
    required BackblazeCredential backblazeCredential,
    required CloudFlareDomain cloudFlareDomain,
    required User rootUser,
    required HetznerServerDetails hetznerServer,
    required bool isServerStarted,
    required bool isServerResetedFirstTime,
    required bool isServerResetedSecondTime,
  }) : super(
          hetznerKey: hetznerKey,
          cloudFlareKey: cloudFlareKey,
          backblazeCredential: backblazeCredential,
          cloudFlareDomain: cloudFlareDomain,
          rootUser: rootUser,
          hetznerServer: hetznerServer,
          isServerStarted: isServerStarted,
          isServerResetedFirstTime: isServerResetedFirstTime,
          isServerResetedSecondTime: isServerResetedSecondTime,
        );

  @override
  List<Object?> get props => [
        hetznerKey,
        cloudFlareKey,
        backblazeCredential,
        cloudFlareDomain,
        rootUser,
        hetznerServer,
        isServerStarted,
        isServerResetedFirstTime,
      ];
}
