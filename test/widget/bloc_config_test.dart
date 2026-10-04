import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import '../fakes/hive/in_memory_hive.dart';
import '../helpers/fixtures/server_fixtures.dart';
import '../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late ResourcesModel resources;
  late ServerConnectionHub hub;
  late _Api api;
  setUp(() async {
    await setUpInMemoryHive();
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.serverInstallationBox);
    await Hive.openBox(BNames.wizardDataBox);
    resources = ResourcesModel()..init();
    api = _Api();
    hub = ServerConnectionHub(
      resourcesModel: resources,
      createApi: (_, _, _) => api,
    );
    getIt
      ..registerSingleton<ResourcesModel>(resources)
      ..registerSingleton<ServerConnectionHub>(hub)
      ..registerSingleton<WizardDataModel>(WizardDataModel())
      ..registerSingleton<NavigationService>(NavigationService());
  });
  tearDown(() async {
    hub.dispose();
    await resources.dispose();
    await getIt.reset();
    await tearDownInMemoryHive();
  });

  testWidgets('server BLoCs follow connection lifetime, not token rotation', (
    final tester,
  ) async {
    UsersBloc? users;
    ServerInstallationCubit? installation;
    await pumpForTest(
      tester,
      BlocAndProviderConfig(
        child: Builder(
          builder: (final context) {
            users = context.read<UsersBloc?>();
            installation = context.read<ServerInstallationCubit>();
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(users, isNull);
    final wizard = installation;
    await tester.runAsync(() async {
      await resources.addServer(aServer());
      await pumpEventQueue();
      await tester.pump();
      final first = users!;
      expect(first.isClosed, isFalse);
      expect(installation, same(wizard));

      when(api.refreshDeviceApiToken).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: const ServerMutationPayload.available('replacement'),
        ),
      );
      expect(await hub.active!.rotateToken(), RotationOutcome.succeeded);
      await pumpEventQueue();
      await tester.pump();
      expect(users, same(first));
      expect(first.isClosed, isFalse);

      await resources.updateServerByUuid(
        aServer(hostingDetails: aServerHostingDetails(apiToken: 'recovered')),
      );
      await pumpEventQueue();
      await tester.pump();
      await pumpEventQueue();
      await tester.pump();
      expect(users, isNot(same(first)));
      expect(first.isClosed, isTrue);
      expect(installation, same(wizard));
      final replacement = users!;

      await resources.removeServer(resources.servers.single);
      await pumpEventQueue();
      await tester.pump();
      await pumpEventQueue();
      await tester.pump();
      expect(users, isNull);
      expect(replacement.isClosed, isTrue);
      expect(installation, same(wizard));
      await tester.pumpWidget(const SizedBox.shrink());
      await pumpEventQueue();
      expect(tester.takeException(), isNull);
    });
  });
}
