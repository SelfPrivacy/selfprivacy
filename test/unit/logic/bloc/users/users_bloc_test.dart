import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../../../helpers/connection_fixture.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

class _Api extends Mock implements ServerApi {}

void main() {
  late _MockApiConnectionRepository repository;
  late ApiData apiData;
  late StreamController<ApiData> dataController;
  late StreamController<ConnectionStatus> connectionStatusController;
  late UsersBloc usersBloc;
  late _Api api;
  late ServerConnection connection;

  setUp(() async {
    await getIt.reset();
    repository = _MockApiConnectionRepository();
    api = _Api();
    connection = seededConnection(api);
    apiData = ApiData(connection: () => connection);
    dataController = StreamController<ApiData>.broadcast();
    connectionStatusController = StreamController<ConnectionStatus>.broadcast();

    when(() => repository.apiData).thenReturn(apiData);
    when(() => repository.connection).thenReturn(connection);
    when(() => repository.dataStream).thenAnswer((_) => dataController.stream);
    when(
      () => repository.connectionStatusStream,
    ).thenAnswer((_) => connectionStatusController.stream);

    getIt.registerSingleton<ApiConnectionRepository>(repository);
    usersBloc = UsersBloc();
  });

  tearDown(() async {
    await usersBloc.close();
    connection.dispose();
    await dataController.close();
    await connectionStatusController.close();
    await getIt.reset();
  });

  test('keeps loading while user data is pending', () async {
    dataController.add(apiData);
    await Future<void>.delayed(Duration.zero);

    expect(usersBloc.state, isA<UsersInitial>());
  });

  test('loads an empty user list', () async {
    connection.users.store.push(const []);

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.users, isEmpty);
  });

  test('loads a root-only user list with no visible users', () async {
    connection.users.store.push([
      User.fake(login: 'root', type: UserType.root),
    ]);

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.orderedUsers, isEmpty);
  });

  test('reports an error when no user data is available', () async {
    when(api.getAllUsers).thenThrow(StateError('unavailable'));
    await connection.users.refresh(force: true);

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersError>());
  });

  test('keeps cached user data when a refresh fails', () async {
    connection.users.store.push([User.fake(login: 'alice')]);
    when(api.getAllUsers).thenThrow(StateError('unavailable'));
    await connection.users.refresh(force: true);

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.users, hasLength(1));
  });

  test('failure event and state expose equality properties', () {
    expect(const UsersLoadFailed().props, isEmpty);
    expect(UsersError().props, hasLength(1));
  });

  test('refresh dispatches only the users domain', () async {
    when(api.getAllUsers).thenAnswer((_) async => []);
    await usersBloc.refresh();
    expect(connection.users.value.data, isEmpty);
    verify(api.getAllUsers).called(1);
    verifyNever(() => repository.reload(any()));
  });
}
