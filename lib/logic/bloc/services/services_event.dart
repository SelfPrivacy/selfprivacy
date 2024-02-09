part of 'services_bloc.dart';

sealed class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class ServicesListUpdate extends ServicesEvent {
  const ServicesListUpdate(this.services);

  final List<Service> services;

  @override
  List<Object?> get props => [services];
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
