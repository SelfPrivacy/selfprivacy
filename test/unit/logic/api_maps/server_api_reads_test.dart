import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/require_server_api_data.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/service.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/connection_fixture.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  final metricsReads = <String, Future<Object> Function(ServerApi)>{
    'overall': (final api) => api.getServerMetrics(
      step: 60,
      start: DateTime.utc(2026),
      end: DateTime.utc(2026, 1, 2),
    ),
    'memory': (final api) => api.getMemoryMetrics(
      step: 60,
      start: DateTime.utc(2026),
      end: DateTime.utc(2026, 1, 2),
    ),
    'disk': (final api) => api.getDiskMetrics(
      step: 60,
      start: DateTime.utc(2026),
      end: DateTime.utc(2026, 1, 2),
    ),
  };
  for (final entry in metricsReads.entries) {
    test('${entry.key} metrics preserve wrapped dispatch deferral', () async {
      final api = ServerApi(
        transport: transportWithLink(
          Link.function(
            (_, [final forward]) =>
                Stream.error(const GraphQLDispatchDeferred()),
          ),
        ),
      );
      await expectLater(
        entry.value(api),
        throwsA(isA<GraphQLDispatchDeferred>()),
      );
    });
  }

  final reads = <String, Future<Object> Function(ServerApi)>{
    'GetApiVersion': (final api) => api.fetchApiVersion(),
    'AllUsers': (final api) => api.getAllUsers(),
    'AllGroups': (final api) => api.getAllGroups(),
    'GetApiJobs': (final api) => api.getServerJobs(),
    'GetApiTokens': (final api) => api.getApiTokens(),
    'RecoveryKey': (final api) => api.getRecoveryTokenStatus(),
    'SystemSettings': (final api) => api.getSystemSettings(),
    'BackupConfiguration': (final api) => api.getBackupsConfiguration(),
    'AllBackupSnapshots': (final api) => api.getBackups(),
    'GetServerDiskVolumes': (final api) => api.getServerDiskVolumes(),
    'AllServices': (final api) => api.getAllServices(),
  };
  Map<String, dynamic> fixture(final String operation) =>
      loadJsonFixture('graphql/domain_reads.json')[operation]
          as Map<String, dynamic>;

  ServerApi apiReturning(final Response response) => ServerApi(
    transport: transportWithLink(
      Link.function((final request, [final forward]) => Stream.value(response)),
    ),
  );

  for (final entry in reads.entries) {
    group(entry.key, () {
      test('maps a complete response', () async {
        final api = apiReturning(
          Response(response: const {}, data: fixture(entry.key)),
        );
        final result = await entry.value(api);
        expect(result, isNotNull);
        if (result is List) {
          expect(result, isNotEmpty);
        }
      });

      test('rejects partial data accompanied by GraphQL errors', () async {
        const error = GraphQLError(message: 'Access denied');
        final api = apiReturning(
          Response(
            response: const {},
            data: fixture(entry.key),
            errors: const [error],
          ),
        );
        await expectLater(
          entry.value(api),
          throwsA(
            isA<OperationException>().having(
              (final error) => error.graphqlErrors.single.message,
              'original message',
              'Access denied',
            ),
          ),
        );
      });

      test('rejects missing required fields', () async {
        final data = fixture(entry.key);
        data.remove(data.keys.firstWhere((final key) => key != '__typename'));
        await expectLater(
          entry.value(apiReturning(Response(response: const {}, data: data))),
          throwsA(anything),
        );
      });

      test('preserves transport failures', () async {
        final error = StateError('transport failed');
        final api = ServerApi(
          transport: transportWithLink(
            Link.function(
              (final request, [final forward]) => Stream.error(error),
            ),
          ),
        );
        await expectLater(
          entry.value(api),
          throwsA(
            isA<OperationException>().having(
              (final exception) => exception.linkException?.originalException,
              'original error',
              same(error),
            ),
          ),
        );
      });
    });
  }

  test('maps domain fields without fabricated defaults', () async {
    final api = ServerApi(
      transport: transportWithLink(
        Link.function(
          (final request, [final forward]) => Stream.value(
            Response(
              response: const {},
              data: fixture(
                request.operation.document.definitions
                    .whereType<OperationDefinitionNode>()
                    .single
                    .name!
                    .value,
              ),
            ),
          ),
        ),
      ),
    );
    expect(await api.fetchApiVersion(), '3.9.0');
    expect((await api.getAllUsers()).map((final user) => user.login), [
      'alice',
      'bob',
      'root',
    ]);
    expect(await api.getAllGroups(), [
      'sp.nextcloud.users',
      'sp.full_users',
      'sp.admins',
      'sp.nextcloud.admins',
      'sp.roundcube.admins',
      'sp.roundcube.users',
      'sp.outline.users',
      'sp.vikunja.users',
    ]);
    expect((await api.getServerJobs()).single.progress, 25);
    expect((await api.getApiTokens()).first.name, 'Laptop');
    expect((await api.getRecoveryTokenStatus()).exists, isFalse);
    final settings = await api.getSystemSettings();
    expect(settings.timezone, 'Europe/Moscow');
    expect(settings.sshSettings.enable, isTrue);
    final backups = await api.getBackupsConfiguration();
    expect(backups.autobackupPeriod, const Duration(hours: 1));
    expect(backups.autobackupQuotas.daily, 7);
    expect((await api.getBackups()).single.id, 'snapshot-1');
    expect((await api.getServerDiskVolumes()).first.name, 'sda');
    expect((await api.getAllServices()).first.id, 'example-app');
  });

  test(
    'maps primary, normal and root users with nullable profile fields',
    () async {
      final users = await apiReturning(
        Response(response: const {}, data: fixture('AllUsers')),
      ).getAllUsers();
      expect(users.map((final user) => user.type), [
        UserType.primary,
        UserType.normal,
        UserType.root,
      ]);
      expect(users.first.displayName, 'Alice');
      expect(users.first.email, 'alice@example.org');
      expect(users.first.directmemberof, ['sp.admins']);
      expect(users[1].directmemberof, ['sp.full_users']);
      expect(
        users.first.memberof,
        containsAll([
          'sp.nextcloud.admins',
          'sp.nextcloud.users',
          'ext_idm_provisioned_entities',
        ]),
      );
      expect(users.last.displayName, isNull);
      expect(users.last.email, isNull);
      expect(users.last.emailPasswordMetadata, isEmpty);
    },
  );

  test(
    'maps caller and other devices with timezone-aware creation dates',
    () async {
      final devices = await apiReturning(
        Response(response: const {}, data: fixture('GetApiTokens')),
      ).getApiTokens();
      expect(devices.map((final device) => device.isCaller), [true, false]);
      expect(devices.first.date, DateTime.utc(2026, 9, 1, 10));
      expect(devices.last.name, 'Phone');
    },
  );

  test(
    'maps root and attached volumes with nullable hardware metadata',
    () async {
      final volumes = await apiReturning(
        Response(response: const {}, data: fixture('GetServerDiskVolumes')),
      ).getServerDiskVolumes();
      expect(volumes.map((final volume) => volume.root), [false, true]);
      expect(volumes.first.serial, 'fixture-disk');
      expect(volumes.last.model, isNull);
      expect(volumes.last.serial, isNull);
      expect(volumes.last.totalSpace, '1073741824');
    },
  );

  test(
    'maps service configuration variants, DNS, licenses and null configuration',
    () async {
      final services = await apiReturning(
        Response(response: const {}, data: fixture('AllServices')),
      ).getAllServices();
      final app = services.first;
      expect(app.status, ServiceStatus.inactive);
      expect(app.isInstalled, isFalse);
      expect(app.svgIcon, '<svg/>');
      expect(app.license, isNotEmpty);
      expect(app.storageUsage.used.byte, 1048576);
      final strings = app.configuration
          .whereType<StringServiceConfigItem>()
          .toList();
      expect(strings.first.widget, 'subdomain');
      expect(strings.first.value, 'app');
      expect(strings.first.regex, isNotNull);
      expect(strings.last.regex, isNull);
      expect(
        app.configuration.whereType<BoolServiceConfigItem>().single.value,
        isTrue,
      );
      final choice = app.configuration
          .whereType<EnumServiceConfigItem>()
          .single;
      expect(choice.value, 'dark');
      expect(choice.defaultValue, 'light');
      expect(choice.options, ['light', 'dark']);
      final mail = services[1];
      expect(mail.status, ServiceStatus.active);
      expect(mail.configuration, isEmpty);
      expect(
        mail.dnsRecords.map((final record) => record.type),
        containsAll(['A', 'MX', 'TXT']),
      );
      expect(
        mail.dnsRecords
            .firstWhere((final record) => record.type == 'MX')
            .content,
        'mail.example.org',
      );
      expect(services.last.isSystemService, isTrue);
      expect(services.last.configuration, isEmpty);
    },
  );

  test(
    'maps captured empty jobs and snapshots with disabled autobackups',
    () async {
      final captured = loadJsonFixture('graphql/empty_backup_and_jobs.json');
      ServerApi apiFor(final String operation) => apiReturning(
        Response(
          response: const {},
          data: captured[operation] as Map<String, dynamic>,
        ),
      );
      expect(await apiFor('GetApiJobs').getServerJobs(), isEmpty);
      expect(await apiFor('AllBackupSnapshots').getBackups(), isEmpty);
      final config = await apiFor(
        'BackupConfiguration',
      ).getBackupsConfiguration();
      expect(config.isInitialized, isTrue);
      expect(config.autobackupPeriod, isNull);
      expect(config.autobackupQuotas.last, -1);
      expect(config.autobackupQuotas.daily, -1);
      expect(config.autobackupQuotas.weekly, -1);
      expect(config.autobackupQuotas.monthly, -1);
      expect(config.autobackupQuotas.yearly, -1);
    },
  );

  final lists = {
    'AllUsers': ('users', 'allUsers'),
    'AllGroups': ('groups', 'allGroups'),
    'GetApiJobs': ('jobs', 'getJobs'),
    'GetApiTokens': ('api', 'devices'),
    'AllBackupSnapshots': ('backup', 'allSnapshots'),
    'GetServerDiskVolumes': ('storage', 'volumes'),
    'AllServices': ('services', 'allServices'),
  };
  for (final entry in lists.entries) {
    test('${entry.key} accepts a genuinely empty collection', () async {
      final data = fixture(entry.key);
      final domain = data[entry.value.$1] as Map<String, dynamic>;
      domain[entry.value.$2] = <dynamic>[];
      if (entry.key == 'AllUsers') {
        domain['rootUser'] = null;
      }
      expect(
        await reads[entry.key]!(
          apiReturning(Response(response: const {}, data: data)),
        ),
        isEmpty,
      );
    });
  }

  test('legacy version probe returns null on a partial response', () async {
    final api = apiReturning(
      Response(
        response: const {},
        data: fixture('GetApiVersion'),
        errors: const [GraphQLError(message: 'Failed')],
      ),
    );
    expect(await api.getApiVersion(), isNull);
  });

  test('domain cache retains settings when a strict read fails', () async {
    var fail = false;
    final api = ServerApi(
      transport: transportWithLink(
        Link.function(
          (final request, [final forward]) => Stream.value(
            Response(
              response: const {},
              data: fixture('SystemSettings'),
              errors: fail ? const [GraphQLError(message: 'Failed')] : null,
            ),
          ),
        ),
      ),
    );
    final connection = seededConnection(api);
    addTearDown(connection.dispose);
    final settings = connection.settings;
    await settings.refresh();
    final previous = settings.value.data;
    fail = true;
    settings.invalidate();
    await settings.refresh();
    expect(settings.value.data, same(previous));
    expect(settings.value.data!.timezone, 'Europe/Moscow');
    expect(settings.value.lastError, isA<OperationException>());
  });

  test('response validation identifies absent data', () {
    final result = QueryResult<Object>(
      source: QueryResultSource.network,
      options: QueryOptions<Object>(
        document: gql('query Test { field }'),
        parserFn: (final data) => data,
      ),
    );
    expect(
      () => requireServerApiData(result),
      throwsA(isA<MissingServerApiData>()),
    );
  });

  test(
    'jobs stream rejects bad updates and accepts subsequent valid data',
    () async {
      final responses = StreamController<Response>();
      addTearDown(responses.close);
      final api = ServerApi(
        transport: transportWithLink(
          Link.function((final request, [final forward]) => responses.stream),
        ),
      );
      final events = <Object>[];
      final received = Completer<void>();
      final subscription = api.getServerJobsStream().listen((final jobs) {
        events.add(jobs);
        if (events.length == 4) {
          received.complete();
        }
      }, onError: events.add);
      addTearDown(subscription.cancel);
      responses
        ..add(
          Response(
            response: const {},
            data: fixture('JobUpdates'),
            errors: const [GraphQLError(message: 'Partial jobs')],
          ),
        )
        ..add(
          const Response(response: {}, data: {'__typename': 'Subscription'}),
        )
        ..add(Response(response: const {}, data: fixture('JobUpdates')))
        ..add(
          const Response(
            response: {},
            data: {'__typename': 'Subscription', 'jobUpdates': []},
          ),
        );
      await received.future;
      expect(events[0], isA<OperationException>());
      expect(events[1], isA<TypeError>());
      expect(events[2], hasLength(1));
      expect(events[3], isEmpty);
    },
  );

  test('response validation preserves exception identity', () {
    final error = OperationException(
      graphqlErrors: const [GraphQLError(message: 'Failed')],
    );
    final result = QueryResult<Object>(
      source: QueryResultSource.network,
      options: QueryOptions<Object>(
        document: gql('query Test { field }'),
        parserFn: (final data) => data,
      ),
      exception: error,
    );
    expect(() => requireServerApiData(result), throwsA(same(error)));
  });

  test(
    'domain mapping errors escape instead of yielding partial services',
    () async {
      final data = fixture('AllServices');
      final services =
          (data['services'] as Map<String, dynamic>)['allServices']
              as List<dynamic>;
      final service = services.first as Map<String, dynamic>;
      (service['storageUsage'] as Map<String, dynamic>)['usedSpace'] =
          'invalid';
      await expectLater(
        apiReturning(Response(response: const {}, data: data)).getAllServices(),
        throwsFormatException,
      );
    },
  );
}
