import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/lifecycle/app_lifecycle.dart';
import 'package:selfprivacy/logic/connection/lifecycle/network_connectivity.dart';
import 'package:selfprivacy/logic/connection/lifecycle/reachability.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Resources extends Mock implements ResourcesModel {}

class _Lifecycle extends Mock implements AppLifecycle {}

class _Network extends Mock implements NetworkConnectivitySource {}

void main() {
  setUpAll(() => registerFallbackValue(aServer()));
  late ServerConnectionHub hub;
  late _Api api;
  late _Resources resources;
  late StreamController<bool> visibility;
  late StreamController<ResourcesModelEvent> resourceChanges;
  late List<StreamController<List<ServerJob>>> jobSockets;
  late List<StreamController<ServerLogEntry>> logSockets;
  late Map<String?, void Function(GraphQLTransportEvent)> events;
  late Map<String?, void Function()> dispatch;
  late void Function({required bool connected}) socketHealth;
  late bool foreground;
  late bool automatic;
  late Server stored;
  late _Lifecycle lifecycle;
  late _Network network;

  void start(final WidgetTester tester) {
    api = _Api();
    resources = _Resources();
    stored = aServer();
    automatic = false;
    foreground = true;
    events = {};
    dispatch = {};
    jobSockets = [];
    logSockets = [];
    visibility = StreamController<bool>.broadcast(sync: true);
    resourceChanges = StreamController<ResourcesModelEvent>.broadcast();
    when(() => resources.servers).thenAnswer((_) => [stored]);
    when(
      () => resources.statusStream,
    ).thenAnswer((_) => resourceChanges.stream);
    when(() => resources.updateServerByUuid(any())).thenAnswer((
      final call,
    ) async {
      stored = call.positionalArguments.single as Server;
      resourceChanges.add(const ChangedServers());
    });
    lifecycle = _Lifecycle();
    when(() => lifecycle.isForeground).thenAnswer((_) => foreground);
    when(
      () => lifecycle.foregroundChanges,
    ).thenAnswer((_) => visibility.stream);
    network = _Network();
    when(network.check).thenAnswer((_) async => NetworkConnectivity.available);
    when(() => network.changes).thenAnswer((_) => const Stream.empty());
    final fixtures = loadJsonFixture('graphql/domain_reads.json');
    final reads = ServerApi(
      transport: transportWithLink(
        Link.function((final request, [final forward]) {
          final name = request.operation.document.definitions
              .whereType<OperationDefinitionNode>()
              .single
              .name!
              .value;
          return Stream.value(
            Response(
              response: const {},
              data: fixtures[name] as Map<String, dynamic>,
            ),
          );
        }),
      ),
    );
    when(api.getApiVersion).thenAnswer((_) => reads.getApiVersion());
    when(api.fetchApiVersion).thenAnswer((_) => reads.fetchApiVersion());
    when(api.getServerJobs).thenAnswer((_) => reads.getServerJobs());
    when(api.getAllUsers).thenAnswer((_) => reads.getAllUsers());
    when(api.getAllGroups).thenAnswer((_) => reads.getAllGroups());
    when(api.getAllServices).thenAnswer((_) => reads.getAllServices());
    when(api.getApiTokens).thenAnswer((_) => reads.getApiTokens());
    when(
      api.getRecoveryTokenStatus,
    ).thenAnswer((_) => reads.getRecoveryTokenStatus());
    when(api.getSystemSettings).thenAnswer((_) => reads.getSystemSettings());
    when(
      api.getServerDiskVolumes,
    ).thenAnswer((_) => reads.getServerDiskVolumes());
    when(api.getBackups).thenAnswer((_) => reads.getBackups());
    when(
      api.getBackupsConfiguration,
    ).thenAnswer((_) => reads.getBackupsConfiguration());
    when(
      () => api.getServerJobsStream(
        onConnectionState: any(named: 'onConnectionState'),
      ),
    ).thenAnswer((final call) {
      socketHealth =
          call.namedArguments[#onConnectionState]
              as void Function({required bool connected});
      final socket = StreamController<List<ServerJob>>();
      jobSockets.add(socket);
      return socket.stream;
    });
    when(api.getServerLogsStream).thenAnswer((_) {
      final socket = StreamController<ServerLogEntry>();
      logSockets.add(socket);
      return socket.stream;
    });
    when(api.refreshDeviceApiToken).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available('replacement'),
      ),
    );
    hub = ServerConnectionHub(
      resourcesModel: resources,
      now: tester.binding.clock.now,
      automaticRotationEnabled: () => automatic,
      createApi: (final binding, final onEvent, final before) {
        events[binding.token] = onEvent;
        dispatch[binding.token] = before;
        return api;
      },
    )..start(lifecycle: lifecycle, connectivity: network);
    addTearDown(() {
      hub.dispose();
      unawaited(visibility.close());
      unawaited(resourceChanges.close());
      for (final socket in [...jobSockets, ...logSockets]) {
        unawaited(socket.close());
      }
    });
  }

  void runtimeTest(final String name, final WidgetTesterCallback body) {
    testWidgets(name, (final tester) async {
      try {
        await body(tester);
      } finally {
        hub.dispose();
      }
    });
  }

  runtimeTest('healthy idle socket uses sixty-second polling; loss uses ten', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    expect(jobSockets, hasLength(1));
    socketHealth(connected: true);
    await tester.pump();
    verify(api.getServerJobs).called(1);
    await tester.pump(const Duration(seconds: 59));
    verifyNever(api.getServerJobs);
    await tester.pump(const Duration(seconds: 1));
    verify(api.getServerJobs).called(1);
    expect(
      hub.active!.cache.serverJobs.staleAfter,
      greaterThan(const Duration(seconds: 60)),
    );
    socketHealth(connected: false);
    await tester.pump();
    verify(api.getServerJobs).called(1);
    await tester.pump(const Duration(seconds: 10));
    verify(api.getServerJobs).called(1);
  });

  runtimeTest(
    'hidden stops reads immediately and sockets after thirty seconds',
    (final tester) async {
      start(tester);
      await tester.pump();
      socketHealth(connected: true);
      final logs = hub.logs().listen((_) {});
      await tester.pump();
      expect(logSockets.single.hasListener, isTrue);
      clearInteractions(api);
      foreground = false;
      visibility.add(false);
      await tester.pump(const Duration(seconds: 29));
      expect(jobSockets.single.hasListener, isTrue);
      expect(logSockets.single.hasListener, isTrue);
      verifyNever(api.getServerJobs);
      expect(dispatch['api-token'], throwsA(isA<GraphQLDispatchDeferred>()));
      await tester.pump(const Duration(seconds: 1));
      expect(jobSockets.single.hasListener, isFalse);
      expect(logSockets.single.hasListener, isFalse);
      foreground = true;
      visibility.add(true);
      await tester.pump();
      expect(jobSockets, hasLength(2));
      expect(logSockets, hasLength(2));
      unawaited(logs.cancel());
      await tester.pump();
    },
  );

  runtimeTest(
    'resume cancels socket grace without reconnecting healthy sockets',
    (final tester) async {
      start(tester);
      await tester.pump();
      foreground = false;
      visibility.add(false);
      await tester.pump(const Duration(seconds: 20));
      foreground = true;
      visibility.add(true);
      await tester.pump(const Duration(seconds: 20));
      expect(jobSockets, hasLength(1));
      expect(jobSockets.single.hasListener, isTrue);
    },
  );

  runtimeTest('rotation drains HTTP and fences old feedback after saving', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final saved = Completer<void>();
    when(() => resources.updateServerByUuid(any())).thenAnswer((
      final call,
    ) async {
      await saved.future;
      stored = call.positionalArguments.single as Server;
      resourceChanges.add(const ChangedServers());
    });
    events['api-token']!(GraphQLTransportEvent.requestStarted);
    final rotation = hub.rotateToken();
    var actionSent = false;
    String? actionToken;
    final queued = hub.submit(OperationKind.manageUsers, (final owner) async {
      actionSent = true;
      actionToken = stored.hostingDetails.apiToken;
      dispatch['replacement']!();
    });
    await tester.pump();
    verifyNever(api.refreshDeviceApiToken);
    expect(hub.rotation.status, RotationStatus.waiting);
    events['api-token']!(GraphQLTransportEvent.requestFinished);
    await tester.pump();
    expect(hub.rotation.status, RotationStatus.rotating);
    expect(stored.hostingDetails.apiToken, 'api-token');
    expect(actionSent, isFalse);
    expect(dispatch.containsKey('replacement'), isFalse);
    expect(jobSockets, hasLength(1));
    expect(jobSockets.single.hasListener, isFalse);
    saved.complete();
    await tester.pump();
    expect(await rotation, RotationOutcome.succeeded);
    await queued.completion;
    expect(actionSent, isTrue);
    expect(actionToken, 'replacement');
    expect(jobSockets, hasLength(2));
    expect(jobSockets.last.hasListener, isTrue);
    expect(stored.hostingDetails.apiToken, 'replacement');
    events['api-token']!(GraphQLTransportEvent.authFailure);
    await tester.pump();
    expect(hub.reachability, ReachabilityStatus.reachable);
    expect(dispatch['api-token'], throwsA(isA<GraphQLDispatchDeferred>()));
    expect(dispatch['replacement'], returnsNormally);
  });

  runtimeTest('public success cannot clear an authentication failure', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    events['api-token']!(GraphQLTransportEvent.authFailure);
    events['api-token']!(GraphQLTransportEvent.reachable);
    await tester.pump();
    expect(hub.reachability, ReachabilityStatus.unauthorized);
    events['api-token']!(GraphQLTransportEvent.protectedSuccess);
    await tester.pump();
    expect(hub.reachability, ReachabilityStatus.reachable);
  });

  runtimeTest(
    'automatic rotation waits for complete workflows and respects its setting',
    (final tester) async {
      start(tester);
      await tester.pump();
      verifyNever(api.refreshDeviceApiToken);
      final pending = Completer<void>();
      final action = hub.submit(
        OperationKind.manageBackups,
        (_) => pending.future,
      );
      automatic = true;
      events['api-token']!(GraphQLTransportEvent.protectedSuccess);
      await tester.pump();
      verifyNever(api.refreshDeviceApiToken);
      foreground = false;
      visibility.add(false);
      pending.complete();
      await tester.pump();
      await action.completion;
      verifyNever(api.refreshDeviceApiToken);
      foreground = true;
      visibility.add(true);
      await tester.pump();
      verify(api.refreshDeviceApiToken).called(1);
      expect(stored.hostingDetails.apiToken, 'replacement');
    },
  );
}
