part of 'outdated_server_checker_bloc.dart';

sealed class OutdatedServerCheckerState extends Equatable {
  const OutdatedServerCheckerState();

  VersionConstraint get requiredVersion =>
      VersionConstraint.parse(requiredServerVersion);
}

final class OutdatedServerCheckerInitial extends OutdatedServerCheckerState {
  @override
  List<Object> get props => [];
}

final class OutdatedServerCheckerOutdated extends OutdatedServerCheckerState {
  const OutdatedServerCheckerOutdated(this.currentVersion);

  final Version currentVersion;

  @override
  List<Object> get props => [currentVersion];
}

final class OutdatedServerCheckerUpToDate extends OutdatedServerCheckerState {
  const OutdatedServerCheckerUpToDate(this.currentVersion);

  final Version currentVersion;

  @override
  List<Object> get props => [currentVersion];
}
