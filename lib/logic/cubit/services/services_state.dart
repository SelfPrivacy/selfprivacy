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

  List<Service> get servicesThatCanBeBackedUp => services
      .where(
        (final service) => service.canBeBackedUp,
      )
      .toList();

  bool isServiceLocked(final String serviceId) =>
      lockedServices.contains(serviceId);

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

  ServicesState copyWith({
    final List<Service>? services,
    final List<String>? lockedServices,
  }) =>
      ServicesState(
        services: services ?? this.services,
        lockedServices: lockedServices ?? this.lockedServices,
      );
}
