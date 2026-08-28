import 'package:sp_vcr/sp_vcr.dart';

Mode vcrModeFromEnvironment(final Map<String, String> environment) {
  final raw = environment['VCR_MODE'];
  if (raw == null || raw.isEmpty) {
    return Mode.replay;
  }

  return switch (raw) {
    'record' => Mode.record,
    'replay' => Mode.replay,
    'auto' => Mode.auto,
    'bypass' => Mode.bypass,
    _ => throw ArgumentError.value(
      raw,
      'VCR_MODE',
      'Expected record, replay, auto, or bypass.',
    ),
  };
}
