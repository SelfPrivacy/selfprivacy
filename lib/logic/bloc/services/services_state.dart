part of 'services_bloc.dart';

sealed class ServicesState extends Equatable {
  ServicesState({
    this.continuity,
    final List<ServiceLock> lockedServices = const [],
  }) : _lockedServices = lockedServices
           .where((final lock) => lock.isLocked)
           .toList();
  final List<ServiceLock> _lockedServices;
  final ConnectionContinuity? continuity;
  List<Service> get services;
  List<String> get lockedServices => _lockedServices
      .where((final lock) => lock.isLocked)
      .map((final lock) => lock.serviceId)
      .toList();

  List<Service> get installedServices => services
      .where(
        (final service) =>
            service.isInstalled &&
            (!service.isSystemService ||
                (service.isSystemService &&
                    service.status != ServiceStatus.active)),
      )
      .toList();

  List<Service> get systemServices =>
      services.where((final service) => service.isSystemService).toList();

  List<Service> get availableServices =>
      services.where((final service) => !service.isInstalled).toList();

  List<Service> get servicesThatCanBeBackedUp =>
      services.where((final service) => service.canBeBackedUp).toList();

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

  ServicesState copyWith({
    final List<Service>? services,
    final List<ServiceLock>? lockedServices,
  });
}

class ServiceLock extends Equatable {
  ServiceLock({required this.serviceId, required this.lockDuration})
    : lockTime = DateTime.now();

  final String serviceId;
  final Duration lockDuration;
  final DateTime lockTime;

  bool get isLocked => DateTime.now().isBefore(lockTime.add(lockDuration));

  @override
  List<Object?> get props => [serviceId, lockDuration, lockTime];
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];

  @override
  List<Service> get services => [];

  @override
  ServicesState copyWith({
    final List<Service>? services,
    final List<ServiceLock>? lockedServices,
  }) => ServicesInitial();
}

class ServicesLoading extends ServicesInitial {}

class ServicesUnsupported extends ServicesInitial {}

class ServicesError extends ServicesInitial {}

class ServicesLoaded extends ServicesState {
  ServicesLoaded({
    required final List<Service> services,
    required super.lockedServices,
    super.continuity,
  }) : services = List.unmodifiable(services);

  @override
  final List<Service> services;

  @override
  List<Object?> get props => [services, _lockedServices, continuity];

  @override
  ServicesLoaded copyWith({
    final List<Service>? services,
    final List<ServiceLock>? lockedServices,
  }) => ServicesLoaded(
    services: services ?? this.services,
    lockedServices: lockedServices ?? _lockedServices,
    continuity: continuity,
  );
}

class ServicesReloading extends ServicesLoaded {
  ServicesReloading({
    required super.services,
    required super.lockedServices,
    super.continuity,
  });

  ServicesReloading.fromState(final ServicesLoaded state)
    : super(
        services: state.services,
        lockedServices: state._lockedServices,
        continuity: state.continuity,
      );

  @override
  List<Object?> get props => [services, lockedServices, continuity];
}
