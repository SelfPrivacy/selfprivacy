part of 'connection_status_bloc.dart';

sealed class ConnectionStatusEvent extends Equatable {
  const ConnectionStatusEvent();
}

class ConnectionStatusChanged extends ConnectionStatusEvent {
  const ConnectionStatusChanged(this.connectionStatus);

  final ConnectionStatus connectionStatus;

  @override
  List<Object?> get props => [connectionStatus];
}
