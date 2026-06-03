part of 'app_readiness_cubit.dart';

sealed class AppReadinessState extends Equatable {
  const AppReadinessState();

  String get domain => switch (this) {
    ServerConfigured(:final server) => server.domain.domainName,
    NoServer() => '',
  };
}

final class NoServer extends AppReadinessState {
  @override
  List<Object> get props => [];
}

final class ServerConfigured extends AppReadinessState {
  const ServerConfigured(this.server);

  final Server server;

  @override
  List<Object> get props => [server];
}
