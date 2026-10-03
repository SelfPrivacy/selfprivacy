import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';
import 'package:selfprivacy/logic/models/service.dart';

import '../../../../helpers/fixtures/service_fixtures.dart';

void main() {
  late StreamController<ConnectionObservation<CachedValue<List<Service>>>>
  source;
  late ServicesBloc bloc;
  late ServerStateOrigin origin;
  late Completer<ServerMutationResult<void>> pending;
  late List<String> feedback;
  late Completer<void> refresh;
  late int refreshes;

  setUp(() {
    source = StreamController.broadcast(sync: true);
    origin = ServerStateOrigin('server');
    pending = Completer();
    feedback = [];
    refresh = Completer<void>();
    refreshes = 0;
    bloc = ServicesBloc(
      services: source.stream,
      refresh: () {
        refreshes++;
        return refresh.future;
      },
      restart: (_, _) => pending.future,
      move: (_, _, _) async => null,
      showMessage: feedback.add,
    );
  });
  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  test('empty loaded services are not loading or unsupported', () async {
    source.add(
      ConnectionObservation.attached(origin, const CachedValue(data: [])),
    );
    await pumpEventQueue();
    expect(bloc.state, isA<ServicesLoaded>());
    source.add(
      ConnectionObservation.attached(
        origin,
        const CachedValue(support: DomainSupport.unsupported),
      ),
    );
    await pumpEventQueue();
    expect(bloc.state, isA<ServicesUnsupported>());
  });

  test('duplicate reloads remain droppable while a read is pending', () async {
    source.add(
      ConnectionObservation.attached(origin, const CachedValue(data: [])),
    );
    await pumpEventQueue();
    bloc
      ..add(const ServicesReload())
      ..add(const ServicesReload());
    await pumpEventQueue();
    refresh.complete();
    await pumpEventQueue();
    expect(refreshes, 1);
  });

  test(
    'unrelated replacement clears locks and discards late command feedback',
    () async {
      final service = aService();
      source.add(
        ConnectionObservation.attached(origin, CachedValue(data: [service])),
      );
      await pumpEventQueue();
      bloc.add(ServiceRestart(service));
      await pumpEventQueue();
      expect(bloc.state.lockedServices, [service.id]);
      origin = ServerStateOrigin('server');
      source.add(
        ConnectionObservation.attached(origin, CachedValue(data: [service])),
      );
      await pumpEventQueue();
      expect(bloc.state.lockedServices, isEmpty);
      pending.complete(
        ServerMutationResult(
          outcome: ServerMutationOutcome.rejected,
          payload: const ServerMutationPayload.notExpected(),
        ),
      );
      await pumpEventQueue();
      expect(feedback, isEmpty);
      expect(bloc.state.lockedServices, isEmpty);
    },
  );
}
