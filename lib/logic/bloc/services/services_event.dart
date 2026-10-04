part of 'services_bloc.dart';

sealed class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class _ServicesObserved extends ServicesEvent {
  const _ServicesObserved(this.observation);

  final CachedValue<List<Service>>? observation;

  @override
  List<Object?> get props => [observation];
}

class ServicesReload extends ServicesEvent {
  const ServicesReload();

  @override
  List<Object?> get props => [];
}

class ServiceRestart extends ServicesEvent {
  const ServiceRestart(this.service);

  final Service service;

  @override
  List<Object?> get props => [service];
}

class ServicesMove extends ServicesEvent {
  ServicesMove(final Map<String, String> destinations)
    : destinations = Map.unmodifiable(destinations);

  final Map<String, String> destinations;

  @override
  List<Object?> get props => [destinations];
}
