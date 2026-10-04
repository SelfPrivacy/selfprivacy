import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/connection_observation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/recovery_key/recovery_key_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/reset_password_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import '../../helpers/fixtures/domain_mutation_fixtures.dart';
import '../../helpers/fixtures/server_fixtures.dart';
import '../../helpers/fixtures/service_fixtures.dart';

class _Resources extends Mock implements ResourcesModel {}

class _Api extends Mock implements ServerApi {}

void main() {
  late Server? selected;
  late StreamController<ResourcesModelEvent> changes;
  late ServerConnectionHub hub;
  late _Api api;
  late List<CachedValue<List<String>>?> observed;
  StreamSubscription<Object?>? subscription;

  setUpAll(() => registerFallbackValue(aServer()));
  setUp(() {
    selected = aServer();
    changes = StreamController<ResourcesModelEvent>.broadcast();
    final resources = _Resources();
    api = _Api();
    when(
      () => resources.servers,
    ).thenAnswer((_) => [if (selected != null) selected!]);
    when(() => resources.statusStream).thenAnswer((_) => changes.stream);
    when(() => resources.updateServerByUuid(any())).thenAnswer((
      final call,
    ) async {
      selected = call.positionalArguments.single as Server;
      changes.add(const ChangedServers());
    });
    hub = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (_, _, _) => api,
    );
    hub.active!.cache.setVersion(Version(3, 6, 0));
    observed = [];
  });
  tearDown(() async {
    await subscription?.cancel();
    subscription = null;
    hub.dispose();
    await changes.close();
  });

  void observe() {
    subscription = observeConnection(
      connection: hub.active!,
      read: (final connection) => connection.cache.groups.value,
      changes: (final connection) => connection.cache.groups.stream,
    ).listen(observed.add);
  }

  for (final action in [
    'restart',
    'move',
    'removeJob',
    'removeFinished',
    'migrate',
    'deviceKey',
    'recoveryKey',
  ]) {
    test(
      '$action rejects the displayed binding when selection changes before notification',
      () async {
        var mutations = 0;
        final service = aService();
        final job = aServiceMoveJob(status: 'FINISHED');
        hub.active!.services.store.push([service]);
        hub.active!.jobs.store.push([job]);
        when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
        Future<ServerMutationResult<T>> response<T>(final T value) async {
          mutations++;
          return ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: ServerMutationPayload.available(value),
          );
        }

        when(
          () => api.restartService(any()),
        ).thenAnswer((_) => response<void>(null));
        when(
          () => api.moveService(any(), any()),
        ).thenAnswer((_) => response(job));
        when(
          () => api.removeApiJob(any()),
        ).thenAnswer((_) => response<void>(null));
        when(
          () => api.migrateToBinds(any(), any()),
        ).thenAnswer((_) => response(job));
        when(
          api.createDeviceToken,
        ).thenAnswer((_) => response('device-secret'));
        when(
          () => api.generateRecoveryToken(null, null),
        ).thenAnswer((_) => response('recovery-secret'));
        final services = createServicesBloc(hub.active!, showMessage: (_) {});
        final jobs = createServerJobsBloc(
          hub.active!,
          showMessage: (_, {final behavior}) {},
        );
        final devices = createDevicesBloc(hub.active!, showMessage: (_) {});
        final recovery = createRecoveryKeyBloc(hub.active!);
        addTearDown(services.close);
        addTearDown(jobs.close);
        addTearDown(devices.close);
        addTearDown(recovery.close);
        await pumpEventQueue();
        selected = aServer(uuid: 'replacement');
        switch (action) {
          case 'restart':
            services.add(ServiceRestart(service));
          case 'move':
            services.add(ServicesMove({service.id: 'sdb'}));
          case 'removeJob':
            jobs.add(RemoveServerJob(job.uid));
          case 'removeFinished':
            jobs.add(RemoveAllFinishedJobs());
          case 'migrate':
            await jobs.migrateToBinds({service.id: 'sdb'});
          case 'deviceKey':
            await devices.getNewDeviceKey();
          case 'recoveryKey':
            try {
              await recovery.generateRecoveryKey();
            } on GenerationError {
              /* Rejected before dispatch. */
            }
        }
        await pumpEventQueue();
        expect(mutations, 0);
      },
    );
  }

  for (final detach in [false, true]) {
    test(
      'submitted moves survive UI close but stop on detach: detach=$detach',
      () async {
        final connection = hub.active!;
        final pending = Completer<ServerMutationResult<ServerJob>>();
        final calls = <String>[];
        when(() => api.moveService(any(), any())).thenAnswer((final call) {
          final id = call.positionalArguments.first as String;
          calls.add(id);
          return id == 'gitea'
              ? pending.future
              : Future.value(
                  ServerMutationResult(
                    outcome: ServerMutationOutcome.confirmed,
                    payload: ServerMutationPayload.available(
                      aServiceMoveJob(uid: id),
                    ),
                  ),
                );
        });
        final feedback = <String>[];
        final services = createServicesBloc(
          connection,
          showMessage: feedback.add,
        );
        await pumpEventQueue();
        final selection = {'gitea': 'sdb', 'nextcloud': 'sdc'};
        services.add(ServicesMove(selection));
        selection.clear();
        await pumpEventQueue();
        expect(calls, ['gitea']);
        final closing = services.close();
        if (detach) {
          connection.dispose();
        }
        pending.complete(
          ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: ServerMutationPayload.available(
              aServiceMoveJob(uid: 'gitea'),
            ),
          ),
        );
        await closing;
        await pumpEventQueue();
        expect(calls, detach ? ['gitea'] : ['gitea', 'nextcloud']);
        expect(feedback, isEmpty);
        if (!detach) {
          expect(connection.operations.history.single.jobIds, {
            'gitea',
            'nextcloud',
          });
          verify(() => api.moveService('nextcloud', 'sdc')).called(1);
        }
      },
    );
  }

  test('migration requests progress while queued before dispatch', () async {
    final connection = hub.active!;
    connection.operations.pause();
    final jobs = createServerJobsBloc(
      connection,
      showMessage: (_, {final behavior}) {},
    );
    final history = OperationsCubit(
      queue: connection.operations,
      remove: (_) async => true,
      showMessage: (_) {},
    );
    addTearDown(jobs.close);
    addTearDown(history.close);
    addTearDown(connection.operations.dispose);
    await pumpEventQueue();
    final migrating = jobs.migrateToBinds({'gitea': 'sdb'});
    await pumpEventQueue();
    expect(history.state.operations.single.jobIds, isEmpty);
    expect(history.state.focusId, history.state.operations.single.id);
    connection.operations.dispose();
    await migrating;
  });

  test('emits existing data and only updates for its domain', () async {
    hub.active!.cache.groups.push(const ['sp.full_users']);
    await pumpEventQueue();
    observe();
    await pumpEventQueue();
    final first = observed.single;
    hub.active!.cache.users.push(const []);
    await pumpEventQueue();
    expect(observed, hasLength(1));
    hub.active!.cache.groups.push(const ['sp.admin']);
    await pumpEventQueue();
    expect(observed.last!.data, ['sp.admin']);
    expect(first!.data, ['sp.full_users']);
  });

  test('removal emits absence and rejects queued old-domain events', () async {
    observe();
    await pumpEventQueue();
    hub.active!.cache.groups.push(const ['old']);
    selected = null;
    changes.add(const ChangedServers());
    await pumpEventQueue();
    expect(observed.last, isNull);
    expect(
      observed.any((final event) => event?.data?.contains('old') ?? false),
      isFalse,
    );
    selected = aServer();
    changes.add(const ChangedServers());
    await pumpEventQueue();
    expect(observed.last, isNull);
    final replacement = await observeConnection(
      connection: hub.active!,
      read: (final connection) => connection.cache.groups.value,
      changes: (final connection) => connection.cache.groups.stream,
    ).first;
    expect(replacement!.data, isNull);
  });

  test(
    'confirmed rotation preserves the observed connection and snapshot',
    () async {
      hub.active!.cache.groups.push(const ['sp.full_users']);
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      observe();
      await pumpEventQueue();
      final before = observed.last;
      await hub.active!.rotateToken();
      await pumpEventQueue();
      expect(observed.last, same(before));
      expect(observed.last!.data, ['sp.full_users']);
    },
  );

  test(
    'reset link survives confirmed rotation but not same-server reselection',
    () async {
      final bloc = createResetPasswordBloc(
        hub.active!,
        User.fake(login: 'alex'),
      );
      addTearDown(bloc.close);
      when(() => api.generatePasswordResetLink('alex')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available(
            'https://auth.example.org/ui/reset?token=abcd-0123-abcd-0123',
          ),
        ),
      );
      final generated = bloc.stream.firstWhere(
        (final state) => state.isLinkValid,
      );
      bloc.add(const RequestNewPassword());
      final link = (await generated).passwordResetLink;
      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      await hub.active!.rotateToken();
      await pumpEventQueue();
      expect(bloc.state.passwordResetLink, link);
      selected = null;
      changes.add(const ChangedServers());
      await pumpEventQueue();
      expect(bloc.state.passwordResetLink, isNull);
      selected = aServer();
      changes.add(const ChangedServers());
      await pumpEventQueue();
      bloc.add(const RequestNewPassword());
      await pumpEventQueue();
      expect(bloc.state.passwordResetLink, isNull);
      verify(() => api.generatePasswordResetLink('alex')).called(1);
    },
  );

  test('reset discards an in-flight password link', () async {
    final bloc = createResetPasswordBloc(hub.active!, User.fake(login: 'alex'));
    addTearDown(bloc.close);
    final pending = Completer<ServerMutationResult<String>>();
    final sent = Completer<void>();
    when(() => api.generatePasswordResetLink('alex')).thenAnswer((_) {
      sent.complete();
      return pending.future;
    });
    bloc.add(const RequestNewPassword());
    await sent.future;
    selected = null;
    changes.add(const ChangedServers());
    await pumpEventQueue();
    pending.complete(
      ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: const ServerMutationPayload.available(
          'https://auth.example.org/ui/reset?token=late-secret',
        ),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state.passwordResetLink, isNull);
    expect(bloc.state.isLoading, isFalse);
  });
}
