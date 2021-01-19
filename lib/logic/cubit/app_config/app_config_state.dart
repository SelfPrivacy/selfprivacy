part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.hetznerKey,
    this.cloudFlareKey,
    this.cloudFlareDomain,
    this.rootUser,
    this.server,
    this.isDnsChecked = false,
    this.isLoading = false,
    this.error,
    this.lastDnsCheckTime,
  });

  @override
  List<Object> get props => [
        hetznerKey,
        cloudFlareKey,
        cloudFlareDomain,
        rootUser,
        server,
        isDnsChecked,
        isLoading,
        error,
        lastDnsCheckTime
      ];

  final String hetznerKey;
  final String cloudFlareKey;
  final CloudFlareDomain cloudFlareDomain;
  final User rootUser;
  final HetznerServerDetails server;
  final bool isDnsChecked;
  final DateTime lastDnsCheckTime;

  final bool isLoading;
  final Exception error;

  AppConfigState copyWith({
    String hetznerKey,
    String cloudFlareKey,
    CloudFlareDomain domain,
    User rootUser,
    HetznerServerDetails hetznerServer,
    bool serverStarted,
    bool isLoading,
    Exception error,
    DateTime lastDnsCheckTime,
  }) =>
      AppConfigState(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        cloudFlareDomain: domain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        server: hetznerServer ?? this.server,
        isDnsChecked: serverStarted ?? this.isDnsChecked,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        lastDnsCheckTime: lastDnsCheckTime ?? this.lastDnsCheckTime,
      );

  bool get isHetznerFilled => hetznerKey != null;
  bool get isCloudFlareFilled => cloudFlareKey != null;
  bool get isDomainFilled => cloudFlareDomain != null;
  bool get isUserFilled => rootUser != null;
  bool get isServerFilled => server != null;

  bool get isFullyInitilized => _fulfilementList.every((el) => el);

  int get progress => _fulfilementList.where((el) => el).length;

  List<bool> get _fulfilementList => [
        isHetznerFilled,
        isCloudFlareFilled,
        isDomainFilled,
        isUserFilled,
        isServerFilled,
        isDnsChecked,
      ];
}

class InitialAppConfigState extends AppConfigState {
  InitialAppConfigState() : super();
}
