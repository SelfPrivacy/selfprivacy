part of 'services_cubit.dart';

class ServicesState extends ServerInstallationDependendState {
  const ServicesState({
    required this.services,
    required this.lockedServices,
  });

  const ServicesState.empty()
      : this(services: const [], lockedServices: const []);

  final List<Service> services;
  final List<String> lockedServices;

  bool isServiceLocked(final String serviceId) =>
      lockedServices.contains(serviceId);

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
        lockedServices,
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

  ServicesState copyWith({
    final List<Service>? services,
    final List<String>? lockedServices,
  }) =>
      ServicesState(
        services: services ?? this.services,
        lockedServices: lockedServices ?? this.lockedServices,
      );
}
