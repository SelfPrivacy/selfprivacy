import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/connection_blocs.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/devices/devices_bloc.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/ui/molecules/list_items/device_item.dart';
import 'package:selfprivacy/ui/pages/devices/devices.dart';

import '../../../helpers/fixtures/json_fixture.dart';
import '../../../helpers/operation_fixture.dart';
import '../../../helpers/widget_harness.dart';

class _Api extends Mock implements ServerApi {}

class _Navigation extends Mock implements NavigationService {}

void main() {
  late _Api api;
  late ServerConnection connection;
  late DevicesBloc bloc;
  late List<ApiToken> tokens;
  setUpAll(setUpWidgetTestHarness);
  setUp(() async {
    await getIt.reset();
    api = _Api();
    tokens = Query$GetApiTokens.fromJson(
      loadJsonFixture('graphql/domain_reads.json')['GetApiTokens']
          as Map<String, dynamic>,
    ).api.devices.map(ApiToken.fromGraphQL).toList();
    when(api.fetchApiVersion).thenAnswer((_) async => '3.6.0');
    when(api.getApiTokens).thenAnswer((_) async => tokens);
    final hub = fixtureHub(api);
    connection = hub.active!;
    getIt.registerSingleton<NavigationService>(_Navigation());
    bloc = createDevicesBloc(
      hub,
      showMessage: getIt<NavigationService>().showSnackBar,
    );
  });
  tearDown(() async {
    await bloc.close();
    connection.dispose();
    await getIt.reset();
  });

  Future<void> showPage(final WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpForTest(
      tester,
      BlocProvider.value(value: bloc, child: const DevicesPage()),
    );
  }

  testWidgets(
    'confirming a device row dispatches once and retains it until confirmation',
    (final tester) async {
      final device = tokens.firstWhere((final token) => !token.isCaller);
      final pending = Completer<ServerMutationResult<void>>();
      when(
        () => api.deleteApiToken(device.name),
      ).thenAnswer((_) => pending.future);
      await tester.runAsync(bloc.refresh);
      await showPage(tester);
      await tester.tap(find.text(device.name));
      await tester.pumpAndSettle();
      final confirm = find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.byType(TextButton),
          )
          .last;
      await tester.runAsync(() async {
        await tester.tap(confirm);
        await pumpEventQueue();
      });
      await tester.pump();
      expect(tester.takeException(), isNull);
      verify(() => api.deleteApiToken(device.name)).called(1);
      expect(bloc.state.pendingDeviceName, device.name);
      expect(find.text(device.name), findsOneWidget);
      await tester.runAsync(() async {
        pending.complete(
          ServerMutationResult(
            outcome: ServerMutationOutcome.confirmed,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
        await pumpEventQueue();
      });
      await tester.pumpAndSettle();
      expect(find.text(device.name), findsNothing);
      verifyNever(() => api.deleteApiToken(device.name));
    },
  );

  for (final outcome in ServerMutationOutcome.values) {
    testWidgets('visible list follows ${outcome.name} before polling', (
      final tester,
    ) async {
      await tester.runAsync(() async {
        await bloc.refresh();
      });
      await showPage(tester);
      final device = tokens.firstWhere((final token) => !token.isCaller);
      final pending = Completer<ServerMutationResult<void>>();
      when(
        () => api.deleteApiToken(device.name),
      ).thenAnswer((_) => pending.future);
      await tester.runAsync(() async {
        final deleting = bloc.stream.firstWhere(
          (final state) => state is DevicesDeleting,
        );
        bloc.add(DeleteDevice(device));
        await deleting;
      });
      await tester.pump();
      expect(find.text(device.name), findsOneWidget);
      final item = tester.widget<DeviceItem>(find.byKey(ValueKey(device.name)));
      expect(item.pending, isTrue);
      expect(item.enabled, isFalse);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.runAsync(() async {
        final loaded = bloc.stream.firstWhere(
          (final state) => state is DevicesLoaded,
        );
        pending.complete(
          ServerMutationResult(
            outcome: outcome,
            payload: const ServerMutationPayload.notExpected(),
          ),
        );
        await loaded;
      });
      await tester.pumpAndSettle();
      expect(
        find.text(device.name),
        outcome == ServerMutationOutcome.confirmed
            ? findsNothing
            : findsOneWidget,
      );
      expect(
        find.text('No other devices'),
        outcome == ServerMutationOutcome.confirmed
            ? findsOneWidget
            : findsNothing,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(
        find.text(tokens.firstWhere((final token) => token.isCaller).name),
        findsOneWidget,
      );
      verify(api.getApiTokens).called(1);
    });
  }

  testWidgets('missing current device shows Retry without fabricated rows', (
    final tester,
  ) async {
    when(api.getApiTokens).thenAnswer((_) async => []);
    await tester.runAsync(() async {
      await bloc.refresh();
    });
    await showPage(tester);
    expect(find.text('Could not load the device list.'), findsOneWidget);
    expect(find.byType(DeviceItem), findsNothing);
    expect(find.text('No other devices'), findsNothing);
    when(api.getApiTokens).thenAnswer((_) async => tokens);
    await tester.runAsync(() async {
      final loaded = bloc.stream.firstWhere((final state) => state.isLoaded);
      await tester.tap(find.text('Retry'));
      await loaded;
    });
    await tester.pumpAndSettle();
    expect(find.byType(DeviceItem), findsNWidgets(tokens.length));
    expect(find.text('Could not load the device list.'), findsNothing);
  });

  testWidgets('refresh failure retains rows with Retry', (final tester) async {
    await tester.runAsync(() async {
      await bloc.refresh();
    });
    await showPage(tester);
    when(api.getApiTokens).thenThrow(StateError('unavailable'));
    await tester.runAsync(() async {
      final failed = bloc.stream.firstWhere((final state) => state.hasError);
      await bloc.refresh();
      await failed;
    });
    await tester.pumpAndSettle();
    expect(find.byType(DeviceItem), findsNWidgets(tokens.length));
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Could not load the device list.'), findsOneWidget);
  });

  testWidgets('disabled and pending rows cannot open a dialog', (
    final tester,
  ) async {
    final device = tokens.firstWhere((final token) => !token.isCaller);
    var calls = 0;
    await pumpForTest(
      tester,
      DeviceItem(device: device, enabled: false, onRevoke: () => calls++),
    );
    await tester.tap(find.text(device.name));
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
    expect(calls, 0);
    await tester.pumpWidget(
      wrapForTest(
        child: DeviceItem(
          device: device,
          pending: true,
          onRevoke: () => calls++,
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.text(device.name));
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
    expect(calls, 0);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('revoke confirmation supports intercepted actions', (
    final tester,
  ) async {
    final device = tokens.firstWhere((final token) => !token.isCaller);
    var calls = 0;
    await pumpForTest(
      tester,
      DeviceItem(device: device, onRevoke: () => calls++),
    );
    await tester.tap(find.text(device.name));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Revoke'));
    await tester.pumpAndSettle();
    expect(calls, 1);
  });
}
