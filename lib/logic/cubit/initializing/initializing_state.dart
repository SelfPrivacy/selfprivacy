part of 'initializing_cubit.dart';

class InitializingState extends Equatable {
  const InitializingState(this.appConfig);

  final AppConfig appConfig;

  @override
  List<Object> get props => [appConfig];

  bool get isHatznerFilled => appConfig.hatzner != null;
  bool get isCloudFlareFilled => appConfig.cloudFlare != null;
  bool get isDomainFilled => appConfig.domain != null;
  bool get isUserFilled => appConfig.rootUser != null;

  bool get isFullyInitilized => _fulfilementList.every((el) => el);

  int get progress => _fulfilementList.where((el) => el).length;

  List<bool> get _fulfilementList =>
      [isHatznerFilled, isCloudFlareFilled, isDomainFilled, isUserFilled];
}

class InitialInitializingState extends InitializingState {
  InitialInitializingState() : super(AppConfig.empty());
}
