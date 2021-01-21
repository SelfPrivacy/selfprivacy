part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.hetznerKey,
    this.cloudFlareKey,
    this.cloudFlareDomain,
    this.rootUser,
    this.hetznerServer,
    this.isLoading = false,
    this.error,
    this.lastDnsCheckTime,
    this.lastServerStatusCheckTime,
    this.isDnsChecked = false,
    this.isServerStarted = false,
    this.isDkimSetted = false,
  });

  @override
  List<Object> get props => [
        hetznerKey,
        cloudFlareKey,
        cloudFlareDomain,
        rootUser,
        hetznerServer,
        isDnsCheckedAndServerStarted,
        isLoading,
        error,
        lastDnsCheckTime,
        lastServerStatusCheckTime,
        isDkimSetted,
      ];

  final String hetznerKey;
  final String cloudFlareKey;
  final CloudFlareDomain cloudFlareDomain;
  final User rootUser;
  final HetznerServerDetails hetznerServer;
  final bool isDkimSetted;
  final bool isServerStarted;
  final bool isDnsChecked;
  final DateTime lastDnsCheckTime;
  final DateTime lastServerStatusCheckTime;
  final bool isLoading;
  final Exception error;

  AppConfigState copyWith({
    String hetznerKey,
    String cloudFlareKey,
    CloudFlareDomain cloudFlareDomain,
    User rootUser,
    HetznerServerDetails hetznerServer,
    bool isLoading,
    Exception error,
    DateTime lastDnsCheckTime,
    DateTime lastServerStatusCheckTime,
    bool isDkimSetted,
    bool isServerStarted,
    bool isDnsChecked,
  }) =>
      AppConfigState(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        cloudFlareDomain: cloudFlareDomain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        hetznerServer: hetznerServer ?? this.hetznerServer,
        isServerStarted: isServerStarted ?? this.isServerStarted,
        isDnsChecked: isDnsChecked ?? this.isDnsChecked,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        lastDnsCheckTime: lastDnsCheckTime ?? this.lastDnsCheckTime,
        lastServerStatusCheckTime:
            lastServerStatusCheckTime ?? this.lastServerStatusCheckTime,
        isDkimSetted: isDkimSetted ?? this.isDkimSetted,
      );

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerFilled => hetznerServer != null;
  bool get hasFinalChecked => isDnsCheckedAndServerStarted && isDkimSetted;

  bool get isDnsCheckedAndServerStarted => isDnsChecked && isServerStarted;

  bool get isFullyInitilized => _fulfilementList.every((el) => el);

  int get progress => _fulfilementList.where((el) => el).length;

  List<bool> get _fulfilementList => [
        isHetznerFilled,
        isCloudFlareFilled,
        isDomainFilled,
        isUserFilled,
        isServerFilled,
        hasFinalChecked,
      ];
}

class InitialAppConfigState extends AppConfigState {
  InitialAppConfigState() : super();
}
