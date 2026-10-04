import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';

import '../../../../fakes/graphql/link_transport.dart';
import '../../../../helpers/fixtures/json_fixture.dart';
import '../../../../helpers/operation_fixture.dart';

class _DelayedApi extends ServerApi {
  _DelayedApi({required super.transport});
  Completer<void>? waiting;
  Completer<void>? acquiring;

  @override
  Future<GraphQLClient> getClient() async {
    acquiring?.complete();
    acquiring = null;
    await waiting?.future;
    return super.getClient();
  }
}

void main() {
  for (final close in [false, true]) {
    test(
      'a late log page is discarded after ${close ? 'close' : 'reset'}',
      () async {
        final api = _DelayedApi(
          transport: transportWithLink(
            Link.function(
              (_, [final forward]) => Stream.value(
                Response(
                  response: const {},
                  data: loadJsonFixture('graphql/logs.json'),
                ),
              ),
            ),
          ),
        );
        final hub = fixtureHub(api);
        final bloc = createServerLogsBloc(hub.active!);
        addTearDown(bloc.close);
        final waiting = api.waiting = Completer<void>();
        final acquiring = api.acquiring = Completer<void>();
        bloc.add(const ServerLogsFetch());
        await acquiring.future;
        final closing = close ? bloc.close() : null;
        if (!close) {
          hub.clear();
          await pumpEventQueue();
          expect(bloc.state, isA<ServerLogsInitial>());
        }
        waiting.complete();
        await closing;
        await pumpEventQueue();
        expect(bloc.state, isNot(isA<ServerLogsLoaded>()));
      },
    );
  }

  test(
    'loaded logs survive admission closing during client acquisition',
    () async {
      late ServerConnectionHub hub;
      var pages = 0;
      final api = _DelayedApi(
        transport: transportWithLink(
          Link.function((_, [final forward]) {
            if (!hub.active!.canRead) {
              return Stream.error(const GraphQLDispatchDeferred());
            }
            pages++;
            return Stream.value(
              Response(
                response: const {},
                data: loadJsonFixture('graphql/logs.json'),
              ),
            );
          }),
        ),
      );
      hub = fixtureHub(api);
      final bloc = createServerLogsBloc(hub.active!);
      addTearDown(bloc.close);
      final initial = bloc.stream.firstWhere(
        (final state) => state is ServerLogsLoaded || state is ServerLogsError,
      );
      bloc.add(const ServerLogsFetch());
      final loaded = await initial;
      expect(loaded, isA<ServerLogsLoaded>());
      final previous = loaded as ServerLogsLoaded;
      expect(previous.oldEntries.single.message, 'Started Gitea service.');
      expect(previous.oldEntries.clear, throwsUnsupportedError);

      final acquiring = api.acquiring = Completer<void>();
      final waiting = api.waiting = Completer<void>();
      bloc.add(const ServerLogsFetch());
      await acquiring.future;
      final work = Completer<void>();
      final operation = hub.active!.submit(
        OperationKind.manageJobs,
        (_) => work.future,
      );
      final rotation = hub.active!.rotateToken();
      api.waiting = null;
      waiting.complete();
      await pumpEventQueue();
      expect(bloc.state, same(previous));
      expect(pages, 1);
      hub.active!.cancelRotation();
      await rotation;
      await pumpEventQueue();
      expect(pages, 2);
      expect((bloc.state as ServerLogsLoaded).oldEntries, previous.oldEntries);
      work.complete();
      await operation.completion;
    },
  );
}
