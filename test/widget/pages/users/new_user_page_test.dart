import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/pages/users/new_user.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/widget_harness.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

class _MockUsersBloc extends Mock implements UsersBloc {}

class _MockGroupsBloc extends Mock implements GroupsBloc {}

class _MockServicesBloc extends Mock implements ServicesBloc {}

class _MockAppReadinessCubit extends Mock implements AppReadinessCubit {}

class _TestRouter extends RootStackRouter {
  _TestRouter(final GlobalKey<NavigatorState> navigatorKey)
    : super(navigatorKey: navigatorKey);

  @override
  final List<AutoRoute> routes = [AutoRoute(page: NewUserRoute.page)];
}

void main() {
  setUpAll(() async {
    await setUpWidgetTestHarness();
    registerFallbackValue(const User.fake());
  });

  late _MockApiConnectionRepository repository;
  late _MockUsersBloc usersBloc;
  late _MockGroupsBloc groupsBloc;
  late _MockServicesBloc servicesBloc;
  late _MockAppReadinessCubit appReadinessCubit;

  setUp(() async {
    await getIt.reset();
    repository = _MockApiConnectionRepository();
    usersBloc = _MockUsersBloc();
    groupsBloc = _MockGroupsBloc();
    servicesBloc = _MockServicesBloc();
    appReadinessCubit = _MockAppReadinessCubit();
    final apiData = ApiData(ServerApi(domainProvider: () => null));
    apiData.groups.data = const [];
    apiData.users.data = const [User.fake(login: 'alice')];
    when(() => repository.apiData).thenReturn(apiData);
    getIt.registerSingleton<ApiConnectionRepository>(repository);

    when(() => usersBloc.state).thenReturn(UsersLoaded(users: const []));
    when(
      () => usersBloc.stream,
    ).thenAnswer((_) => const Stream<UsersState>.empty());
    when(() => groupsBloc.state).thenReturn(GroupsInitial());
    when(
      () => groupsBloc.stream,
    ).thenAnswer((_) => const Stream<GroupsState>.empty());
    when(() => servicesBloc.state).thenReturn(ServicesInitial());
    when(
      () => servicesBloc.stream,
    ).thenAnswer((_) => const Stream<ServicesState>.empty());
    when(() => appReadinessCubit.state).thenReturn(NoServer());
    when(
      () => appReadinessCubit.stream,
    ).thenAnswer((_) => const Stream<AppReadinessState>.empty());
  });

  tearDown(getIt.reset);

  testWidgets('editing a user pops the form after a successful update', (
    final tester,
  ) async {
    const user = User.fake(
      login: 'alice',
      displayName: 'Alice',
      directmemberof: ['sp.full_users'],
    );
    final router = _TestRouter(GlobalKey<NavigatorState>());
    when(
      () => repository.updateUser(any()),
    ).thenAnswer((_) => Future.value((true, '')));

    await _pumpRouter(
      tester,
      router: router,
      routes: [NewUserRoute(user: user)],
      usersBloc: usersBloc,
      groupsBloc: groupsBloc,
      servicesBloc: servicesBloc,
      appReadinessCubit: appReadinessCubit,
    );

    final submitButton = find.byType(FilledButton);
    tester.widget<FilledButton>(submitButton).onPressed!();
    await tester.pumpAndSettle();

    expect(router.stack, isEmpty);
    verify(() => repository.updateUser(any())).called(1);
  });

  testWidgets('group selection keeps explicit groups when primary changes', (
    final tester,
  ) async {
    final groupsControl = FormControl<List<String>>(
      value: ['sp.admins', 'service.group'],
    );
    addTearDown(groupsControl.dispose);

    await pumpForTest(
      tester,
      MultiBlocProvider(
        providers: [
          BlocProvider<GroupsBloc>.value(value: groupsBloc),
          BlocProvider<ServicesBloc>.value(value: servicesBloc),
        ],
        child: SingleChildScrollView(
          child: GroupsSelector(groupsControl: groupsControl),
        ),
      ),
    );

    await tester.tap(find.text('Full user'));
    await tester.pumpAndSettle();

    expect(groupsControl.value, ['sp.full_users', 'service.group']);
  });
}

Future<void> _pumpRouter(
  final WidgetTester tester, {
  required final RootStackRouter router,
  required final List<PageRouteInfo> routes,
  required final UsersBloc usersBloc,
  required final GroupsBloc groupsBloc,
  required final ServicesBloc servicesBloc,
  required final AppReadinessCubit appReadinessCubit,
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
          ],
          child: Builder(
            builder: (final context) => MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerConfig: router.config(
                deepLinkBuilder: (final _) => DeepLink(routes),
              ),
            ),
          ),
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
  });
  await tester.pumpAndSettle();
}
