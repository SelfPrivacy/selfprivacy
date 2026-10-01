import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/logic/models/service.dart';

import '../../../../helpers/fixtures/backup_fixtures.dart';
import '../../../../helpers/fixtures/credential_fixtures.dart';
import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/operation_fixture.dart';
import '../../../../helpers/widget_harness.dart';

class _Repository extends Mock implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

class _Resources extends Mock implements ResourcesModel {}

class _Navigation extends Mock implements NavigationService {}

class _Input extends Fake implements InitializeRepositoryInput {}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(_Input());
    registerFallbackValue(aBackupConfiguration().autobackupQuotas);
  });

  late _Repository repository;
  late _Api api;
  late _Resources resources;
  late _Navigation navigation;
  late ApiData data;
  late ServerConnection connection;
  late ServerStateOrigin? origin;
  late StreamController<ApiData> controller;
  late BackupsBloc bloc;
  late List<Service> services;

  setUp(() {
    repository = _Repository();
    api = _Api();
    resources = _Resources();
    navigation = _Navigation();
    data = ApiData(connection: () => connection);
    origin = ServerStateOrigin('server');
    connection = ServerConnection(
      api: api,
      origin: origin!,
      currentOrigin: () => origin,
    )..setVersion(Version(3, 6, 0));
    controller = StreamController<ApiData>.broadcast();
    final fixtures = loadJsonFixture('graphql/domain_reads.json');
    connection.backups.configStore.push(aBackupConfiguration());
    connection.backups.store.push(
      List.unmodifiable(
        Query$AllBackupSnapshots.fromJson(
          fixtures['AllBackupSnapshots'] as Map<String, dynamic>,
        ).backup.allSnapshots.map(Backup.fromGraphQL),
      ),
    );
    services = Query$AllServices.fromJson(
      fixtures['AllServices'] as Map<String, dynamic>,
    ).services.allServices.map(Service.fromGraphQL).toList();
    when(() => repository.connection).thenReturn(connection);
    stubOperations(repository, connection);
    when(() => repository.api).thenReturn(api);
    when(() => repository.apiData).thenReturn(data);
    when(
      () => repository.connectionStatus,
    ).thenReturn(ConnectionStatus.offline);
    when(
      () => repository.connectionStatusStream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => repository.dataStream).thenAnswer((_) => controller.stream);
    when(repository.emitData).thenAnswer((_) => controller.add(data));
    when(() => resources.backblazeBucket).thenReturn(aBackblazeBucket());
    when(resources.removeBackblazeBucket).thenAnswer((_) async {});
    getIt
      ..registerSingleton<ApiConnectionRepository>(repository)
      ..registerSingleton<ResourcesModel>(resources)
      ..registerSingleton<NavigationService>(navigation);
    bloc = BackupsBloc();
  });

  tearDown(() async {
    await bloc.close();
    connection.dispose();
    await controller.close();
    await getIt.reset();
  });

  Future<void> ready({
    final bool initialized = true,
    final bool jobsLoaded = true,
  }) async {
    if (jobsLoaded) {
      connection.jobs.store.push(const []);
    }
    connection.backups.configStore.push(
      aBackupConfiguration().copyWith(isInitialized: initialized),
    );
    final loaded = bloc.stream.first;
    bloc.add(
      BackupsStateChanged(
        connection.backups.value.data!,
        connection.backups.configValue.data,
      ),
    );
    await loaded;
  }

  Future<void> dispatch(final BackupsEvent event) async {
    final settled = bloc.stream.firstWhere(
      (final state) => state is! BackupsBusy && state is! BackupsInitializing,
    );
    bloc.add(event);
    await settled;
    await pumpEventQueue();
  }

  for (final operation in ['period', 'quotas', 'initialize', 'remove']) {
    for (final outcome in ServerMutationOutcome.values) {
      for (final missing in [false, true]) {
        testWidgets('$operation ${outcome.name}, missing=$missing', (
          final tester,
        ) async {
          await pumpForTest(tester, const SizedBox.shrink());
          await tester.runAsync(() async {
            await ready(initialized: operation != 'initialize');
            final original = connection.backups.configValue.data;
            final fixture = loadJsonFixture('graphql/mutation_results.json');
            final returned = operation == 'remove'
                ? BackupConfiguration.fromGraphQL(
                    Mutation$RemoveRepository.fromJson(
                      fixture['RemoveRepository'] as Map<String, dynamic>,
                    ).backup.removeRepository.configuration!,
                  )
                : aBackupConfiguration();
            final result = ServerMutationResult<BackupConfiguration>(
              outcome: outcome,
              payload: missing
                  ? const ServerMutationPayload.missing()
                  : ServerMutationPayload.available(returned),
              message: 'secret-sentinel',
            );
            when(
              () => api.setAutobackupPeriod(period: any(named: 'period')),
            ).thenAnswer((_) async => result);
            when(
              () => api.setAutobackupQuotas(any()),
            ).thenAnswer((_) async => result);
            when(
              () => api.initializeRepository(any()),
            ).thenAnswer((_) async => result);
            when(api.removeRepository).thenAnswer((_) async => result);
            final event = switch (operation) {
              'period' => const SetAutobackupPeriod(Duration(minutes: 15)),
              'quotas' => SetAutobackupQuotas(
                returned.autobackupQuotas.copyWith(last: 99),
              ),
              'initialize' => InitializeBackupsRepository(aBackupsCredential()),
              _ => const RemoveBackupsRepository(),
            };
            await dispatch(event);
            final confirmed = outcome == ServerMutationOutcome.confirmed;
            expect(
              connection.backups.configValue.data,
              confirmed && !missing ? returned : original,
            );
            expect(
              connection.backups.configValue.needsReconciliation,
              !confirmed || missing,
            );
            expect(bloc.state, isNot(isA<BackupsBusy>()));
            expect(bloc.state, isNot(isA<BackupsInitializing>()));
            verifyNever(() => repository.reload(any()));
            if (operation == 'remove' && confirmed) {
              verify(resources.removeBackblazeBucket).called(1);
              expect(
                bloc.state,
                missing
                    ? isA<BackupsInitialized>()
                    : isA<BackupsUninitialized>(),
              );
            } else {
              verifyNever(resources.removeBackblazeBucket);
            }
            if (!confirmed || missing) {
              final key = outcome == ServerMutationOutcome.indeterminate
                  ? 'server_mutation.outcome_unknown'
                  : outcome == ServerMutationOutcome.rejected
                  ? 'server_mutation.rejected'
                  : 'server_mutation.payload_unavailable';
              expect(key.tr(), isNot(key));
              verify(() => navigation.showSnackBar(key.tr())).called(1);
            }
            verifyNever(() => navigation.showSnackBar('secret-sentinel'));
          });
        });
      }
    }
  }

  testWidgets('confirmed disabled schedule replaces the previous period', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      await ready();
      final fixture =
          loadJsonFixture(
                'graphql/mutation_results.json',
              )['SetAutobackupPeriod']
              as Map<String, dynamic>;
      final backup = fixture['backup'] as Map<String, dynamic>;
      final mutation = backup['setAutobackupPeriod'] as Map<String, dynamic>;
      (mutation['configuration'] as Map<String, dynamic>)['autobackupPeriod'] =
          null;
      final returned = BackupConfiguration.fromGraphQL(
        Mutation$SetAutobackupPeriod.fromJson(
          fixture,
        ).backup.setAutobackupPeriod.configuration!,
      );
      when(() => api.setAutobackupPeriod(period: null)).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(returned),
        ),
      );
      await dispatch(const SetAutobackupPeriod(null));
      expect(connection.backups.configValue.data!.autobackupPeriod, isNull);
      expect(bloc.state.autobackupPeriod, isNull);
      verifyNever(() => repository.reload(any()));
    });
  });

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('snapshot removal waits for ${outcome.name}', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        await ready();
        final original = List<Backup>.of(connection.backups.value.data!);
        final snapshotId = original.first.id;
        final pending = Completer<ServerMutationResult<void>>();
        when(
          () => api.forgetSnapshot(snapshotId),
        ).thenAnswer((_) => pending.future);
        final busy = bloc.stream.firstWhere(
          (final state) => state is BackupsBusy,
        );
        bloc.add(ForgetSnapshot(snapshotId));
        await busy;
        expect(connection.backups.value.data, original);
        final done = bloc.stream.firstWhere(
          (final state) => state is! BackupsBusy,
        );
        pending.complete(
          ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
        await done;
        await pumpEventQueue();
        expect(
          connection.backups.value.data,
          outcome == ServerMutationOutcome.confirmed
              ? original.where((final item) => item.id != snapshotId).toList()
              : original,
        );
        expect(bloc.state, isNot(isA<BackupsBusy>()));
      });
    });

    testWidgets('force reload invalidates only after ${outcome.name}', (
      final tester,
    ) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        await ready();
        when(api.forceBackupListReload).thenAnswer(
          (_) async => ServerMutationResult<void>(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
        await dispatch(const ForceSnapshotListUpdate());
        expect(connection.backups.value.needsReconciliation, isTrue);
      });
    });
  }

  for (final restore in [false, true]) {
    for (final outcome in ServerMutationOutcome.values) {
      for (final missing in [false, true]) {
        testWidgets('job restore=$restore ${outcome.name}, missing=$missing', (
          final tester,
        ) async {
          await pumpForTest(tester, const SizedBox.shrink());
          await tester.runAsync(() async {
            await ready();
            final job = aBackupJob();
            final result = ServerMutationResult<ServerJob>(
              outcome: outcome,
              payload: missing
                  ? const ServerMutationPayload.missing()
                  : ServerMutationPayload.available(job),
            );
            when(() => api.startBackup(any())).thenAnswer((_) async => result);
            when(
              () => api.restoreBackup(
                'snapshot-1',
                BackupRestoreStrategy.inplace,
              ),
            ).thenAnswer((_) async => result);
            await dispatch(
              restore
                  ? const RestoreBackup(
                      'snapshot-1',
                      BackupRestoreStrategy.inplace,
                    )
                  : CreateBackups(services.take(1).toList()),
            );
            expect(
              connection.jobs.store.value.data,
              outcome == ServerMutationOutcome.confirmed && !missing
                  ? [job]
                  : isEmpty,
            );
            expect(
              connection.jobs.store.value.needsReconciliation,
              outcome != ServerMutationOutcome.confirmed || missing,
            );
            expect(bloc.state, isNot(isA<BackupsBusy>()));
          });
        });
      }
    }
  }

  for (final missingList in [false, true]) {
    testWidgets(
      'returned jobs are retained and deduplicated, missing list=$missingList',
      (final tester) async {
        await pumpForTest(tester, const SizedBox.shrink());
        await tester.runAsync(() async {
          await ready(jobsLoaded: !missingList);
          final job = aBackupJob();
          if (!missingList) {
            connection.jobs.store.push([job]);
          }
          when(() => api.startBackup(any())).thenAnswer(
            (_) async => ServerMutationResult(
              outcome: ServerMutationOutcome.confirmed,
              payload: ServerMutationPayload.available(job),
            ),
          );
          await dispatch(CreateBackups(services.take(1).toList()));
          expect(connection.jobs.store.value.data, missingList ? null : [job]);
          if (missingList) {
            expect(connection.jobs.confirmedBeforeLoad, {job.uid: job});
          }
        });
      },
    );
  }
  testWidgets(
    'initialization can retry with its existing bucket after rejection',
    (final tester) async {
      await pumpForTest(tester, const SizedBox.shrink());
      await tester.runAsync(() async {
        await ready(initialized: false);
        var attempts = 0;
        when(() => api.initializeRepository(any())).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: attempts++ == 0
                ? ServerMutationOutcome.rejected
                : ServerMutationOutcome.confirmed,
            payload: ServerMutationPayload.available(aBackupConfiguration()),
          ),
        );
        final event = InitializeBackupsRepository(aBackupsCredential());
        await dispatch(event);
        expect(bloc.state, isA<BackupsUninitialized>());
        expect(
          bloc.state.backblazeBucket?.bucketId,
          aBackblazeBucket().bucketId,
        );
        await dispatch(event);
        expect(bloc.state, isA<BackupsInitialized>());
        final inputs = verify(
          () => api.initializeRepository(captureAny()),
        ).captured.cast<InitializeRepositoryInput>();
        expect(inputs, hasLength(2));
        expect(
          inputs.map((final input) => input.locationId),
          everyElement(aBackblazeBucket().bucketId),
        );
      });
    },
  );

  testWidgets('initialization needs an encryption key before calling the API', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      await ready(initialized: false);
      final emptyOrigin = ServerStateOrigin('empty');
      connection.dispose();
      origin = emptyOrigin;
      connection = ServerConnection(
        api: api,
        origin: emptyOrigin,
        currentOrigin: () => origin,
      )..setVersion(Version(3, 6, 0));
      when(() => repository.connection).thenReturn(connection);
      stubOperations(repository, connection);
      await dispatch(InitializeBackupsRepository(aBackupsCredential()));
      expect(bloc.state, isA<BackupsUninitialized>());
      verifyNever(() => api.initializeRepository(any()));
      verify(
        () => navigation.showSnackBar(
          'backup.backups_encryption_key_not_found'.tr(),
        ),
      ).called(1);
    });
  });

  testWidgets('mutation events do nothing before backup state loads', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      for (final event in <BackupsEvent>[
        const SetAutobackupPeriod(null),
        SetAutobackupQuotas(aBackupConfiguration().autobackupQuotas),
        const RemoveBackupsRepository(),
        InitializeBackupsRepository(aBackupsCredential()),
        const ForceSnapshotListUpdate(),
        const ForgetSnapshot('snapshot-1'),
        const RestoreBackup('snapshot-1', BackupRestoreStrategy.inplace),
        CreateBackups(services),
      ]) {
        bloc.add(event);
        await pumpEventQueue();
      }
      verifyZeroInteractions(api);
      expect(bloc.state, isA<BackupsInitial>());
    });
  });

  testWidgets('configuration completion does not restore a removed snapshot', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      await ready();
      final pending = Completer<ServerMutationResult<BackupConfiguration>>();
      when(
        () => api.setAutobackupPeriod(period: 15),
      ).thenAnswer((_) => pending.future);
      final id = connection.backups.value.data!.first.id;
      when(() => api.forgetSnapshot(id)).thenAnswer(
        (_) async => ServerMutationResult<void>(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      bloc.add(const SetAutobackupPeriod(Duration(minutes: 15)));
      await pumpEventQueue();
      await dispatch(ForgetSnapshot(id));
      pending.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aBackupConfiguration()),
        ),
      );
      await pumpEventQueue();
      expect(
        bloc.state.backups.map((final backup) => backup.id),
        isNot(contains(id)),
      );
    });
  });

  testWidgets('server switch stops a backup batch at its original connection', (
    final tester,
  ) async {
    await pumpForTest(tester, const SizedBox.shrink());
    await tester.runAsync(() async {
      await ready();
      final first = Completer<ServerMutationResult<ServerJob>>();
      when(
        () => api.startBackup(services.first.id),
      ).thenAnswer((_) => first.future);
      bloc.add(CreateBackups(services));
      await pumpEventQueue();
      final replacementApi = _Api();
      final replacementOrigin = ServerStateOrigin('replacement');
      final replacement = ServerConnection(
        api: replacementApi,
        origin: replacementOrigin,
        currentOrigin: () => origin,
      )..setVersion(Version(3, 6, 0));
      addTearDown(replacement.dispose);
      origin = replacementOrigin;
      when(() => repository.connection).thenReturn(replacement);
      bloc.add(const BackupsServerReset());
      await pumpEventQueue();
      first.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(aBackupJob()),
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<BackupsInitial>());
      expect(connection.jobs.value.data, isEmpty);
      expect(replacement.jobs.value.data, isNull);
      verify(() => api.startBackup(services.first.id)).called(1);
      for (final service in services.skip(1)) {
        verifyNever(() => api.startBackup(service.id));
      }
      verifyZeroInteractions(replacementApi);
    });
  });
}
