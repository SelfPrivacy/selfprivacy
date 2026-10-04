import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/forms/user_form_view.dart';
import 'package:selfprivacy/ui/pages/users/new_user.dart';
import 'package:selfprivacy/ui/router/router.dart';

import '../../../helpers/widget_harness.dart';

class _Navigation extends Mock implements NavigationService {}

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
    registerFallbackValue(User.fake());
  });

  late ConnectionContinuity continuity;
  late _MockUsersBloc usersBloc;
  late _MockGroupsBloc groupsBloc;
  late _MockServicesBloc servicesBloc;
  late _MockAppReadinessCubit appReadinessCubit;

  setUp(() async {
    await getIt.reset();
    continuity = ConnectionContinuity();
    usersBloc = _MockUsersBloc();
    groupsBloc = _MockGroupsBloc();
    servicesBloc = _MockServicesBloc();
    appReadinessCubit = _MockAppReadinessCubit();
    getIt.registerSingleton<NavigationService>(_Navigation());

    when(() => usersBloc.state).thenReturn(
      UsersLoaded(
        users: [User.fake(login: 'alice')],
        continuity: continuity,
      ),
    );
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
    final user = User.fake(
      login: 'alice',
      displayName: 'Alice',
      directmemberof: const ['sp.full_users'],
    );
    final router = _TestRouter(GlobalKey<NavigatorState>());
    when(
      () => usersBloc.saveUser(any(), continuity: continuity, create: false),
    ).thenAnswer(
      (_) async => ServerMutationResult(
        outcome: ServerMutationOutcome.confirmed,
        payload: ServerMutationPayload.available(user),
      ),
    );

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
    verify(
      () => usersBloc.saveUser(any(), continuity: continuity, create: false),
    ).called(1);
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

  testWidgets('login validation uses the current user snapshot', (
    final tester,
  ) async {
    final router = _TestRouter(GlobalKey<NavigatorState>());
    await _pumpRouter(
      tester,
      router: router,
      routes: [NewUserRoute()],
      usersBloc: usersBloc,
      groupsBloc: groupsBloc,
      servicesBloc: servicesBloc,
      appReadinessCubit: appReadinessCubit,
    );
    final form = tester
        .widget<UserFormView>(find.byType(UserFormView))
        .userForm;
    when(() => usersBloc.state).thenReturn(
      UsersLoaded(
        users: [User.fake(login: 'bob')],
        continuity: continuity,
      ),
    );
    final login = form.form.control(UserForm.loginControlName)
      ..updateValue('bob');
    expect(login.hasError(UserForm.errLoginTaken), isTrue);
  });

  testWidgets(
    'form drafts survive rotation continuity and clear on reset or replacement',
    (final tester) async {
      final updates = StreamController<UsersState>.broadcast(sync: true);
      when(() => usersBloc.stream).thenAnswer((_) => updates.stream);
      final router = _TestRouter(GlobalKey<NavigatorState>());
      await _pumpRouter(
        tester,
        router: router,
        routes: [NewUserRoute()],
        usersBloc: usersBloc,
        groupsBloc: groupsBloc,
        servicesBloc: servicesBloc,
        appReadinessCubit: appReadinessCubit,
      );
      final original = tester
          .widget<UserFormView>(find.byType(UserFormView))
          .userForm;
      original.form
          .control(UserForm.loginControlName)
          .updateValue('draft-user');
      void publish(final UsersState state) {
        when(() => usersBloc.state).thenReturn(state);
        updates.add(state);
      }

      publish(
        UsersLoaded(
          users: [User.fake(login: 'bob')],
          continuity: continuity,
        ),
      );
      await tester.pump();
      expect(
        tester.widget<UserFormView>(find.byType(UserFormView)).userForm,
        same(original),
      );
      expect(
        original.form.control(UserForm.loginControlName).value,
        'draft-user',
      );
      publish(UsersInitial());
      await tester.pump();
      expect(find.byType(UserFormView), findsNothing);
      publish(
        UsersLoaded(
          users: [User.fake(login: 'carol')],
          continuity: ConnectionContinuity(),
        ),
      );
      await tester.pump();
      final replacement = tester
          .widget<UserFormView>(find.byType(UserFormView))
          .userForm;
      expect(replacement, isNot(same(original)));
      expect(
        replacement.form.control(UserForm.loginControlName).value,
        isEmpty,
      );
      replacement.form.control(UserForm.loginControlName).updateValue('carol');
      expect(
        replacement.form
            .control(UserForm.loginControlName)
            .hasError(UserForm.errLoginTaken),
        isTrue,
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.runAsync(updates.close);
    },
  );
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
