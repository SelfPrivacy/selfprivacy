import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/ui/pages/server/logs.dart';

import '../../helpers/widget_harness.dart';

class _MockServerLogsBloc extends Mock implements ServerLogsBloc {}

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
