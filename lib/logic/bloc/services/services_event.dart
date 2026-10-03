part of 'services_bloc.dart';

sealed class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class _ServicesObserved extends ServicesEvent {
  const _ServicesObserved(this.observation);

  final ConnectionObservation<CachedValue<List<Service>>> observation;

  @override
  List<Object?> get props => [observation];
}

class _ServiceAction<T extends ServicesEvent> extends ServicesEvent {
  const _ServiceAction(this.event, this.origin);
  final T event;
  final ServerStateOrigin? origin;

  @override
  List<Object?> get props => [event, origin];
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

class ServiceMove extends ServicesEvent {
  const ServiceMove(this.service, this.destination);

  final Service service;
  final String destination;

  @override
  List<Object?> get props => [service, destination];
}
