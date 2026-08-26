import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class _MockApiConnectionRepository extends Mock
    implements ApiConnectionRepository {}

void main() {
  late _MockApiConnectionRepository repository;
  late ApiData apiData;
  late StreamController<ApiData> dataController;
  late StreamController<ConnectionStatus> connectionStatusController;
  late UsersBloc usersBloc;

  setUp(() async {
    await getIt.reset();
    repository = _MockApiConnectionRepository();
    apiData = ApiData(ServerApi());
    dataController = StreamController<ApiData>.broadcast();
    connectionStatusController = StreamController<ConnectionStatus>.broadcast();

    when(() => repository.apiData).thenReturn(apiData);
    when(() => repository.dataStream).thenAnswer((_) => dataController.stream);
    when(
      () => repository.connectionStatusStream,
    ).thenAnswer((_) => connectionStatusController.stream);

    getIt.registerSingleton<ApiConnectionRepository>(repository);
    usersBloc = UsersBloc();
  });

  tearDown(() async {
    await usersBloc.close();
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
    apiData.users.data = const [];

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.users, isEmpty);
  });

  test('loads a root-only user list with no visible users', () async {
    apiData.users.data = const [User.fake(login: 'root', type: UserType.root)];

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.orderedUsers, isEmpty);
  });

  test('reports an error when no user data is available', () async {
    apiData.users.lastError = const StaleDataError();

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersError>());
  });

  test('keeps cached user data when a refresh fails', () async {
    apiData.users.data = const [User.fake(login: 'alice')];
    apiData.users.lastError = const StaleDataError();

    final nextState = usersBloc.stream.first;
    dataController.add(apiData);

    expect(await nextState, isA<UsersLoaded>());
    expect(usersBloc.state.users, hasLength(1));
  });

  test('failure event and state expose equality properties', () {
    expect(const UsersLoadFailed().props, isEmpty);
    expect(UsersError().props, hasLength(1));
  });
}
