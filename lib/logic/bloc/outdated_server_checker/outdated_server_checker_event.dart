part of 'outdated_server_checker_bloc.dart';

sealed class OutdatedServerCheckerEvent extends Equatable {
  const OutdatedServerCheckerEvent();
}

class ServerApiVersionChanged extends OutdatedServerCheckerEvent {
  const ServerApiVersionChanged(this.newVersion);

  final String? newVersion;

  @override
  List<Object?> get props => [newVersion];
}
