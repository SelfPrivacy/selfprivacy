import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/app_controller/inherited_app_controller.dart';
import 'package:selfprivacy/config/bloc_config.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/config/preferences_repository/datasources/preferences_hive_datasource.dart';
import 'package:selfprivacy/config/preferences_repository/inherited_preferences_repository.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/connection/lifecycle/token_rotation.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_repository.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';
import 'package:selfprivacy/ui/pages/more/about_application.dart';
import 'package:selfprivacy/ui/pages/more/console/console_page.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/server_storage/binds_migration/services_migration.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

import '../fakes/hive/in_memory_hive.dart';
import '../helpers/fixtures/domain_mutation_fixtures.dart';
import '../helpers/fixtures/json_fixture.dart';
import '../helpers/fixtures/server_fixtures.dart';
import '../helpers/fixtures/service_fixtures.dart';
import '../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Box extends Mock implements Box {}

void main() {
  setUpAll(setUpWidgetTestHarness);
  late ResourcesModel resources;
  late ServerConnectionHub hub;
  late _Api api;
  setUp(() async {
    PackageInfo.setMockInitialValues(
      appName: 'SelfPrivacy',
      packageName: 'org.selfprivacy.app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    await setUpInMemoryHive();
    await Hive.openBox(BNames.resourcesBox);
    await Hive.openBox(BNames.serverInstallationBox);
    await Hive.openBox(BNames.wizardDataBox);
    final preferences = await Hive.openBox(BNames.appSettingsBox);
    await preferences.put(BNames.shouldShowOnboarding, false);
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
      ..registerSingleton<ApiConfigModel>(ApiConfigModel())
      ..registerSingleton<ConsoleModel>(ConsoleModel())
      ..registerSingleton<DeveloperSettingsModel>(DeveloperSettingsModel())
      ..registerSingleton<NavigationService>(NavigationService());
  });

  Future<void> pumpApp(
    final WidgetTester tester,
    final RootRouter router,
  ) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          saveLocale: false,
          child: InheritedPreferencesRepository(
            dataSource: PreferencesHiveDataSource(),
            child: InheritedAppController(
              child: Builder(
                builder: (final context) {
                  final app = InheritedAppController.of(context);
                  if (!app.loaded) {
                    return const SizedBox.shrink();
                  }
                  return BlocAndProviderConfig(
                    child: MaterialApp.router(
                      theme: app.lightTheme,
                      darkTheme: app.darkTheme,
                      themeMode: app.themeMode,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      routerConfig: router.config(
                        deepLinkBuilder: (_) => const DeepLink([
                          RootRoute(children: [UsersRoute()]),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
      for (
        var attempt = 0;
        attempt < 100 && find.byType(UsersPage).evaluate().isEmpty;
        attempt++
      ) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        await tester.pump();
      }
    });
    expect(find.byType(UsersPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
  }

  for (final switching in [false, true]) {
    testWidgets(
      'server change preserves global routes and resets details: switching=$switching',
      (final tester) async {
        final router = RootRouter(getIt<NavigationService>().navigatorKey);
        await pumpApp(tester, router);
        await tester.runAsync(() async {
          await resources.addServer(aServer());
          await pumpEventQueue();
        });
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        await waitForContent(
          tester,
          () => find.byType(UsersPage).evaluate().isNotEmpty,
          'The users section must survive installation',
        );
        final original = hub.active!;
        final firstUsers = tester
            .element(find.byType(UsersPage))
            .read<UsersBloc>();
        final serverRouter = router.innerRouterOf<StackRouter>(RootRoute.name)!;
        unawaited(serverRouter.push(const DevicesRoute()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        when(api.refreshDeviceApiToken).thenAnswer(
          (_) async => ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: const ServerMutationPayload.available('replacement'),
          ),
        );
        await tester.runAsync(() async {
          expect(await hub.active!.rotateToken(), RotationOutcome.succeeded);
          final app = InheritedAppController.of(
            tester.element(find.byType(UsersPage, skipOffstage: false)),
          );
          await app.setDarkThemeModeFlag(useDark: true);
          await pumpEventQueue();
        });
        await tester.pump();
        expect(
          router.innerRouterOf<StackRouter>(RootRoute.name),
          same(serverRouter),
        );
        expect(serverRouter.current.name, DevicesRoute.name);
        expect(firstUsers.isClosed, isFalse);
        unawaited(serverRouter.push(const ConsoleRoute()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        final console = tester.state(find.byType(ConsolePage));
        expect(
          tester.element(find.byType(ConsolePage)).read<UsersBloc?>(),
          isNull,
        );
        expect(router.current.name, ConsoleRoute.name);

        await tester.runAsync(() async {
          if (switching) {
            await resources.addServer(aServer(uuid: 'other'));
            await pumpEventQueue();
            await hub.selectServer('other');
          } else {
            await resources.updateServerByUuid(
              aServer(
                hostingDetails: aServerHostingDetails(apiToken: 'replaced'),
              ),
            );
          }
          await pumpEventQueue();
        });
        await tester.pump();
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        expect(tester.state(find.byType(ConsolePage)), same(console));
        await waitForContent(
          tester,
          () => firstUsers.isClosed,
          'The replaced server BLoC must close',
        );
        await waitForContent(
          tester,
          () =>
              router.innerRouterOf<StackRouter>(RootRoute.name)?.current.name ==
              UsersRoute.name,
          'The replacement must restore the users section',
        );
        expect(firstUsers.isClosed, isTrue);
        expect(original.isAttached, switching);
        expect(
          router
              .innerRouterOf<StackRouter>(RootRoute.name)!
              .stack
              .map((final entry) => entry.name),
          [UsersRoute.name],
        );

        await router.maybePop();
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          tester.element(find.byType(UsersPage)).read<UsersBloc>(),
          isNot(same(firstUsers)),
        );
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        router.dispose();
      },
    );
  }

  testWidgets('reset removes server UI before persistence completes', (
    final tester,
  ) async {
    final router = RootRouter(getIt<NavigationService>().navigatorKey);
    await pumpApp(tester, router);
    await tester.runAsync(() async {
      await resources.addServer(aServer());
      await pumpEventQueue();
    });
    await waitForContent(
      tester,
      () =>
          find.byType(UsersPage).evaluate().isNotEmpty &&
          tester.element(find.byType(UsersPage)).read<UsersBloc?>() != null,
      'The server branch must be ready',
    );
    final pending = Completer<int>();
    final box = _Box();
    when(box.clear).thenAnswer((_) => pending.future);
    final repository = ServerInstallationRepository()..box = box;
    late Future<void> resetting;
    await tester.runAsync(() async {
      resetting = repository.clearAppConfig();
    });
    try {
      await tester.runAsync(pumpEventQueue);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final serverRouter = router.innerRouterOf<StackRouter>(RootRoute.name)!;
      for (final route in [
        const ServicesRoute(),
        const UsersRoute(),
        const MoreRoute(),
      ]) {
        await serverRouter.replaceAll([route]);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        expect(tester.takeException(), isNull);
      }
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(resources.servers, isNotEmpty);
    } finally {
      pending.complete(0);
      await tester.runAsync(() => resetting);
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
    }
  });

  testWidgets('all main sections work without server providers', (
    final tester,
  ) async {
    final router = RootRouter(getIt<NavigationService>().navigatorKey);
    await pumpApp(tester, router);
    final serverRouter = router.innerRouterOf<StackRouter>(RootRoute.name)!;
    for (final (route, page) in [
      (const ProvidersRoute(), ProvidersPage),
      (const ServicesRoute(), ServicesPage),
      (const UsersRoute(), UsersPage),
      (const MoreRoute(), MorePage),
    ]) {
      await serverRouter.replaceAll([route]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(page), findsOneWidget);
      expect(tester.element(find.byType(page)).read<UsersBloc?>(), isNull);
      expect(tester.takeException(), isNull);
    }
    unawaited(serverRouter.push(const AppSettingsRoute()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(router.current.name, AppSettingsRoute.name);
    await tester.tap(find.text('Services').hitTestable());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(router.current.name, RootRoute.name);
    expect(serverRouter.current.name, ServicesRoute.name);
    expect(find.byType(ServicesPage), findsOneWidget);
    expect(tester.takeException(), isNull);
    unawaited(router.push(const AboutApplicationRoute()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    await router.maybePop();
    unawaited(router.push(const DeveloperSettingsRoute()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    router.dispose();
  });

  testWidgets(
    'global server information follows replacement and migration opens locally',
    (final tester) async {
      final router = RootRouter(getIt<NavigationService>().navigatorKey);
      await pumpApp(tester, router);
      await tester.runAsync(() async {
        await resources.addServer(aServer());
        await pumpEventQueue();
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.runAsync(() async {
        hub.active!.cache.apiVersion.push(Version(3, 8, 3));
      });
      unawaited(router.push(const AboutApplicationRoute()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final about = tester.element(find.byType(AboutApplicationPage));
      expect(find.text('3.8.3'), findsOneWidget);
      await tester.tap(find.byTooltip('jobs.title'.tr()).hitTestable());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(JobsContent), findsOneWidget);
      Navigator.of(tester.element(find.byType(JobsContent))).pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.runAsync(() async {
        await resources.updateServerByUuid(
          aServer(
            hostingDetails: aServerHostingDetails(apiToken: 'replacement'),
          ),
        );
        await pumpEventQueue();
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.runAsync(() async {
        hub.active!.cache.apiVersion.push(Version(3, 9, 0));
      });
      await tester.pump();
      expect(find.text('3.8.3'), findsNothing);
      expect(find.text('3.9.0'), findsOneWidget);
      expect(tester.element(find.byType(AboutApplicationPage)), same(about));
      await waitForContent(
        tester,
        () => find
            .byTooltip('jobs.title'.tr())
            .hitTestable()
            .evaluate()
            .isNotEmpty,
        'Jobs must remain accessible after replacing the server branch',
      );
      await tester.tap(find.byTooltip('jobs.title'.tr()).hitTestable());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(JobsContent), findsOneWidget);
      Navigator.of(tester.element(find.byType(JobsContent))).pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await router.maybePop();
      unawaited(router.push(const DeveloperSettingsRoute()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final migration = find.text('storage.start_migration_button'.tr());
      await tester.scrollUntilVisible(
        migration,
        200,
        scrollable: find.byType(Scrollable).hitTestable().last,
      );
      await tester.tap(migration);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ServicesMigrationPage), findsOneWidget);
      expect(router.current.name, RootRoute.name);
      expect(
        router.innerRouterOf<StackRouter>(RootRoute.name)!.current.name,
        ServicesMigrationRoute.name,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
    },
  );

  testWidgets(
    'moving services opens progress once for the submitted selection',
    (final tester) async {
      final router = RootRouter(getIt<NavigationService>().navigatorKey);
      await pumpApp(tester, router);
      await tester.runAsync(() async {
        await resources.addServer(aServer());
        await pumpEventQueue();
      });
      await waitForContent(
        tester,
        () =>
            find.byType(UsersPage).evaluate().isNotEmpty &&
            tester.element(find.byType(UsersPage)).read<UsersBloc?>() != null,
        'The server branch must be ready',
      );
      final connection = hub.active!;
      final service = aService();
      final pending = Completer<ServerMutationResult<ServerJob>>();
      when(
        () => api.moveService(service.id, 'sdb'),
      ).thenAnswer((_) => pending.future);
      connection
        ..cache.setVersion(Version(3, 6, 0))
        ..services.store.push([service]);
      await tester.runAsync(pumpEventQueue);
      final services = tester
          .element(find.byType(UsersPage))
          .read<ServicesBloc>();
      when(() => api.moveService('nextcloud', 'sdb')).thenAnswer(
        (_) async => ServerMutationResult(
          outcome: ServerMutationOutcome.confirmed,
          payload: ServerMutationPayload.available(
            aServiceMoveJob(uid: 'move-nextcloud'),
          ),
        ),
      );
      services.add(ServicesMove({service.id: 'sdb', 'nextcloud': 'sdb'}));
      await tester.runAsync(pumpEventQueue);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(JobsContent), findsOneWidget);
      expect(connection.operations.history.single.jobIds, isEmpty);
      Navigator.of(tester.element(find.byType(JobsContent))).pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      unawaited(router.push(const ConsoleRoute()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.runAsync(() async {
        pending.complete(
          ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: ServerMutationPayload.available(aServiceMoveJob()),
          ),
        );
        await pumpEventQueue();
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(connection.operations.history.single.jobIds, hasLength(2));
      expect(find.byType(JobsContent, skipOffstage: false), findsNothing);
      expect(router.current.name, ConsoleRoute.name);
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
      hub.dispose();
    },
  );

  testWidgets(
    'removing server closes its root jobs sheet, not a global route',
    (final tester) async {
      final router = RootRouter(getIt<NavigationService>().navigatorKey);
      await pumpApp(tester, router);
      await tester.runAsync(() async {
        await resources.addServer(aServer());
        await pumpEventQueue();
      });
      await waitForContent(
        tester,
        () =>
            find.byType(UsersPage).evaluate().isNotEmpty &&
            tester.element(find.byType(UsersPage)).read<UsersBloc?>() != null,
        'The server branch must be ready',
      );
      unawaited(
        showModalJobsSheet(context: tester.element(find.byType(UsersPage))),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(JobsContent), findsOneWidget);
      final reboot = find.text('jobs.reboot_server'.tr());
      await tester.scrollUntilVisible(
        reboot,
        100,
        scrollable: find
            .descendant(
              of: find.byType(JobsContent),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(reboot);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AlertDialog), findsOneWidget);
      unawaited(router.push(const ConsoleRoute()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final console = tester.state(find.byType(ConsolePage));
      await tester.runAsync(() async {
        await resources.removeServer(resources.servers.single);
        await pumpEventQueue();
      });
      await tester.pump();
      await tester.runAsync(pumpEventQueue);
      await tester.pump();
      await waitForContent(
        tester,
        () =>
            find.byType(JobsContent, skipOffstage: false).evaluate().isEmpty &&
            find.byType(AlertDialog, skipOffstage: false).evaluate().isEmpty,
        'The old root sheet must be removed',
      );
      expect(tester.state(find.byType(ConsolePage)), same(console));
      expect(find.byType(AlertDialog, skipOffstage: false), findsNothing);
      await router.maybePop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
    },
  );
  tearDown(() async {
    hub.dispose();
    await resources.dispose();
    await getIt.reset();
    await tearDownInMemoryHive();
  });

  testWidgets(
    'server replacement closes a device confirmation without revoking',
    (final tester) async {
      final router = RootRouter(getIt<NavigationService>().navigatorKey);
      await pumpApp(tester, router);
      await tester.runAsync(() async {
        await resources.addServer(aServer());
        await pumpEventQueue();
      });
      await waitForContent(
        tester,
        () =>
            find.byType(UsersPage).evaluate().isNotEmpty &&
            tester.element(find.byType(UsersPage)).read<UsersBloc?>() != null,
        'The server branch must be ready',
      );
      final tokens = Query$GetApiTokens.fromJson(
        loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
            as Map<String, dynamic>,
      ).api.devices.map(ApiToken.fromGraphQL).toList();
      hub.active!.cache
        ..setVersion(Version(3, 6, 0))
        ..devices.push(tokens);
      final serverRouter = router.innerRouterOf<StackRouter>(RootRoute.name)!;
      unawaited(serverRouter.push(const DevicesRoute()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final device = tokens.firstWhere((final token) => !token.isCaller);
      await tester.tap(find.text(device.name));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.runAsync(() async {
        await resources.updateServerByUuid(
          aServer(hostingDetails: aServerHostingDetails(apiToken: 'replaced')),
        );
        await pumpEventQueue();
      });
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AlertDialog, skipOffstage: false), findsNothing);
      verifyNever(() => api.deleteApiToken(any()));
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
    },
  );

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
            expect(context.read<UsersBloc?>(), isNull);
            installation = context.read<ServerInstallationCubit>();
            return StreamBuilder<void>(
              stream: hub.changes,
              builder: (final context, _) {
                final connection = hub.active;
                if (connection == null) {
                  users = null;
                  return const SizedBox.shrink();
                }
                return ServerBlocConfig(
                  key: ObjectKey(connection),
                  connection: connection,
                  child: Builder(
                    builder: (final context) {
                      users = context.read<UsersBloc>();
                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
            );
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
