part of 'devices_cubit.dart';

class ApiDevicesState extends ServerInstallationDependendState {
  const ApiDevicesState(this._devices, this.status);

  const ApiDevicesState.initial() : this(const [], LoadingStatus.uninitialized);
  final List<ApiToken> _devices;
  final LoadingStatus status;

  List<ApiToken> get devices => _devices;
  ApiToken get thisDevice => _devices.firstWhere((device) => device.isCaller,
      orElse: () => ApiToken(
            name: 'Error fetching device',
            isCaller: true,
            date: DateTime.now(),
          ));

  List<ApiToken> get otherDevices =>
      _devices.where((device) => !device.isCaller).toList();

  ApiDevicesState copyWith({
    List<ApiToken>? devices,
    LoadingStatus? status,
  }) {
    return ApiDevicesState(
      devices ?? _devices,
      status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [_devices];
}
