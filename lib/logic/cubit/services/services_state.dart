// ignore_for_file: always_specify_types

part of 'services_cubit.dart';

class ServicesState extends ServerInstallationDependendState {
  factory ServicesState.allOn() => const ServicesState(
        isPasswordManagerEnable: true,
        isCloudEnable: true,
        isGitEnable: true,
        isSocialNetworkEnable: true,
        isVpnEnable: true,
      );

  factory ServicesState.allOff() => const ServicesState(
        isPasswordManagerEnable: false,
        isCloudEnable: false,
        isGitEnable: false,
        isSocialNetworkEnable: false,
        isVpnEnable: false,
      );
  const ServicesState({
    required this.isPasswordManagerEnable,
    required this.isCloudEnable,
    required this.isGitEnable,
    required this.isSocialNetworkEnable,
    required this.isVpnEnable,
  });

  final bool isPasswordManagerEnable;
  final bool isCloudEnable;
  final bool isGitEnable;
  final bool isSocialNetworkEnable;
  final bool isVpnEnable;

  ServicesState enableList(
    final List<ServiceTypes> list,
  ) =>
      ServicesState(
        isPasswordManagerEnable: list.contains(ServiceTypes.passwordManager)
            ? true
            : isPasswordManagerEnable,
        isCloudEnable: list.contains(ServiceTypes.cloud) ? true : isCloudEnable,
        isGitEnable:
            list.contains(ServiceTypes.git) ? true : isPasswordManagerEnable,
        isSocialNetworkEnable: list.contains(ServiceTypes.socialNetwork)
            ? true
            : isPasswordManagerEnable,
        isVpnEnable:
            list.contains(ServiceTypes.vpn) ? true : isPasswordManagerEnable,
      );

  ServicesState disableList(
    final List<ServiceTypes> list,
  ) =>
      ServicesState(
        isPasswordManagerEnable: list.contains(ServiceTypes.passwordManager)
            ? false
            : isPasswordManagerEnable,
        isCloudEnable:
            list.contains(ServiceTypes.cloud) ? false : isCloudEnable,
        isGitEnable:
            list.contains(ServiceTypes.git) ? false : isPasswordManagerEnable,
        isSocialNetworkEnable: list.contains(ServiceTypes.socialNetwork)
            ? false
            : isPasswordManagerEnable,
        isVpnEnable:
            list.contains(ServiceTypes.vpn) ? false : isPasswordManagerEnable,
      );

  @override
  List<Object> get props => [
        isPasswordManagerEnable,
        isCloudEnable,
        isGitEnable,
        isSocialNetworkEnable,
        isVpnEnable
      ];

  bool isEnableByType(final ServiceTypes type) {
    switch (type) {
      case ServiceTypes.passwordManager:
        return isPasswordManagerEnable;
      case ServiceTypes.cloud:
        return isCloudEnable;
      case ServiceTypes.socialNetwork:
        return isSocialNetworkEnable;
      case ServiceTypes.git:
        return isGitEnable;
      case ServiceTypes.vpn:
        return isVpnEnable;
      default:
        throw Exception('wrong state');
    }
  }
}
