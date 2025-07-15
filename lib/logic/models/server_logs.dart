import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/logs.graphql.dart';

class ServerLogEntry extends Equatable {
  const ServerLogEntry({
    required this.message,
    required this.cursor,
    required this.priority,
    required this.systemdSlice,
    required this.systemdUnit,
    required this.timestamp,
  });

  ServerLogEntry.fromGraphQL(final Fragment$LogEntry log)
    : this(
        message: log.message,
        cursor: log.cursor,
        priority: log.priority,
        systemdSlice: log.systemdSlice,
        systemdUnit: log.systemdUnit,
        timestamp: log.timestamp,
      );

  final String message;
  final String cursor;
  final int? priority;
  final String? systemdSlice;
  final String? systemdUnit;
  final DateTime timestamp;

  static final DateFormat _formatter = DateFormat('HH:mm:ss');
  String get utcTimeString => _formatter.format(timestamp);
  String get localTimeString => _formatter.format(timestamp.toLocal());
  String localDateString(final String locale) =>
      DateFormat.yMMMMEEEEd(locale).format(timestamp.toLocal());
  String get fullUTCString => timestamp.toUtc().toIso8601String();

  @override
  List<Object?> get props => [
    message,
    cursor,
    priority,
    systemdSlice,
    systemdUnit,
    timestamp,
  ];
}

class ServerLogsPageMeta extends Equatable {
  const ServerLogsPageMeta({required this.downCursor, required this.upCursor});

  ServerLogsPageMeta.fromGraphQL(final Query$Logs$logs$paginated$pageMeta meta)
    : this(downCursor: meta.downCursor, upCursor: meta.upCursor);

  final String? downCursor;
  final String? upCursor;

  @override
  List<Object?> get props => [downCursor, upCursor];
}
