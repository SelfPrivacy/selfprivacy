import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

class TelemetrySettings extends Equatable {
  TelemetrySettings({
    required this.enable,
    required this.endpoint,
    required this.uploadSystemLogs,
    required this.uploadSystemMetrics,
    required final Iterable<String> headerNames,
    required this.memoryTracingEnabled,
  }) : headerNames = List.unmodifiable(headerNames);

  TelemetrySettings.fromGraphQL(final Fragment$telemetryFields value)
    : this(
        enable: value.enable,
        endpoint: value.endpoint,
        uploadSystemLogs: value.uploadSystemLogs,
        uploadSystemMetrics: value.uploadSystemMetrics,
        headerNames: value.headerNames,
        memoryTracingEnabled: value.memoryTracingEnabled,
      );

  final bool enable;
  final String? endpoint;
  final bool uploadSystemLogs;
  final bool uploadSystemMetrics;
  final List<String> headerNames;
  final bool memoryTracingEnabled;

  @override
  bool get stringify => false;
  @override
  List<Object?> get props => [
    enable,
    endpoint,
    uploadSystemLogs,
    uploadSystemMetrics,
    headerNames,
    memoryTracingEnabled,
  ];
}

class TelemetryUpdate extends Equatable {
  TelemetryUpdate({
    required this.enable,
    required this.endpoint,
    required this.uploadSystemLogs,
    required this.uploadSystemMetrics,
    required final Map<String, String?> headers,
  }) : headers = Map.unmodifiable(headers);

  TelemetryUpdate.fromSettings(final TelemetrySettings settings)
    : this(
        enable: settings.enable,
        endpoint: settings.endpoint,
        uploadSystemLogs: settings.uploadSystemLogs,
        uploadSystemMetrics: settings.uploadSystemMetrics,
        headers: const {},
      );

  final bool enable;
  final String? endpoint;
  final bool uploadSystemLogs;
  final bool uploadSystemMetrics;
  final Map<String, String?> headers;

  @override
  bool get stringify => false;
  @override
  List<Object?> get props => [
    enable,
    endpoint,
    uploadSystemLogs,
    uploadSystemMetrics,
    headers,
  ];
}
