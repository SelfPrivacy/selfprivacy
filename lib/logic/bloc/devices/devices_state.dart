part of 'devices_bloc.dart';

sealed class DevicesState extends Equatable {
  DevicesState({required final List<ApiToken> devices})
    : _hashCode = Object.hashAll(devices);

  final int _hashCode;

  bool get isLoaded => _devices.isNotEmpty;

  List<ApiToken> get _devices =>
      getIt<ApiConnectionRepository>().apiData.devices.data ?? const [];

  List<ApiToken> get devices => _devices;
  ApiToken get thisDevice => _devices.firstWhere(
    (final device) => device.isCaller,
    orElse: () => FakeSelfPrivacyData.thisDeviceToken,
  );

  List<ApiToken> get otherDevices =>
      _devices.where((final device) => !device.isCaller).toList();
}

class DevicesInitial extends DevicesState {
  DevicesInitial() : super(devices: const []);

  @override
  List<Object> get props => [_hashCode];
}

class DevicesLoaded extends DevicesState {
  DevicesLoaded({required super.devices});

  @override
  List<Object> get props => [_hashCode];
}

class DevicesError extends DevicesState {
  DevicesError() : super(devices: const []);

  @override
  List<Object> get props => [_hashCode];
}

class DevicesDeleting extends DevicesState {
  DevicesDeleting({required super.devices});

  @override
  List<Object> get props => [_hashCode];
}
