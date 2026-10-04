import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

void main() {
  late StreamController<ConnectionObservation<CachedValue<List<User>>>> source;
  late UsersBloc bloc;
  late ServerStateOrigin origin;
  late int refreshes;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    refreshes = 0;
    bloc = UsersBloc(
      users: source.stream,
      save: (_, _, {required final create}) async => null,
      refresh: () async {
        refreshes++;
      },
    );
  });

  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  Future<void> publish(final CachedValue<List<User>> value) async {
    source.add(ConnectionObservation.attached(origin, value));
    await pumpEventQueue();
  }

  test('keeps loading while user data is pending', () async {
    await publish(const CachedValue());
    expect(bloc.state, isA<UsersRefreshing>());
  });

  test('loads an empty user list', () async {
    await publish(const CachedValue(data: []));
    expect(bloc.state, isA<UsersLoaded>());
    expect(bloc.state.users, isEmpty);
  });

  test('loads a root-only user list with no visible users', () async {
    await publish(
      CachedValue(
        data: [User.fake(login: 'root', type: UserType.root)],
      ),
    );
    expect(bloc.state, isA<UsersLoaded>());
    expect(bloc.state.orderedUsers, isEmpty);
  });

  test('reports an error when no user data is available', () async {
    await publish(CachedValue(lastError: StateError('unavailable')));
    expect(bloc.state, isA<UsersError>());
  });

  test('keeps cached user data when a refresh fails', () async {
    await publish(
      CachedValue(
        data: [User.fake(login: 'alice')],
        lastError: StateError('unavailable'),
      ),
    );
    expect(bloc.state, isA<UsersLoaded>());
    expect(bloc.state.users.single.login, 'alice');
  });

  test('reset fences already queued old-generation events', () async {
    final seen = <UsersState>[];
    final subscription = bloc.stream.listen(seen.add);
    source
      ..add(
        ConnectionObservation.attached(
          origin,
          CachedValue(data: [User.fake(login: 'old')]),
        ),
      )
      ..add(const ConnectionObservation.absent());
    await pumpEventQueue();
    expect(bloc.state, isA<UsersInitial>());
    expect(seen.whereType<UsersLoaded>(), isEmpty);
    await subscription.cancel();
  });

  test('refresh uses the injected users action', () async {
    await bloc.refresh();
    expect(refreshes, 1);
  });
}
