import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

BackblazeBucket _aBackblazeBucket() => BackblazeBucket(
  bucketId: 'bucket-id',
  bucketName: 'bucket-name',
  applicationKeyId: 'app-key-id',
  applicationKey: 'app-key',
  encryptionKey: 'encryption-key',
);

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);

  late ResourcesModel model;

  setUp(() async {
    await Hive.openBox(BNames.resourcesBox);
    model = ResourcesModel()..init();
  });

  tearDown(() async {
    await model.dispose();
    final Box box = Hive.box(BNames.resourcesBox);
    await box.clear();
    await box.close();
  });

  group('server provider tokens', () {
    test('addServerProviderToken stores and persists the credential', () async {
      await model.addServerProviderToken(
        aServerProviderCredential(token: 'srv-a'),
      );

      expect(
        model.serverProviderCredentials.map((final c) => c.token),
        contains('srv-a'),
      );

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(
        reloaded.serverProviderCredentials.single.uuid,
        'server-credential-uuid',
      );
      expect(
        reloaded.serverProviderCredentials.map((final c) => c.token),
        contains('srv-a'),
      );
    });

    test('addServerProviderToken emits a change event', () async {
      final expectation = expectLater(
        model.statusStream,
        emits(isA<ChangedServerProviderCredentials>()),
      );
      await model.addServerProviderToken(aServerProviderCredential());
      await expectation;
    });

    test('associateServerWithToken links the server and persists it', () async {
      await model.addServerProviderToken(
        aServerProviderCredential(token: 'srv-a'),
      );

      await model.associateServerWithToken('server-a', 'srv-a');

      expect(
        model.serverProviderCredentials.single.associatedServerUuids,
        contains('server-a'),
      );

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(
        reloaded.serverProviderCredentials.single.associatedServerUuids,
        contains('server-a'),
      );
    });

    test('associateServerWithToken throws when the token is unknown', () async {
      await expectLater(
        model.associateServerWithToken('server-a', 'missing'),
        throwsStateError,
      );
    });

    test('removeServerProviderToken drops the credential', () async {
      await model.addServerProviderToken(
        aServerProviderCredential(uuid: 'server-credential-a', token: 'srv-a'),
      );

      await model.removeServerProviderToken(
        aServerProviderCredential(
          uuid: 'server-credential-a',
          token: 'changed-token',
        ),
      );

      expect(model.serverProviderCredentials, isEmpty);
    });
  });

  group('dns provider tokens', () {
    test('addDnsProviderToken stores and persists the credential', () async {
      await model.addDnsProviderToken(aDnsProviderCredential(token: 'dns-a'));

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(
        reloaded.dnsProviderCredentials.single.uuid,
        'dns-credential-uuid',
      );
      expect(
        reloaded.dnsProviderCredentials.map((final c) => c.token),
        contains('dns-a'),
      );
    });

    test('addDnsProviderToken rejects a duplicate token', () async {
      await model.addDnsProviderToken(aDnsProviderCredential(token: 'dns-a'));

      await expectLater(
        model.addDnsProviderToken(aDnsProviderCredential(token: 'dns-a')),
        throwsA(isA<Exception>()),
      );
    });

    test(
      'associateDomainWithCredential links the domain and persists it',
      () async {
        await model.addDnsProviderToken(aDnsProviderCredential(token: 'dns-a'));

        await model.associateDomainWithCredential(
          'example.com',
          aDnsProviderCredential(token: 'dns-a'),
        );

        expect(
          model.dnsProviderCredentials.single.associatedDomainNames,
          contains('example.com'),
        );
      },
    );

    test(
      'associateDomainWithCredential throws when the token is unknown',
      () async {
        await expectLater(
          model.associateDomainWithCredential(
            'example.com',
            aDnsProviderCredential(token: 'missing'),
          ),
          throwsStateError,
        );
      },
    );

    test('removeDnsProviderToken drops the credential', () async {
      await model.addDnsProviderToken(
        aDnsProviderCredential(uuid: 'dns-credential-a', token: 'dns-a'),
      );

      await model.removeDnsProviderToken(
        aDnsProviderCredential(
          uuid: 'dns-credential-a',
          token: 'changed-token',
        ),
      );

      expect(model.dnsProviderCredentials, isEmpty);
    });
  });

  group('servers, backups and bucket', () {
    test('addServer and removeServer use the server UUID', () async {
      final server = aServer(uuid: 'server-a');
      await model.addServer(server);
      expect(model.servers, hasLength(1));

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(reloaded.servers.single.uuid, 'server-a');
      expect(reloaded.servers.single.domain.domainName, 'example.org');

      await model.removeServer(
        aServer(
          uuid: 'server-a',
          domain: aServerDomain(domainName: 'new.test'),
        ),
      );
      expect(model.servers, isEmpty);
    });

    test(
      'updateServerByUuid preserves identity when the domain changes',
      () async {
        await model.addServer(aServer(uuid: 'server-a'));

        await model.updateServerByUuid(
          aServer(
            uuid: 'server-a',
            domain: aServerDomain(domainName: 'updated.example.org'),
          ),
        );

        expect(model.servers, hasLength(1));
        expect(model.servers.single.uuid, 'server-a');
        expect(model.servers.single.domain.domainName, 'updated.example.org');
      },
    );

    test(
      'addBackupsCredential / removeBackupsCredential round-trips',
      () async {
        final credential = aBackupsCredential(uuid: 'backups-credential-a');
        await model.addBackupsCredential(credential);
        expect(model.backupsCredentials, hasLength(1));

        final reloaded = ResourcesModel()..init();
        addTearDown(reloaded.dispose);
        expect(reloaded.backupsCredentials.single.uuid, 'backups-credential-a');

        await model.removeBackupsCredential(
          aBackupsCredential(
            uuid: 'backups-credential-a',
            keyId: 'changed-key-id',
          ),
        );
        expect(model.backupsCredentials, isEmpty);
      },
    );

    test('setBackblazeBucket / removeBackblazeBucket round-trips', () async {
      await model.setBackblazeBucket(_aBackblazeBucket());
      expect(model.backblazeBucket?.bucketName, 'bucket-name');

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(reloaded.backblazeBucket?.bucketName, 'bucket-name');

      await model.removeBackblazeBucket();
      expect(model.backblazeBucket, isNull);
    });
  });

  group('lifecycle', () {
    test('clear empties every collection', () async {
      await model.addServerProviderToken(aServerProviderCredential());
      await model.addDnsProviderToken(aDnsProviderCredential());
      await model.addServer(aServer());
      await model.addBackupsCredential(aBackupsCredential());
      await model.setBackblazeBucket(_aBackblazeBucket());

      await model.clear();

      expect(model.serverProviderCredentials, isEmpty);
      expect(model.dnsProviderCredentials, isEmpty);
      expect(model.servers, isEmpty);
      expect(model.backupsCredentials, isEmpty);
      expect(model.backblazeBucket, isNull);
    });
  });
}
