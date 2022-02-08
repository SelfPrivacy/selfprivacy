part of 'server_detailed_info_cubit.dart';

abstract class ServerDetailsState extends Equatable {
  const ServerDetailsState();

  @override
  List<Object> get props => [];
}

class ServerDetailsInitial extends ServerDetailsState {}

class ServerDetailsLoading extends ServerDetailsState {}

class ServerDetailsNotReady extends ServerDetailsState {}

class Loading extends ServerDetailsState {}

class Loaded extends ServerDetailsState {
  final HetznerServerInfo serverInfo;

  final TimeZoneSettings serverTimezone;

  final AutoUpgradeSettings autoUpgradeSettings;
  final DateTime checkTime;

  Loaded({
    required this.serverInfo,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
    required this.checkTime,
  });

  @override
  List<Object> get props => [
        serverInfo,
        serverTimezone,
        autoUpgradeSettings,
        checkTime,
      ];
}
