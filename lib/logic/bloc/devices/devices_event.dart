part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class DevicesListChanged extends DevicesEvent {
  const DevicesListChanged(this.snapshot);

  final CachedValue<List<ApiToken>> snapshot;

  @override
  List<Object> get props => [snapshot];
}

class DeleteDevice extends DevicesEvent {
  const DeleteDevice(this.device);

  final ApiToken device;

  @override
  List<Object> get props => [device];
}
