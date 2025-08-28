part of 'server_logs_bloc.dart';

sealed class ServerLogsEvent extends Equatable {
  const ServerLogsEvent();
}

final class ServerLogsFetch extends ServerLogsEvent {
  const ServerLogsFetch({this.serviceId, this.unitId});

  final String? serviceId;
  final String? unitId;

  @override
  List<Object> get props => [];
}

final class ServerLogsFetchMore extends ServerLogsEvent {
  @override
  List<Object> get props => [];
}

final class ServerLogsGotNewEntry extends ServerLogsEvent {
  const ServerLogsGotNewEntry(this.entry);

  final ServerLogEntry entry;

  @override
  List<Object> get props => [entry];
}

final class ServerLogsDisconnect extends ServerLogsEvent {
  @override
  List<Object> get props => [];
}
