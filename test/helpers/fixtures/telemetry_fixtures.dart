import 'package:selfprivacy/logic/models/telemetry_settings.dart';

TelemetrySettings aTelemetrySettings({
  final bool enable = false,
  final String? endpoint = 'https://collector.example.org:4317',
  final bool logs = true,
  final bool metrics = true,
  final List<String> headerNames = const ['authorization', 'obsolete'],
  final bool memoryTracingEnabled = false,
}) => TelemetrySettings(
  enable: enable,
  endpoint: endpoint,
  uploadSystemLogs: logs,
  uploadSystemMetrics: metrics,
  headerNames: headerNames,
  memoryTracingEnabled: memoryTracingEnabled,
);

TelemetryUpdate aTelemetryUpdate({
  final bool enable = true,
  final String? endpoint = 'https://collector.example.org:4317',
  final bool logs = false,
  final bool metrics = true,
  final Map<String, String?> headers = const {
    'authorization': 'input-secret',
    'obsolete': null,
  },
}) => TelemetryUpdate(
  enable: enable,
  endpoint: endpoint,
  uploadSystemLogs: logs,
  uploadSystemMetrics: metrics,
  headers: headers,
);
