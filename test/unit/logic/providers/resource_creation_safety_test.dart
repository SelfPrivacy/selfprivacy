import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/provisioning_result.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _CreationClient {
  _CreationClient(
    this.provider,
    this.failure, {
    this.status = 201,
    this.missingId = false,
    this.unreadable = false,
    this.nameConflict = false,
  });

  final ServerProviderType provider;
  final ProvisioningStage failure;
  final int? status;
  final bool missingId;
  final bool unreadable;
  final bool nameConflict;
  final List<RequestOptions> requests = [];

  bool get _hetzner => provider == ServerProviderType.hetzner;

  Dio call(final BaseOptions options) => Dio(options)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (final request, final handler) {
          requests.add(request);
          final serverPath = _hetzner ? '/servers' : '/droplets';
          final stage = switch ((request.method, request.path)) {
            ('GET', _) => ProvisioningStage.discoverServers,
            ('POST', '/volumes') => ProvisioningStage.createVolume,
            ('POST', final path) when path == serverPath =>
              ProvisioningStage.createServer,
            _ => ProvisioningStage.attachVolume,
          };
          if (stage == failure && (status == null || status! >= 400)) {
            handler.reject(
              DioException(
                requestOptions: request,
                type: status == null
                    ? DioExceptionType.connectionError
                    : DioExceptionType.badResponse,
                response: status == null
                    ? null
                    : Response<dynamic>(
                        requestOptions: request,
                        statusCode: status,
                        data: {
                          'error': {
                            'code': nameConflict
                                ? 'uniqueness_error'
                                : 'rejected',
                          },
                        },
                      ),
              ),
            );
            return;
          }
          final volume = loadJsonFixtureItem(
            'server_providers/${_hetzner ? 'hetzner' : 'digital_ocean'}/volumes.json',
            'volumes',
          );
          final server = loadJsonFixtureItem(
            'server_providers/${_hetzner ? 'hetzner/servers' : 'digital_ocean/droplets'}.json',
            _hetzner ? 'servers' : 'droplets',
          )..['id'] = 7;
          if (unreadable && stage == failure) {
            if (stage == ProvisioningStage.createVolume) {
              volume.remove('name');
            } else {
              server.remove('server_type');
            }
          }
          if (missingId && stage == failure) {
            (stage == ProvisioningStage.createVolume ? volume : server).remove(
              'id',
            );
          }
          final data = switch ((request.method, request.path)) {
            ('GET', _) => {_hetzner ? 'servers' : 'droplets': <Object>[]},
            ('POST', '/volumes') => {'volume': volume},
            ('POST', final path) when path == serverPath => {
              _hetzner ? 'server' : 'droplet': server,
            },
            _ => {
              'action': {'status': 'errored'},
            },
          };
          handler.resolve(
            Response<dynamic>(
              requestOptions: request,
              statusCode: 201,
              data: data,
            ),
          );
        },
      ),
    );

  ServerProvider get instance =>
      ServerProviderFactory.createServerProviderInterface(
        ServerProviderSettings(
          provider: provider,
          credentials: const BearerTokenCredential(token: 'provider-token'),
        ),
        clientFactory: call,
      );
}

