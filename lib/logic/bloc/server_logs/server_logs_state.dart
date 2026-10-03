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
  ServerLogsLoaded({
    required final List<ServerLogEntry> oldEntries,
    required final List<ServerLogEntry> newEntries,
    required this.meta,
    required this.loadingMore,
    this.slice,
    this.unit,
  }) : oldEntries = List.unmodifiable(oldEntries),
       newEntries = List.unmodifiable(newEntries);

  final List<ServerLogEntry> oldEntries;
  final List<ServerLogEntry> newEntries;
  final ServerLogsPageMeta meta;
  final bool loadingMore;
  final String? slice;
  final String? unit;

  List<String> get systemdUnits => oldEntries
      .map((final entry) => entry.systemdUnit ?? 'kernel')
      .toSet()
      .toList();

  List<ServerLogEntry> oldEntriesForUnit(final String unit) {
    if (unit == 'kernel') {
      final filteredEntries = oldEntries
          .where((final entry) => entry.systemdUnit == null)
          .toList();
      return filteredEntries;
    }
    final filteredEntries = oldEntries
        .where((final entry) => entry.systemdUnit == unit)
        .toList();
    return filteredEntries;
  }

  List<ServerLogEntry> newEntriesForUnit(final String unit) {
    if (unit == 'kernel') {
      final filteredEntries = newEntries
          .where((final entry) => entry.systemdUnit == null)
          .toList();
      return filteredEntries;
    }
    final filteredEntries = newEntries
        .where((final entry) => entry.systemdUnit == unit)
        .toList();
    return filteredEntries;
  }

  @override
  List<Object?> get props => [
    oldEntries,
    newEntries,
    meta,
    loadingMore,
    slice,
    unit,
  ];
}

final class ServerLogsError extends ServerLogsState {
  const ServerLogsError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
