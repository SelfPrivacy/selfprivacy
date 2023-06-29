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

  List<Service> get servicesThatCanBeBackedUp => services.where(
        (final service) => service.canBeBackedUp,
      ).toList();

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

  bool isEnableByType(final Service service) {
    switch (service.id) {
      case 'bitwarden':
        return isPasswordManagerEnable;
      case 'nextcloud':
        return isCloudEnable;
      case 'pleroma':
        return isSocialNetworkEnable;
      case 'gitea':
        return isGitEnable;
      case 'ocserv':
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
