part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.hetznerKey,
    this.cloudFlareKey,
    this.backblazeCredential,
    this.cloudFlareDomain,
    this.rootUser,
    this.hetznerServer,
    this.isLoading = false,
    this.error,
    // this.lastDnsCheckTime,
    // this.lastServerStatusCheckTime,
    this.isDnsChecked = false,
    this.isServerStarted = false,
  });

  @override
  List<Object> get props => [
        hetznerKey,
        cloudFlareKey,
        backblazeCredential,
        cloudFlareDomain,
        rootUser,
        hetznerServer,
        isDnsCheckedAndServerStarted,
        isLoading,
        error,
        // lastDnsCheckTime,
        // lastServerStatusCheckTime,
      ];

  final String hetznerKey;
  final String cloudFlareKey;
  final BackblazeCredential backblazeCredential;
  final CloudFlareDomain cloudFlareDomain;
  final User rootUser;
  final HetznerServerDetails hetznerServer;
  final bool isServerStarted;
  final bool isDnsChecked;
  // final DateTime lastDnsCheckTime;
  // final DateTime lastServerStatusCheckTime;
  final bool isLoading;
  final Exception error;

  AppConfigState copyWith({
    String hetznerKey,
    String cloudFlareKey,
    BackblazeCredential backblazeCredential,
    CloudFlareDomain cloudFlareDomain,
    User rootUser,
    HetznerServerDetails hetznerServer,
    bool isLoading,
    Exception error,
    DateTime lastDnsCheckTime,
    DateTime lastServerStatusCheckTime,
    bool isServerStarted,
    bool isDnsChecked,
  }) =>
      AppConfigState(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        backblazeCredential: backblazeCredential ?? this.backblazeCredential,
        cloudFlareDomain: cloudFlareDomain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        hetznerServer: hetznerServer ?? this.hetznerServer,
        isServerStarted: isServerStarted ?? this.isServerStarted,
        isDnsChecked: isDnsChecked ?? this.isDnsChecked,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        // lastDnsCheckTime: lastDnsCheckTime ?? this.lastDnsCheckTime,
        // lastServerStatusCheckTime:
        //     lastServerStatusCheckTime ?? this.lastServerStatusCheckTime,
      );

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isBackblazeFilled => backblazeCredential != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerFilled => hetznerServer != null;
  bool get hasFinalChecked => isDnsCheckedAndServerStarted;

  bool get isDnsCheckedAndServerStarted => isDnsChecked && isServerStarted;

  bool get isFullyInitilized => _fulfilementList.every((el) => el);

  int get progress => _fulfilementList.where((el) => el).length;

  List<bool> get _fulfilementList => [
        isHetznerFilled,
        isCloudFlareFilled,
        isBackblazeFilled,
        isDomainFilled,
        isUserFilled,
        isServerFilled,
        hasFinalChecked,
      ];
}

class InitialAppConfigState extends AppConfigState {
  InitialAppConfigState() : super();
}

class TimerState extends AppConfigState {
  TimerState({
    this.dataState,
    this.timerStart,
    this.duration,
  }) : super();

  final AppConfigState dataState;
  final DateTime timerStart;
  final Duration duration;

  @override
  List<Object> get props => [
        dataState,
        timerStart,
        duration,
      ];
}
