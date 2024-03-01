part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class DevicesListChanged extends DevicesEvent {
  const DevicesListChanged(this.devices);

  final List<ApiToken>? devices;

  @override
  List<Object> get props => [];
}

class DeleteDevice extends DevicesEvent {
  const DeleteDevice(this.device);

  final ApiToken device;

  @override
  List<Object> get props => [device];
}
