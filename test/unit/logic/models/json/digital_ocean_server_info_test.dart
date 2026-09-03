import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/models/json/digital_ocean_server_info.dart';

import '../../../../helpers/fixtures/json_fixture.dart';

void main() {
  test('parses DigitalOcean volumes with optional fields omitted', () {
    final completeVolume = loadJsonFixtureItem(
      'server_providers/digital_ocean/volumes.json',
      'volumes',
    );

    for (final field in ['id', 'name', 'size_gigabytes', 'region']) {
      final json = Map<String, dynamic>.from(completeVolume)..remove(field);

      final volume = DigitalOceanVolume.fromJson(json);

      switch (field) {
        case 'id':
          expect(volume.id, isNull);
        case 'name':
          expect(volume.name, isNull);
        case 'size_gigabytes':
          expect(volume.sizeGigabytes, isNull);
        case 'region':
          expect(volume.region, isNull);
      }
    }
  });

  test('parses DigitalOcean server types without regions', () {
    final json = Map<String, dynamic>.from(
      (loadJsonFixture('server_providers/digital_ocean/sizes.json')['sizes']
                  as List<dynamic>)
              .first
          as Map<String, dynamic>,
    )..remove('regions');

    final serverType = DigitalOceanServerType.fromJson(json);

    expect(serverType.regions, isNull);
  });
}
