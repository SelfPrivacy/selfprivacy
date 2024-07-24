part of 'server_logs_bloc.dart';

sealed class ServerLogsState extends Equatable {
  const ServerLogsState();
}

final class ServerLogsInitial extends ServerLogsState {
  @override
  List<Object> get props => [];
}

final class ServerLogsLoading extends ServerLogsState {
  @override
  List<Object> get props => [];
}

final class ServerLogsLoaded extends ServerLogsState {
  const ServerLogsLoaded(this.entries, this.meta, this.loadingMore);

  final List<ServerLogEntry> entries;
  final ServerLogsPageMeta meta;
  final bool loadingMore;

  List<String> get systemdUnits => entries
      .map((final entry) => entry.systemdUnit ?? 'kernel')
      .toSet()
      .toList();

  (List<ServerLogEntry>, int) entriesForUnit(final String unit) {
    if (unit == 'kernel') {
      final filteredEntries =
          entries.where((final entry) => entry.systemdUnit == null).toList();
      return (filteredEntries, filteredEntries.length);
    }
    final filteredEntries =
        entries.where((final entry) => entry.systemdUnit == unit).toList();
    return (filteredEntries, filteredEntries.length);
  }

  @override
  List<Object> get props => [entries, meta];
}

final class ServerLogsError extends ServerLogsState {
  const ServerLogsError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