void main() {
  setUpAll(setUpInMemoryHive);
  tearDownAll(tearDownInMemoryHive);
  setUp(() async {
    await Hive.openBox(BNames.appSettingsBox);
    getIt
      ..registerSingleton<ConsoleModel>(ConsoleModel())
      ..registerSingleton<DeveloperSettingsModel>(DeveloperSettingsModel());
  });
  tearDown(() async {
    await getIt.reset();
    await Hive.box(BNames.appSettingsBox).clear();
    await Hive.box(BNames.appSettingsBox).close();
  });

  Future<ProvisioningFailed> provision(
    final _CreationClient client,
    final WidgetTester tester,
  ) async {
    final pending = client.instance.provisionServer(aProvisioningRequest());
    await tester.pump(Duration.zero);
    if (client.provider == ServerProviderType.digitalOcean) {
      await tester.pump(const Duration(seconds: 6));
    }
    final result = await pending;
    expect(result, isA<ProvisioningFailed>());
    expect(client.requests.where((final r) => r.method == 'DELETE'), isEmpty);
    return result as ProvisioningFailed;
  }

  testWidgets('Hetzner rejected server retains the confirmed volume', (
    final tester,
  ) async {
    final client = _CreationClient(
      ServerProviderType.hetzner,
      ProvisioningStage.createServer,
      status: 422,
    );
    final result = await provision(client, tester);
    expect(result.kind, ProvisioningFailureKind.rejected);
    expect(result.stage, ProvisioningStage.createServer);
    expect(result.code, 422);
    expect(result.resources.map((final r) => (r.kind, r.id)), [
      (ProvisionedResourceKind.volume, '41'),
    ]);
  });

  testWidgets('Hetzner name conflict never deletes resources', (
    final tester,
  ) async {
    final result = await provision(
      _CreationClient(
        ServerProviderType.hetzner,
        ProvisioningStage.createServer,
        status: 409,
        nameConflict: true,
      ),
      tester,
    );
    expect(result.kind, ProvisioningFailureKind.nameConflict);
    expect(result.resources.single.id, '41');
  });

  for (final missingId in [false, true]) {
    testWidgets(
      'Hetzner unreadable server preserves IDs (missing: $missingId)',
      (final tester) async {
        final result = await provision(
          _CreationClient(
            ServerProviderType.hetzner,
            ProvisioningStage.createServer,
            unreadable: true,
            missingId: missingId,
          ),
          tester,
        );
        expect(result.kind, ProvisioningFailureKind.unreadable);
        expect(result.resources.map((final r) => (r.kind, r.id)), [
          (ProvisionedResourceKind.volume, '41'),
          (ProvisionedResourceKind.server, missingId ? null : '7'),
        ]);
      },
    );
  }

  testWidgets('DigitalOcean failed discovery creates nothing', (
    final tester,
  ) async {
    final client = _CreationClient(
      ServerProviderType.digitalOcean,
      ProvisioningStage.discoverServers,
      status: null,
    );
    final result = await provision(client, tester);
    expect(result.kind, ProvisioningFailureKind.unavailable);
    expect(result.resources, isEmpty);
    expect(client.requests.map((final r) => r.method), ['GET']);
  });

  testWidgets('DigitalOcean unreadable volume retains both created IDs', (
    final tester,
  ) async {
    final result = await provision(
      _CreationClient(
        ServerProviderType.digitalOcean,
        ProvisioningStage.createVolume,
        unreadable: true,
      ),
      tester,
    );
    expect(result.kind, ProvisioningFailureKind.unreadable);
    expect(result.resources.map((final r) => (r.kind, r.id)), [
      (ProvisionedResourceKind.server, '7'),
      (ProvisionedResourceKind.volume, '7724db7c-e098-11e5-b522-000f53304e51'),
    ]);
  });

  testWidgets(
    'DigitalOcean attach failure retains exact IDs without rediscovery',
    (final tester) async {
      final client = _CreationClient(
        ServerProviderType.digitalOcean,
        ProvisioningStage.attachVolume,
      );
      final result = await provision(client, tester);
      expect(result.stage, ProvisioningStage.attachVolume);
      expect(result.kind, ProvisioningFailureKind.actionFailed);
      expect(result.resources.map((final r) => r.id), [
        '7',
        '7724db7c-e098-11e5-b522-000f53304e51',
      ]);
      expect(
        client.requests.where(
          (final r) => r.path == '/volumes' && r.method == 'GET',
        ),
        isEmpty,
      );
    },
  );

  for (final provider in [
    ServerProviderType.hetzner,
    ServerProviderType.digitalOcean,
  ]) {
    for (final stage in [
      ProvisioningStage.createServer,
      ProvisioningStage.createVolume,
    ]) {
      testWidgets('$provider $stage without ID requires manual handling', (
        final tester,
      ) async {
        final client = _CreationClient(provider, stage, missingId: true);
        final result = await provision(client, tester);
        expect(result.kind, ProvisioningFailureKind.unreadable);
        expect(result.stage, stage);
        expect(result.resources.last.id, isNull);
        expect(
          result.resources.last.kind,
          stage == ProvisioningStage.createServer
              ? ProvisionedResourceKind.server
              : ProvisionedResourceKind.volume,
        );
      });
      for (final status in [null, 408, 500]) {
        testWidgets('$provider $stage ($status) stops at uncertain creation', (
          final tester,
        ) async {
          final client = _CreationClient(provider, stage, status: status);
          final result = await provision(client, tester);
          expect(result.stage, stage);
          expect(result.kind, ProvisioningFailureKind.indeterminate);
          final firstStage = provider == ServerProviderType.hetzner
              ? ProvisioningStage.createVolume
              : ProvisioningStage.createServer;
          expect(result.resources, hasLength(stage == firstStage ? 0 : 1));
          expect(
            client.requests.where((final r) => r.method == 'POST'),
            hasLength(stage == firstStage ? 1 : 2),
          );
          expect(
            result.resources.every((final r) => r.provider == provider),
            isTrue,
          );
        });
      }
    }
    test(
      'deleteProvisionedResource refuses unknown and foreign IDs on $provider',
      () async {
        final client = _CreationClient(
          provider,
          ProvisioningStage.createVolume,
        );
        final instance = client.instance;
        for (final kind in ProvisionedResourceKind.values) {
          for (final id in [
            null,
            '',
            '   ',
            if (kind == ProvisionedResourceKind.server ||
                provider == ServerProviderType.hetzner) ...[
              '-1',
              '0',
              'invalid',
            ],
          ]) {
            expect(
              (await instance.deleteProvisionedResource(
                ProvisionedResource(provider: provider, kind: kind, id: id),
              )).success,
              isFalse,
            );
          }
          expect(
            (await instance.deleteProvisionedResource(
              ProvisionedResource(
                provider: provider == ServerProviderType.hetzner
                    ? ServerProviderType.digitalOcean
                    : ServerProviderType.hetzner,
                kind: kind,
                id: '7',
              ),
            )).success,
            isFalse,
          );
        }
        expect(client.requests, isEmpty);
      },
    );
  }
}
