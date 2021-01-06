part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.hetznerKey,
    this.cloudFlareKey,
    this.cloudFlareDomain,
    this.rootUser,
    this.server,
    this.isDnsCheckedAndDkimSet = false,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        hetznerKey,
        cloudFlareKey,
        cloudFlareDomain,
        rootUser,
        server,
        isDnsCheckedAndDkimSet,
        isLoading,
      ];

  final String hetznerKey;
  final String cloudFlareKey;
  final CloudFlareDomain cloudFlareDomain;
  final User rootUser;
  final HetznerServerDetails server;
  final bool isDnsCheckedAndDkimSet;

  final isLoading;

  AppConfigState copyWith({
    String hetznerKey,
    String cloudFlareKey,
    CloudFlareDomain domain,
    User rootUser,
    HetznerServerDetails hetznerServer,
    bool isDnsCheckedAndDkimSet,
    bool isLoading,
    DateTime serverInitStart,
  }) =>
      AppConfigState(
        hetznerKey: hetznerKey ?? this.hetznerKey,
        cloudFlareKey: cloudFlareKey ?? this.cloudFlareKey,
        cloudFlareDomain: domain ?? this.cloudFlareDomain,
        rootUser: rootUser ?? this.rootUser,
        server: hetznerServer ?? this.server,
        isDnsCheckedAndDkimSet: isDnsCheckedAndDkimSet ?? this.isDnsCheckedAndDkimSet,
        isLoading: isLoading ?? this.isLoading,
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
        isDnsCheckedAndDkimSet,
      ];
}

class InitialAppConfigState extends AppConfigState {
  InitialAppConfigState() : super();
}
