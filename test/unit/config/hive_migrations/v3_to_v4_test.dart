import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/backup_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

void main() {
  setUp(setUpInMemoryHive);
  tearDown(tearDownInMemoryHive);

  for (final scenario in ['first server', 'orphan', 'existing map']) {
    test('v3 bucket migration preserves $scenario across reopening', () async {
      final resources = await Hive.openBox(BNames.resourcesBox);
      final settings = await Hive.openBox(BNames.appSettingsBox);
      await settings.put(BNames.databaseVersion, 3);
      await settings.put(BNames.activeServerUuid, 'second');
      await resources.put(
        BNames.servers,
        scenario == 'orphan'
            ? []
            : [aServer(uuid: 'first'), aServer(uuid: 'second')],
      );
      final legacy = aBackblazeBucket();
      await resources.put(BNames.backblazeBucket, legacy);
      if (scenario == 'existing map') {
        await resources.put('backblazeBuckets', {
          'first': legacy.copyWith(bucketId: 'already-migrated'),
          'second': legacy.copyWith(bucketId: 'second-bucket'),
        });
      }
      await HiveConfig.performMigrations();
      await resources.close();
      final reopened = await Hive.openBox(BNames.resourcesBox);
      final buckets = Map<String, BackblazeBucket>.from(
        reopened.get('backblazeBuckets', defaultValue: {}) as Map,
      );
      expect(settings.get(BNames.databaseVersion), 4);
      expect(
        (reopened.get(BNames.backblazeBucket) as BackblazeBucket).bucketId,
        legacy.bucketId,
      );
      if (scenario == 'orphan') {
        expect(buckets, isEmpty);
      } else if (scenario == 'existing map') {
        expect(buckets['first']!.bucketId, 'already-migrated');
        expect(buckets['second']!.bucketId, 'second-bucket');
      } else {
        expect(buckets.keys, ['first']);
        expect(buckets['first']!.bucketId, legacy.bucketId);
      }
      await HiveConfig.performMigrations();
      expect(settings.get(BNames.activeServerUuid), 'second');
    });
  }
}
