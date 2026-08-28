import 'package:flutter_test/flutter_test.dart';
import 'package:sp_vcr/sp_vcr.dart';

import '../../../helpers/vcr/vcr_mode.dart';

void main() {
  test('defaults to replay when VCR_MODE is absent or empty', () {
    expect(vcrModeFromEnvironment(const <String, String>{}), Mode.replay);
    expect(
      vcrModeFromEnvironment(const <String, String>{'VCR_MODE': ''}),
      Mode.replay,
    );
  });

  test('maps every supported VCR_MODE value', () {
    expect(
      vcrModeFromEnvironment(const <String, String>{'VCR_MODE': 'record'}),
      Mode.record,
    );
    expect(
      vcrModeFromEnvironment(const <String, String>{'VCR_MODE': 'replay'}),
      Mode.replay,
    );
    expect(
      vcrModeFromEnvironment(const <String, String>{'VCR_MODE': 'auto'}),
      Mode.auto,
    );
    expect(
      vcrModeFromEnvironment(const <String, String>{'VCR_MODE': 'bypass'}),
      Mode.bypass,
    );
  });

  test('rejects unsupported VCR_MODE values', () {
    expect(
      () =>
          vcrModeFromEnvironment(const <String, String>{'VCR_MODE': 'invalid'}),
      throwsA(
        isA<ArgumentError>()
            .having((final error) => error.name, 'name', 'VCR_MODE')
            .having(
              (final error) => error.message,
              'message',
              'Expected record, replay, auto, or bypass.',
            ),
      ),
    );
  });
}
