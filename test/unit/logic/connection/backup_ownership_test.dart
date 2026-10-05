import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/backups/backups_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';

import '../../../fakes/hive/in_memory_hive.dart';
import '../../../helpers/fixtures/backup_fixtures.dart';
import '../../../helpers/fixtures/credential_fixtures.dart';
import '../../../helpers/fixtures/server_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Provider extends Mock implements BackupsProvider {}

class _Input extends Fake implements InitializeRepositoryInput {}

void main() {
  setUpAll(() => registerFallbackValue(_Input()));
  setUp(setUpInMemoryHive);
  tearDown(tearDownInMemoryHive);

  for (final transition in ['switch', 'replace', 'remove', 'reset']) {
    test(
      'pending backup creation preserves ownership on $transition',
      () async {
        await Hive.openBox(BNames.resourcesBox);
        final resources = ResourcesModel()..init();
        addTearDown(resources.dispose);
        final firstServer = aServer(uuid: 'first');
        await resources.addServer(firstServer);
        await resources.addServer(aServer(uuid: 'second'));
        final firstApi = _Api();
        final secondApi = _Api();
        final firstProvider = _Provider();
        final secondProvider = _Provider();
        final firstCredential = aBackupsCredential(uuid: 'first-account');
        final secondCredential = aBackupsCredential(uuid: 'second-account');
        final pendingStorage = Completer<GenericResult<String>>();
        when(
          () => firstProvider.createStorage(any()),
        ).thenAnswer((_) => pendingStorage.future);
        when(() => secondProvider.createStorage(any())).thenAnswer(
          (_) async => GenericResult(success: true, data: 'second-bucket'),
        );
        when(
          () => firstProvider.createApplicationKey('first-bucket'),
        ).thenAnswer(
          (_) async => GenericResult(
            success: true,
            data: aBackupsApplicationKey(
              applicationKeyId: 'first-generated-id',
              applicationKey: 'first-generated-secret',
            ),
          ),
        );
        when(
          () => secondProvider.createApplicationKey('second-bucket'),
        ).thenAnswer(
          (_) async => GenericResult(
            success: true,
            data: aBackupsApplicationKey(
              applicationKeyId: 'second-generated-id',
              applicationKey: 'second-generated-secret',
            ),
          ),
        );
        for (final api in [firstApi, secondApi]) {
          when(() => api.initializeRepository(any())).thenAnswer(
            (_) async => ServerMutationResult(
              outcome: ServerMutationOutcome.confirmed,
              payload: ServerMutationPayload.available(aBackupConfiguration()),
            ),
          );
        }
        final hub = ServerConnectionHub(
          resourcesModel: resources,
          createApi: (final binding, _, _) =>
              binding.serverId == 'first' ? firstApi : secondApi,
        );
        addTearDown(hub.dispose);
        final messages = <String>[];
        BackupsBloc presentation(final ServerConnection connection) {
          connection.cache.setVersion(Version(3, 6, 0));
          connection.backups.configStore.push(
            aBackupConfiguration().copyWith(isInitialized: false),
          );
          connection.backups.store.push([]);
          return createBackupsBloc(
            connection,
            resources: resources,
            showMessage: messages.add,
            createProvider: (final credential) {
              if (identical(credential, firstCredential)) {
                return firstProvider;
              }
              expect(credential, same(secondCredential));
              return secondProvider;
            },
          );
        }

        final first = hub.active!;
        final firstBloc = presentation(first);
        addTearDown(firstBloc.close);
        await pumpEventQueue();
        firstBloc.add(InitializeBackupsRepository(firstCredential));
        await pumpEventQueue();
        verify(() => firstProvider.createStorage(any())).called(1);
        await hub.selectServer('second');
        final closing = firstBloc.close();
        final second = hub.active!;
        final secondBloc = presentation(second);
        addTearDown(secondBloc.close);
        await pumpEventQueue();
        final initialized = secondBloc.stream.firstWhere(
          (final state) => state is BackupsInitialized,
        );
        secondBloc.add(InitializeBackupsRepository(secondCredential));
        await initialized;
        final secondInput =
            verify(
                  () => secondApi.initializeRepository(captureAny()),
                ).captured.single
                as InitializeRepositoryInput;
        expect(secondInput.locationId, 'second-bucket');
        expect(secondInput.login, 'second-generated-id');
        expect(secondInput.password, 'second-generated-secret');
        expect(
          resources.backblazeBucketFor('second')!.bucketId,
          'second-bucket',
        );
        expect(resources.backblazeBucketFor('first'), isNull);

        switch (transition) {
          case 'replace':
            await resources.updateServerByUuid(
              aServer(
                uuid: 'first',
                hostingDetails: aServerHostingDetails(apiToken: 'replacement'),
              ),
            );
          case 'remove':
            await resources.removeServer(firstServer);
          case 'reset':
            hub.clear();
            await resources.clear();
          case 'switch':
            break;
        }
        await pumpEventQueue();
        final previousMessages = List<String>.of(messages);
        final settled = transition == 'switch'
            ? first.operations.changes.firstWhere(
                (final operations) => !operations.single.status.isPending,
              )
            : Future<void>.value();
        pendingStorage.complete(
          GenericResult(success: true, data: 'first-bucket'),
        );
        await closing;
        await settled;
        await pumpEventQueue();
        expect(messages, previousMessages);
        if (transition == 'switch') {
          final firstInput =
              verify(
                    () => firstApi.initializeRepository(captureAny()),
                  ).captured.single
                  as InitializeRepositoryInput;
          expect(firstInput.locationId, 'first-bucket');
          expect(firstInput.login, 'first-generated-id');
          expect(firstInput.password, 'first-generated-secret');
          expect(first.isAttached, isTrue);
          await hub.selectServer('first');
          expect(hub.active, same(first));
          expect(first.backups.configValue.data!.isInitialized, isTrue);
        } else {
          expect(first.isAttached, isFalse);
          verifyNever(() => firstProvider.createApplicationKey(any()));
          verifyNever(() => firstApi.initializeRepository(any()));
        }
        hub.dispose();
        await resources.dispose();
        await Hive.box(BNames.resourcesBox).close();
        await Hive.openBox(BNames.resourcesBox);
        final reopened = ResourcesModel()..init();
        addTearDown(reopened.dispose);
        expect(
          reopened.backblazeBucketFor('first')?.bucketId,
          transition == 'switch' ? 'first-bucket' : null,
        );
        expect(
          reopened.backblazeBucketFor('second')?.bucketId,
          transition == 'reset' ? null : 'second-bucket',
        );
        if (transition == 'switch') {
          expect(
            reopened.backblazeBucketFor('first')!.applicationKeyId,
            'first-generated-id',
          );
          expect(
            reopened.backblazeBucketFor('first')!.applicationKey,
            'first-generated-secret',
          );
        }
        if (transition != 'reset') {
          expect(
            reopened.backblazeBucketFor('second')!.applicationKeyId,
            'second-generated-id',
          );
          expect(
            reopened.backblazeBucketFor('second')!.applicationKey,
            'second-generated-secret',
          );
        }
      },
    );
  }
}
