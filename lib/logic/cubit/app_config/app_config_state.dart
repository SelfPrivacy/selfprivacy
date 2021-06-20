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
    required this.hasFinalChecked,
    required this.isLoading,
    required this.error,
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
        hasFinalChecked,
        isLoading,
        error,
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

  final bool hasFinalChecked;

  final bool isLoading;
  final Exception? error;

  AppConfigState copyWith({
    String? hetznerKey,
    String? cloudFlareKey,
    BackblazeCredential? backblazeCredential,
    CloudFlareDomain? cloudFlareDomain,
    User? rootUser,
    HetznerServerDetails? hetznerServer,
    bool? isServerStarted,
    bool? isServerResetedFirstTime,
    bool? isServerResetedSecondTime,
    bool? hasFinalChecked,
    bool? isLoading,
    Exception? error,
  }) =>
      AppConfigState(
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
        hasFinalChecked: hasFinalChecked ?? this.hasFinalChecked,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isBackblazeFilled => backblazeCredential != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerCreated => hetznerServer != null;

  bool get isFullyInitilized => _fulfilementList.every((el) => el!);
  int get progress => _fulfilementList.where((el) => el!).length ;

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
      hasFinalChecked,
    ];

    return res;
  }
}

class InitialAppConfigState extends AppConfigState {
  InitialAppConfigState()
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
          hasFinalChecked: false,
          isLoading: false,
          error: null,
        );
}

class TimerState extends AppConfigState {
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
          hasFinalChecked: dataState.hasFinalChecked,
          isLoading: isLoading,
          error: dataState.error,
        );

  final AppConfigState dataState;
  final DateTime? timerStart;
  final Duration? duration;

  @override
  List<Object?> get props => [
        dataState,
        timerStart,
        duration,
      ];
}
