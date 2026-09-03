import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/fixtures/server_fixtures.dart';
import '../../../helpers/widget_harness.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

class _MockUsersBloc extends Mock implements UsersBloc {}

class _MockGroupsBloc extends Mock implements GroupsBloc {}

class _MockServicesBloc extends Mock implements ServicesBloc {}

class _MockAppReadinessCubit extends Mock implements AppReadinessCubit {}

class _MockOutdatedServerCheckerBloc extends Mock
    implements OutdatedServerCheckerBloc {}

class _TestRouter extends RootStackRouter {
  _TestRouter(final GlobalKey<NavigatorState> navigatorKey)
    : super(navigatorKey: navigatorKey);

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: UsersRoute.page),
    AutoRoute(page: NewUserRoute.page),
  ];
}

void main() {
  setUpAll(setUpWidgetTestHarness);

  late _MockApiConnectionRepository repository;
  late ApiData apiData;
  late _MockUsersBloc usersBloc;
  late _MockGroupsBloc groupsBloc;
  late _MockServicesBloc servicesBloc;
  late _MockAppReadinessCubit appReadinessCubit;
  late _MockOutdatedServerCheckerBloc outdatedServerCheckerBloc;

  setUp(() async {
    await getIt.reset();
    repository = _MockApiConnectionRepository();
    apiData = ApiData(ServerApi(domainProvider: () => null));
    usersBloc = _MockUsersBloc();
    groupsBloc = _MockGroupsBloc();
    servicesBloc = _MockServicesBloc();
    appReadinessCubit = _MockAppReadinessCubit();
    outdatedServerCheckerBloc = _MockOutdatedServerCheckerBloc();

    when(() => repository.apiData).thenReturn(apiData);
    getIt.registerSingleton<ApiConnectionRepository>(repository);

    when(
      () => usersBloc.stream,
    ).thenAnswer((_) => const Stream<UsersState>.empty());
    when(() => usersBloc.refresh()).thenAnswer((_) async {});
    when(() => groupsBloc.state).thenReturn(GroupsInitial());
    when(
      () => groupsBloc.stream,
    ).thenAnswer((_) => const Stream<GroupsState>.empty());
    when(() => servicesBloc.state).thenReturn(ServicesInitial());
    when(
      () => servicesBloc.stream,
    ).thenAnswer((_) => const Stream<ServicesState>.empty());
    when(() => appReadinessCubit.state).thenReturn(ServerConfigured(aServer()));
    when(
      () => appReadinessCubit.stream,
    ).thenAnswer((_) => const Stream<AppReadinessState>.empty());
    when(
      () => outdatedServerCheckerBloc.state,
    ).thenReturn(OutdatedServerCheckerInitial());
    when(
      () => outdatedServerCheckerBloc.stream,
    ).thenAnswer((_) => const Stream<OutdatedServerCheckerState>.empty());
  });

  tearDown(getIt.reset);

  Future<void> pumpRouter(
    final WidgetTester tester,
    final RootStackRouter router, {
    final bool settle = true,
  }) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          useFallbackTranslations: true,
          saveLocale: false,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<UsersBloc>.value(value: usersBloc),
              BlocProvider<GroupsBloc>.value(value: groupsBloc),
              BlocProvider<ServicesBloc>.value(value: servicesBloc),
              BlocProvider<AppReadinessCubit>.value(value: appReadinessCubit),
              BlocProvider<OutdatedServerCheckerBloc>.value(
                value: outdatedServerCheckerBloc,
              ),
            ],
            child: Builder(
              builder: (final context) => MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: router.config(
                  deepLinkBuilder: (final _) => const DeepLink([UsersRoute()]),
                ),
              ),
            ),
          ),
        ),
      );
      await Future<void>.delayed(Duration.zero);
    });
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
    }
  }

  testWidgets('shows an empty state for a root-only user list', (
    final tester,
  ) async {
    const rootUser = User.fake(login: 'root', type: UserType.root);
    apiData.users.data = const [rootUser];
    when(
      () => usersBloc.state,
    ).thenReturn(UsersLoaded(users: const [rootUser]));
    final router = _TestRouter(GlobalKey<NavigatorState>());

    await pumpRouter(tester, router);

    expect(find.text('Nobody here'), findsOneWidget);
    expect(find.text('Add a first user'), findsOneWidget);
    expect(find.text("Couldn't fetch users list"), findsNothing);

    await tester.tap(find.text('Add a first user'));
    await tester.pumpAndSettle();

    expect(router.stack.last.name, NewUserRoute.name);
  });

  testWidgets('shows the fetch error and retries', (final tester) async {
    when(() => usersBloc.state).thenReturn(UsersError());
    final router = _TestRouter(GlobalKey<NavigatorState>());

    await pumpRouter(tester, router);

    expect(find.text("Couldn't fetch users list"), findsOneWidget);
    expect(find.text('Refresh users list'), findsOneWidget);
    expect(find.text('Nobody here'), findsNothing);

    await tester.tap(find.text('Refresh users list'));

    verify(() => usersBloc.refresh()).called(1);
  });

  testWidgets('shows a loaded user', (final tester) async {
    const user = User.fake(login: 'alice');
    apiData.users.data = const [user];
    when(() => usersBloc.state).thenReturn(UsersLoaded(users: const [user]));
    final router = _TestRouter(GlobalKey<NavigatorState>());

    await pumpRouter(tester, router);

    expect(find.text('alice'), findsOneWidget);
    expect(find.text('Nobody here'), findsNothing);
    expect(find.text("Couldn't fetch users list"), findsNothing);
  });

  for (final state in [UsersInitial(), UsersRefreshing(users: const [])]) {
    testWidgets('${state.runtimeType} shows the loading list', (
      final tester,
    ) async {
      when(() => usersBloc.state).thenReturn(state);
      final router = _TestRouter(GlobalKey<NavigatorState>());

      await pumpRouter(tester, router, settle: false);

      expect(find.text('New user'), findsOneWidget);
      expect(find.text('Nobody here'), findsNothing);
      expect(find.text("Couldn't fetch users list"), findsNothing);
    });
  }
}
