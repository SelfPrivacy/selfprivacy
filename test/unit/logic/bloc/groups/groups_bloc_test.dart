import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

void main() {
  late StreamController<ConnectionObservation<CachedValue<List<String>>>>
  source;
  late GroupsBloc bloc;
  late ServerStateOrigin origin;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    bloc = GroupsBloc(groups: source.stream, refresh: () async {});
  });
  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  test('loaded groups retain their snapshot without a global repository', () {
    final input = ['sp.full_users'];
    final state = GroupsLoaded(groups: input);
    input.add('sp.admin');
    expect(state.groups, ['sp.full_users']);
    expect(state.groups.clear, throwsUnsupportedError);
  });

  test(
    'an empty loaded collection is distinct from absent and unsupported',
    () async {
      source.add(
        ConnectionObservation.attached(
          origin,
          const CachedValue(data: <String>[], support: DomainSupport.supported),
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsLoaded>());
      source.add(
        ConnectionObservation.attached(
          origin,
          const CachedValue(support: DomainSupport.unsupported),
        ),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsUnsupported>());
      source.add(const ConnectionObservation.absent());
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsInitial>());
    },
  );

  test('reset fences already queued old-generation events', () async {
    final seen = <GroupsState>[];
    final subscription = bloc.stream.listen(seen.add);
    source
      ..add(
        ConnectionObservation.attached(
          origin,
          const CachedValue(data: ['old']),
        ),
      )
      ..add(const ConnectionObservation.absent());
    await pumpEventQueue();
    expect(bloc.state, isA<GroupsInitial>());
    expect(seen.whereType<GroupsLoaded>(), isEmpty);
    await subscription.cancel();
  });
}
