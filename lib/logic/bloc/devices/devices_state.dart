part of 'devices_bloc.dart';

sealed class DevicesState extends Equatable {
  DevicesState({
    required final List<ApiToken> devices,
    this.hasError = false,
    this.isRefreshing = false,
    this.pendingDeviceName,
  }) : devices = List.unmodifiable(devices);

  final List<ApiToken> devices;

  final bool hasError;
  final bool isRefreshing;
  final String? pendingDeviceName;
  bool get isLoaded => this is DevicesLoaded || this is DevicesDeleting;

  ApiToken? get thisDevice =>
      devices.firstWhereOrNull((final device) => device.isCaller);

  List<ApiToken> get otherDevices =>
      List.unmodifiable(devices.where((final device) => !device.isCaller));

  @override
  List<Object?> get props => [
    devices,
    hasError,
    isRefreshing,
    pendingDeviceName,
  ];
}

class DevicesInitial extends DevicesState {
  DevicesInitial() : super(devices: const []);
}

class DevicesLoaded extends DevicesState {
  DevicesLoaded({required super.devices, super.hasError, super.isRefreshing});
}

class DevicesError extends DevicesState {
  DevicesError() : super(devices: const [], hasError: true);
}

class DevicesDeleting extends DevicesState {
  DevicesDeleting({
    required super.devices,
    required super.pendingDeviceName,
    super.hasError,
  });
}
