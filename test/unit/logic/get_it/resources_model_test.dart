import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';

Server _aServer({final int id = 1, final String domain = 'example.com'}) =>
    Server(
      hostingDetails: ServerHostingDetails(
        ip4: '1.2.3.4',
        id: id,
        createTime: DateTime.utc(2026),
        volume: ServerProviderVolume(
          id: 1,
          name: 'volume',
          sizeByte: 10737418240,
          serverId: id,
          linuxDevice: '/dev/sdb',
        ),
        apiToken: 'api-token',
        provider: ServerProviderType.hetzner,
      ),
      domain: ServerDomain(
        domainName: domain,
        provider: DnsProviderType.cloudflare,
      ),
    );

BackupsCredential _aBackupsCredential({final String keyId = 'key-id'}) =>
    BackupsCredential(
      keyId: keyId,
      applicationKey: 'application-key',
      provider: BackupsProviderType.backblaze,
    );

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

      await model.associateServerWithToken(42, 'srv-a');

      expect(
        model.serverProviderCredentials.single.associatedServerIds,
        contains(42),
      );

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(
        reloaded.serverProviderCredentials.single.associatedServerIds,
        contains(42),
      );
    });

    test('associateServerWithToken throws when the token is unknown', () async {
      await expectLater(
        model.associateServerWithToken(1, 'missing'),
        throwsStateError,
      );
    });

    test('removeServerProviderToken drops the credential', () async {
      final credential = aServerProviderCredential(token: 'srv-a');
      await model.addServerProviderToken(credential);

      await model.removeServerProviderToken(credential);

      expect(model.serverProviderCredentials, isEmpty);
    });
  });

  group('dns provider tokens', () {
    test('addDnsProviderToken stores and persists the credential', () async {
      await model.addDnsProviderToken(aDnsProviderCredential(token: 'dns-a'));

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
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
      final credential = aDnsProviderCredential(token: 'dns-a');
      await model.addDnsProviderToken(credential);

      await model.removeDnsProviderToken(credential);

      expect(model.dnsProviderCredentials, isEmpty);
    });
  });

  group('servers, backups and bucket', () {
    test('addServer / removeServer round-trips', () async {
      final server = _aServer();
      await model.addServer(server);
      expect(model.servers, hasLength(1));

      final reloaded = ResourcesModel()..init();
      addTearDown(reloaded.dispose);
      expect(reloaded.servers.single.domain.domainName, 'example.com');

      await model.removeServer(server);
      expect(model.servers, isEmpty);
    });

    test(
      'addBackupsCredential / removeBackupsCredential round-trips',
      () async {
        final credential = _aBackupsCredential();
        await model.addBackupsCredential(credential);
        expect(model.backupsCredentials, hasLength(1));

        await model.removeBackupsCredential(credential);
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
      await model.addServer(_aServer());
      await model.addBackupsCredential(_aBackupsCredential());
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
