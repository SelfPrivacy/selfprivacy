import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/ui/pages/server/logs.dart';

import '../../helpers/operation_fixture.dart';
import '../../helpers/widget_harness.dart';

class _MockServerLogsBloc extends Mock implements ServerLogsBloc {}

class _Api extends Mock implements ServerApi {}

void main() {
  setUpAll(setUpWidgetTestHarness);

  late _MockServerLogsBloc serverLogsBloc;

  setUp(() {
    serverLogsBloc = _MockServerLogsBloc();
    when(() => serverLogsBloc.state).thenReturn(
      ServerLogsLoaded(
        oldEntries: [
          ServerLogEntry(
            message: 'Started service',
            cursor: 'cursor-1',
            priority: 6,
            systemdSlice: null,
            systemdUnit: 'example.service',
            timestamp: DateTime.utc(2026),
          ),
        ],
        newEntries: const [],
        meta: const ServerLogsPageMeta(downCursor: null, upCursor: null),
        loadingMore: false,
      ),
    );
    when(
      () => serverLogsBloc.stream,
    ).thenAnswer((_) => const Stream<ServerLogsState>.empty());
  });

  for (final pagination in [false, true]) {
    test(
      'deferred logs retain state and resume after rotation: pagination=$pagination',
      () async {
        final api = _Api();
        final hub = fixtureHub(api);
        final fixture = serverLogsBloc.state as ServerLogsLoaded;
        when(
          () => api.getServerLogs(
            limit: 50,
            upCursor: any(named: 'upCursor'),
            downCursor: any(named: 'downCursor'),
            slice: any(named: 'slice'),
            unit: any(named: 'unit'),
          ),
        ).thenAnswer(
          (_) async => (
            fixture.oldEntries.toList(),
            const ServerLogsPageMeta(downCursor: null, upCursor: 'cursor-1'),
          ),
        );
        final bloc = createServerLogsBloc(hub);
        addTearDown(bloc.close);
        if (pagination) {
          bloc.add(const ServerLogsFetch());
          await pumpEventQueue();
          expect(bloc.state, isA<ServerLogsLoaded>());
        }
        final before = bloc.state;
        final work = Completer<void>();
        final operation = hub.submit(
          OperationKind.manageJobs,
          (_) => work.future,
        );
        final rotation = hub.rotateToken();
        bloc.add(pagination ? ServerLogsFetchMore() : const ServerLogsFetch());
        await pumpEventQueue();
        expect(
          bloc.state,
          pagination ? same(before) : isA<ServerLogsLoading>(),
        );
        expect(hub.cancelRotation(), isTrue);
        await rotation;
        await pumpEventQueue();
        expect(bloc.state, isA<ServerLogsLoaded>());
        expect((bloc.state as ServerLogsLoaded).oldEntries, fixture.oldEntries);
        work.complete();
        await operation.completion;
      },
    );
  }

  testWidgets('enables the all-units log-filter option', (final tester) async {
    await pumpForTest(
      tester,
      BlocProvider<ServerLogsBloc>.value(
        value: serverLogsBloc,
        child: const ServerLogsPage(),
      ),
    );

    tester
        .state<ScaffoldState>(
          find.descendant(
            of: find.byType(ServerLogsPage),
            matching: find.byType(Scaffold),
          ),
        )
        .openEndDrawer();
    await tester.pumpAndSettle();

    final Finder filterOptions = find.byType(RadioListTile<String?>);
    expect(find.byType(RadioGroup<String?>), findsOneWidget);
    expect(filterOptions, findsNWidgets(2));

    for (var index = 0; index < 2; index++) {
      final Finder listTile = find.descendant(
        of: filterOptions.at(index),
        matching: find.byType(ListTile),
      );
      expect(tester.widget<ListTile>(listTile).enabled, isTrue);
    }

    await tester.tap(filterOptions.at(1));
    await tester.pump();
    expect(
      tester
          .widget<RadioGroup<String?>>(find.byType(RadioGroup<String?>))
          .groupValue,
      'example.service',
    );

    await tester.tap(filterOptions.at(0));
    await tester.pump();
    expect(
      tester
          .widget<RadioGroup<String?>>(find.byType(RadioGroup<String?>))
          .groupValue,
      isNull,
    );
  });
}
