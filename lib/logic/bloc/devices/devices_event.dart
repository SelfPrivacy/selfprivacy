part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class _DevicesObserved extends DevicesEvent {
  const _DevicesObserved(this.observation);

  final ConnectionObservation<CachedValue<List<ApiToken>>> observation;

  @override
  List<Object> get props => [observation];
}

class _RevokeDevice extends DevicesEvent {
  const _RevokeDevice(this.device, this.origin);
  final ApiToken device;
  final ServerStateOrigin? origin;

  @override
  List<Object?> get props => [device, origin];
}

class DeleteDevice extends DevicesEvent {
  const DeleteDevice(this.device);

  final ApiToken device;

  @override
  List<Object> get props => [device];
}
