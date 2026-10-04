part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class RotateDeviceToken extends DevicesEvent {
  const RotateDeviceToken();

  @override
  List<Object> get props => [];
}

class _DevicesObserved extends DevicesEvent {
  const _DevicesObserved(this.observation);

  final CachedValue<List<ApiToken>>? observation;

  @override
  List<Object?> get props => [observation];
}

class DeleteDevice extends DevicesEvent {
  const DeleteDevice(this.device);
  final ApiToken device;

  @override
  List<Object?> get props => [device];
}
