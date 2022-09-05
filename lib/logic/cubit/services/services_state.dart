part of 'services_cubit.dart';

class ServicesState extends ServerInstallationDependendState {
  const ServicesState({
    required this.services,
  });

  const ServicesState.empty() : this(services: const []);

  final List<Service> services;
  bool get isPasswordManagerEnable => services
      .firstWhere(
        (final service) => service.id == 'bitwarden',
        orElse: () => Service.empty,
      )
      .isEnabled;
  bool get isCloudEnable => services
      .firstWhere(
        (final service) => service.id == 'nextcloud',
        orElse: () => Service.empty,
      )
      .isEnabled;
  bool get isGitEnable => services
      .firstWhere(
        (final service) => service.id == 'gitea',
        orElse: () => Service.empty,
      )
      .isEnabled;
  bool get isSocialNetworkEnable => services
      .firstWhere(
        (final service) => service.id == 'pleroma',
        orElse: () => Service.empty,
      )
      .isEnabled;
  bool get isVpnEnable => services
      .firstWhere(
        (final service) => service.id == 'ocserv',
        orElse: () => Service.empty,
      )
      .isEnabled;

  Service? getServiceById(final String id) {
    final service = services.firstWhere(
      (final service) => service.id == id,
      orElse: () => Service.empty,
    );
    if (service.id == 'empty') {
      return null;
    }
    return service;
  }

  @override
  List<Object> get props => [
        services,
      ];

  bool isEnableByType(final ServiceTypes type) {
    switch (type) {
      case ServiceTypes.bitwarden:
        return isPasswordManagerEnable;
      case ServiceTypes.nextcloud:
        return isCloudEnable;
      case ServiceTypes.pleroma:
        return isSocialNetworkEnable;
      case ServiceTypes.gitea:
        return isGitEnable;
      case ServiceTypes.ocserv:
        return isVpnEnable;
      default:
        throw Exception('wrong state');
    }
  }
}
