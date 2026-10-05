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
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/backup_fixtures.dart';
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
  late bool configured;
  late Server stored;
  late _Lifecycle lifecycle;
  late _Network network;

  void start(
    final WidgetTester tester, {
    final bool withServer = true,
    final List<Server> additionalServers = const [],
  }) {
    api = _Api();
    resources = _Resources();
    stored = aServer();
    configured = withServer;
    automatic = false;
    foreground = true;
    events = {};
    dispatch = {};
    jobSockets = [];
    logSockets = [];
    visibility = StreamController<bool>.broadcast(sync: true);
    resourceChanges = StreamController<ResourcesModelEvent>.broadcast();
    when(
      () => resources.servers,
    ).thenAnswer((_) => configured ? [stored, ...additionalServers] : []);
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

  runtimeTest('background servers poll jobs but not other domains', (
    final tester,
  ) async {
    start(
      tester,
      additionalServers: [
        aServer(
          uuid: 'other',
          hostingDetails: aServerHostingDetails(apiToken: 'other-token'),
        ),
      ],
    );
    await tester.pump();
    final first = hub.active!;
    final other = hub.connections['other']!;
    expect(first.users.value.data, isNotNull);
    expect(other.cache.apiVersion.value.data, isNotNull);
    expect(other.jobs.value.data, isNotNull);
    expect(other.users.value.data, isNull);
    final firstRead = first.users.value.updatedAt;

    final selection = hub.selectServer('other');
    await tester.pump();
    await selection;
    expect(other.users.value.data, isNotNull);
    await tester.pump(const Duration(minutes: 2));
    expect(first.users.value.updatedAt, firstRead);
    expect(first.isAttached, isTrue);
    expect(jobSockets, hasLength(2));

    final explicitRead = first.users.refresh(force: true);
    await tester.pump();
    await explicitRead;
    expect(first.users.value.updatedAt, isNot(firstRead));
  });

  runtimeTest('background job completion stays with its operation owner', (
    final tester,
  ) async {
    start(
      tester,
      additionalServers: [
        aServer(
          uuid: 'other',
          hostingDetails: aServerHostingDetails(apiToken: 'other-token'),
        ),
      ],
    );
    await tester.pump();
    final first = hub.active!;
    final job = aBackupJob(uid: 'background-job');
    first.jobs.receiveSnapshot([job]);
    final operation = first.submit(
      OperationKind.createBackups,
      (_) async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {job.uid}),
    );
    await tester.pump();
    await operation.result;
    final selection = hub.selectServer('other');
    await tester.pump();
    await selection;
    jobSockets.first.add([
      aBackupJob(uid: job.uid, status: JobStatusEnum.finished),
    ]);
    await tester.pump();
    expect(await operation.completion, OperationStatus.succeeded);
    expect(first.operations.history.single.status, OperationStatus.succeeded);
    expect(hub.active!.operations.history, isEmpty);
    events['other-token']!(GraphQLTransportEvent.authFailure);
    await tester.pump();
    expect(hub.active!.reachability, ReachabilityStatus.unauthorized);
    expect(first.reachability, ReachabilityStatus.reachable);
  });

  runtimeTest('foreground cannot resume probes while rotation drains work', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final pending = Completer<void>();
    final work = hub.active!.submit(
      OperationKind.manageUsers,
      (_) => pending.future,
    );
    final rotation = hub.active!.rotateToken();
    await tester.pump();
    clearInteractions(api);
    foreground = false;
    visibility.add(false);
    await tester.pump();
    foreground = true;
    visibility.add(true);
    await tester.pump();
    expect(hub.active!.rotation.status, RotationStatus.waiting);
    verifyNever(api.getApiVersion);
    hub.active!.cancelRotation();
    pending.complete();
    await tester.pump();
    await work.result;
    await rotation;
  });

  runtimeTest('missing jobs are verified once before becoming unknown', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final lookup = Completer<ServerJob?>();
    when(() => api.getServerJob('backup')).thenAnswer((_) => lookup.future);
    final operation = hub.active!.submit(
      OperationKind.manageBackups,
      (final owner) async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
    );
    await tester.pump();
    await operation.result;
    expect(hub.active!.operations.pending, hasLength(1));
    hub.active!.cache.groups.push(const ['sp.full_users']);
    await tester.pump();
    verify(() => api.getServerJob('backup')).called(1);
    lookup.complete(null);
    await tester.pump();
    expect(await operation.completion, OperationStatus.unknown);
    expect(hub.active!.operations.pending, isEmpty);
  });

  runtimeTest(
    'failed job verification retries on a new snapshot without resending',
    (final tester) async {
      start(tester);
      await tester.pump();
      when(() => api.getServerJob('backup')).thenThrow(StateError('offline'));
      var sent = 0;
      final operation = hub.active!.submit(
        OperationKind.manageBackups,
        (_) async {
          sent++;
        },
        describe: (_) =>
            OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
      );
      await tester.pump();
      await operation.result;
      expect(hub.active!.operations.pending, hasLength(1));
      verify(() => api.getServerJob('backup')).called(1);
      final completed = aBackupJob(
        uid: 'backup',
        status: JobStatusEnum.finished,
      );
      when(() => api.getServerJob('backup')).thenAnswer((_) async => completed);
      jobSockets.single.add([]);
      await tester.pump();
      expect(await operation.completion, OperationStatus.succeeded);
      expect(sent, 1);
    },
  );

  runtimeTest('a newer running job supersedes a pending missing-job lookup', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final lookup = Completer<ServerJob?>();
    when(() => api.getServerJob('backup')).thenAnswer((_) => lookup.future);
    final operation = hub.active!.submit(
      OperationKind.manageBackups,
      (_) async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
    );
    await tester.pump();
    final running = aBackupJob(uid: 'backup', status: JobStatusEnum.running);
    jobSockets.single.add([running]);
    await tester.pump();
    lookup.complete(null);
    await tester.pump();
    expect(hub.active!.operations.pending, hasLength(1));
    jobSockets.single.add([
      aBackupJob(uid: 'backup', status: JobStatusEnum.finished),
    ]);
    await tester.pump();
    expect(await operation.completion, OperationStatus.succeeded);
  });

  runtimeTest(
    'rotation and network loss preserve accepted jobs without resend',
    (final tester) async {
      start(tester);
      await tester.pump();
      final running = aBackupJob(uid: 'backup', status: JobStatusEnum.running);
      hub.active!.cache.serverJobs.push([running]);
      var sent = 0;
      final operation = hub.active!.submit(
        OperationKind.manageBackups,
        (_) async {
          sent++;
        },
        describe: (_) =>
            OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
      );
      await tester.pump();
      final connection = hub.active!;
      final rotation = connection.rotateToken();
      await tester.pump();
      expect(await rotation, RotationOutcome.succeeded);
      expect(hub.active, same(connection));
      expect(connection.operations.pending, hasLength(1));
      events['replacement']!(GraphQLTransportEvent.networkFailure);
      await tester.pump();
      expect(connection.operations.pending, hasLength(1));
      events['replacement']!(GraphQLTransportEvent.protectedSuccess);
      jobSockets.last.add([
        aBackupJob(uid: 'backup', status: JobStatusEnum.finished),
      ]);
      await tester.pump();
      expect(await operation.completion, OperationStatus.succeeded);
      expect(sent, 1);
    },
  );

  runtimeTest('job completion before the dispatch receipt is not lost', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final release = Completer<void>();
    final operation = hub.active!.submit(
      OperationKind.manageBackups,
      (_) => release.future,
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
    );
    jobSockets.single.add([
      aBackupJob(uid: 'backup', status: JobStatusEnum.finished),
    ]);
    await tester.pump();
    release.complete();
    await tester.pump();
    expect(await operation.completion, OperationStatus.succeeded);
    verifyNever(() => api.getServerJob(any()));
  });

  runtimeTest('a late lookup cannot settle work on a replacement connection', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final lookup = Completer<ServerJob?>();
    when(() => api.getServerJob('backup')).thenAnswer((_) => lookup.future);
    final old = hub.active!;
    final original = old.submit(
      OperationKind.manageBackups,
      (_) async {},
      describe: (_) =>
          OperationReport(OperationStatus.accepted, jobIds: {'backup'}),
    );
    await tester.pump();
    stored = aServer(
      hostingDetails: aServerHostingDetails(apiToken: 'new-token'),
    );
    resourceChanges.add(const ChangedServers());
    await tester.pump();
    expect(hub.active, isNot(same(old)));
    final release = Completer<void>();
    final replacement = hub.active!.submit(
      OperationKind.manageUsers,
      (_) => release.future,
    );
    lookup.complete(null);
    await tester.pump();
    expect(await original.completion, OperationStatus.unknown);
    expect(hub.active!.operations.pending.single.id, replacement.id);
    release.complete();
    await tester.pump();
  });

  runtimeTest(
    'startup without a server activates one runtime when installation supplies it',
    (final tester) async {
      start(tester, withServer: false);
      await tester.pump();
      expect(hub.active, isNull);
      verifyNever(api.getApiVersion);
      configured = true;
      resourceChanges.add(const ChangedServers());
      await tester.pump();
      expect(hub.active, isNotNull);
      expect(jobSockets, hasLength(1));
      hub
        ..resume()
        ..start(lifecycle: lifecycle, connectivity: network);
      await tester.pump();
      expect(jobSockets, hasLength(1));
      hub.clear();
      configured = false;
      resourceChanges.add(const ClearedModel());
      await tester.pump();
      expect(hub.active, isNull);
      configured = true;
      resourceChanges.add(const ChangedServers());
      await tester.pump();
      expect(hub.active, isNull);
      hub.resume();
      await tester.pump();
      expect(jobSockets, hasLength(2));
    },
  );

  runtimeTest('one store change is forwarded to the hub once', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    foreground = false;
    visibility.add(false);
    await tester.pump();
    var connectionEvents = 0;
    var hubEvents = 0;
    final connectionSubscription = hub.active!.changes.listen(
      (_) => connectionEvents++,
    );
    final hubSubscription = hub.changes.listen((_) => hubEvents++);
    hub.active!.cache.groups.requestReconciliation();
    await tester.pump();
    expect(connectionEvents, 1);
    expect(hubEvents, 1);
    unawaited(connectionSubscription.cancel());
    unawaited(hubSubscription.cancel());
  });

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
      final logs = hub.active!.logs().listen((_) {});
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

  runtimeTest('rotation ignores health callbacks from the previous socket', (
    final tester,
  ) async {
    start(tester);
    await tester.pump();
    final oldHealth = socketHealth;
    final connection = hub.active;
    final rotation = hub.active!.rotateToken();
    await tester.pump();
    expect(await rotation, RotationOutcome.succeeded);
    expect(hub.active, same(connection));
    socketHealth(connected: true);
    await tester.pump();
    clearInteractions(api);

    oldHealth(connected: false);
    await tester.pump(const Duration(seconds: 10));

    verifyNever(api.getServerJobs);
    expect(jobSockets, hasLength(2));
    expect(jobSockets.last.hasListener, isTrue);
  });

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
    final rotation = hub.active!.rotateToken();
    var actionSent = false;
    String? actionToken;
    final queued = hub.active!.submit(OperationKind.manageUsers, (
      final owner,
    ) async {
      actionSent = true;
      actionToken = stored.hostingDetails.apiToken;
      dispatch['replacement']!();
    });
    await tester.pump();
    verifyNever(api.refreshDeviceApiToken);
    expect(hub.active!.rotation.status, RotationStatus.waiting);
    events['api-token']!(GraphQLTransportEvent.requestFinished);
    await tester.pump();
    expect(hub.active!.rotation.status, RotationStatus.rotating);
    expect(stored.hostingDetails.apiToken, 'api-token');
    expect(actionSent, isFalse);
    expect(dispatch.containsKey('replacement'), isFalse);
    expect(jobSockets, hasLength(1));
    expect(jobSockets.single.hasListener, isFalse);
    saved.complete();
    await tester.pump();
    expect(await rotation, RotationOutcome.succeeded);
    await queued.result;
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
      final action = hub.active!.submit(
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
      await action.result;
      verifyNever(api.refreshDeviceApiToken);
      foreground = true;
      visibility.add(true);
      await tester.pump();
      verify(api.refreshDeviceApiToken).called(1);
      expect(stored.hostingDetails.apiToken, 'replacement');
    },
  );
}
