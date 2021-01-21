part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.hetznerKey,
    this.cloudFlareKey,
    this.cloudFlareDomain,
    this.rootUser,
    this.hetznerServer,
    this.isDnsCheckedAndServerStarted = false,
    this.isLoading = false,
    this.error,
    this.lastDnsCheckTime,
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
        isDkimSetted,
      ];

  final String hetznerKey;
  final String cloudFlareKey;
  final CloudFlareDomain cloudFlareDomain;
  final User rootUser;
  final HetznerServerDetails hetznerServer;
  final bool isDnsCheckedAndServerStarted;
  final bool isDkimSetted;
  final DateTime lastDnsCheckTime;

  final bool isLoading;
  final Exception error;

  AppConfigState copyWith({
    String hetznerKey,
    String cloudFlareKey,
    CloudFlareDomain cloudFlareDomain,
    User rootUser,
    HetznerServerDetails hetznerServer,
    bool isDnsCheckedAndServerStarted,
    bool isLoading,
    Exception error,
    DateTime lastDnsCheckTime,
    bool isDkimSetted,
  }) =>
      AppConfigState(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        cloudFlareDomain: cloudFlareDomain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        hetznerServer: hetznerServer ?? this.hetznerServer,
        isDnsCheckedAndServerStarted:
            isDnsCheckedAndServerStarted ?? this.isDnsCheckedAndServerStarted,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        lastDnsCheckTime: lastDnsCheckTime ?? this.lastDnsCheckTime,
        isDkimSetted: isDkimSetted,
      );

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerFilled => hetznerServer != null;
  bool get hasFinalChecked => isDnsCheckedAndServerStarted && isDkimSetted;

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
