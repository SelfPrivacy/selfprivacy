import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/fixtures/server_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

class _Resources extends Mock implements ResourcesModel {}

class _Tls extends Mock implements TlsContext {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(aServer());
    registerFallbackValue(TlsPolicy.strict);
  });

  testWidgets(
    'one admitted operation finishes on its credential while rotation waits for dispatch and persistence',
    (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        final resources = _Resources();
        var stored = aServer();
        final firstSent = Completer<void>();
        final releaseFirst = Completer<void>();
        final saving = Completer<void>();
        final saved = Completer<void>();
        final requests = <(String, String?)>[];
        final responses = loadJsonFixture('graphql/mutation_results.json');
        when(() => resources.servers).thenAnswer((_) => [stored]);
        when(
          () => resources.statusStream,
        ).thenAnswer((_) => const Stream.empty());
        when(() => resources.updateServerByUuid(any())).thenAnswer((
          final call,
        ) async {
          saving.complete();
          await saved.future;
          stored = call.positionalArguments.single as Server;
        });
        final client = MockClient((final request) async {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          final operation =
              (body['operationName'] as String?) ??
              parseString(body['query'] as String).definitions
                  .whereType<OperationDefinitionNode>()
                  .single
                  .name!
                  .value;
          requests.add((operation, request.headers['Authorization']));
          if (operation == 'ChangeTimezone') {
            firstSent.complete();
            await releaseFirst.future;
          }
          return http.Response(
            jsonEncode({'data': responses[operation]}),
            200,
            headers: {'content-type': 'application/json'},
          );
        });
        final tls = _Tls();
        when(
          () => tls.clientFor(
            host: any(named: 'host'),
            policy: any(named: 'policy'),
          ),
        ).thenReturn(client);
        final hub = ServerConnectionHub(
          resourcesModel: resources,
          createApi: (final binding, final onEvent, final beforeRequest) =>
              ServerApi(
                transport: GraphQLTransport(
                  domainProvider: () => binding.domain,
                  tokenProvider: () => binding.token ?? '',
                  localeProvider: () => 'en',
                  tlsContext: tls,
                  consoleLog: (_) {},
                  onEvent: onEvent,
                  beforeRequest: beforeRequest,
                ),
              ),
        );
        hub.active!.cache.setVersion(Version(3, 6, 0));
        final cubit = createJobsCubit(
          hub.active!,
          resources: resources,
          dnsProvider: () => null,
          showMessage: (_) {},
        );
        try {
          await pumpEventQueue();
          cubit
            ..addJob(ChangeServerTimezoneJob(timezone: 'Europe/Helsinki'))
            ..addJob(ChangeSshSettingsJob(enable: true));
          final applying = cubit.applyAll();
          await firstSent.future.timeout(const Duration(seconds: 5));
          final rotation = hub.active!.rotateToken();
          final queued = hub.active!.submit(
            OperationKind.manageVolumes,
            (final owner) => owner.volumes.reboot(),
          );
          await pumpEventQueue();
          expect(hub.active!.rotation.status, RotationStatus.waiting);
          expect(requests.map((final request) => request.$1), [
            'ChangeTimezone',
          ]);
          releaseFirst.complete();
          await applying;
          await saving.future.timeout(const Duration(seconds: 5));
          expect(requests.map((final request) => request.$1), [
            'ChangeTimezone',
            'ChangeSshSettings',
            'RunSystemRebuild',
            'RefreshDeviceApiToken',
          ]);
          expect(
            requests.map((final request) => request.$2),
            everyElement('Bearer api-token'),
          );
          expect(
            hub.active!.operations.history.where(
              (final operation) => operation.kind == OperationKind.applyChanges,
            ),
            hasLength(1),
          );
          saved.complete();
          expect(await rotation, RotationOutcome.succeeded);
          await queued.result;
          expect(requests.last, ('RebootSystem', 'Bearer fixture-secret'));
        } finally {
          if (!releaseFirst.isCompleted) {
            releaseFirst.complete();
          }
          if (!saved.isCompleted) {
            saved.complete();
          }
          await cubit.close();
          hub.dispose();
          client.close();
        }
      });
    },
  );
}
