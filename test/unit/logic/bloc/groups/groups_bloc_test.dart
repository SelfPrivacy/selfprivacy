import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';

void main() {
  late StreamController<CachedValue<List<String>>?> source;
  late GroupsBloc bloc;

  setUp(() {
    source = StreamController.broadcast(sync: true);
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
        const CachedValue(data: <String>[], support: DomainSupport.supported),
      );
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsLoaded>());
      source.add(const CachedValue(support: DomainSupport.unsupported));
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsUnsupported>());
      source.add(null);
      await pumpEventQueue();
      expect(bloc.state, isA<GroupsInitial>());
    },
  );

  test('reset fences already queued old-generation events', () async {
    final seen = <GroupsState>[];
    final subscription = bloc.stream.listen(seen.add);
    source
      ..add(const CachedValue(data: ['old']))
      ..add(null);
    await pumpEventQueue();
    expect(bloc.state, isA<GroupsInitial>());
    expect(seen.whereType<GroupsLoaded>(), isEmpty);
    await subscription.cancel();
  });
}
