import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/ui/pages/services/services_catalog.dart';

import '../../../../helpers/fixtures/service_fixtures.dart';
import '../../../../helpers/widget_harness.dart';

void main() {
  setUpAll(setUpWidgetTestHarness);
  late StreamController<CachedValue<List<Service>>?> source;
  late ServicesBloc bloc;
  late Completer<ServerMutationResult<void>> pending;
  late List<String> feedback;
  late Completer<void> refresh;
  late int refreshes;

  setUp(() {
    source = StreamController.broadcast(sync: true);
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
      restart: (_) => pending.future,
      move: (_) async => null,
      showMessage: feedback.add,
    );
  });
  tearDown(() async {
    await bloc.close();
    await source.close();
  });

  for (final phase in ['initial', 'loading', 'error', 'unsupported', 'empty']) {
    testWidgets('catalog renders $phase state', (final tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      switch (phase) {
        case 'loading':
          source.add(const CachedValue());
        case 'error':
          source.add(CachedValue(lastError: StateError('unavailable')));
        case 'unsupported':
          source.add(const CachedValue(support: DomainSupport.unsupported));
        case 'empty':
          source.add(const CachedValue(data: []));
      }
      await tester.runAsync(pumpEventQueue);
      await pumpForTest(
        tester,
        BlocProvider.value(value: bloc, child: const ServicesCatalogPage()),
      );
      final expectedKey = switch (phase) {
        'initial' || 'loading' => 'basis.loading',
        'error' => 'services_catalog.load_error',
        'unsupported' => 'basis.feature_unsupported',
        _ => 'services_catalog.empty_subtitle',
      };
      expect(find.text(expectedKey.tr()), findsOneWidget);
      if (phase != 'empty') {
        expect(find.text('services_catalog.empty_subtitle'.tr()), findsNothing);
      }
      if (phase == 'error') {
        await tester.tap(find.text('data_status.retry'.tr()));
        await tester.pump();
        expect(refreshes, 1);
        refresh.complete();
        await tester.runAsync(pumpEventQueue);
      }
    });
  }

  test('empty loaded services are not loading or unsupported', () async {
    source.add(const CachedValue(data: []));
    await pumpEventQueue();
    expect(bloc.state, isA<ServicesLoaded>());
    source.add(const CachedValue(support: DomainSupport.unsupported));
    await pumpEventQueue();
    expect(bloc.state, isA<ServicesUnsupported>());
  });

  test('duplicate reloads remain droppable while a read is pending', () async {
    source.add(const CachedValue(data: []));
    await pumpEventQueue();
    bloc
      ..add(const ServicesReload())
      ..add(const ServicesReload());
    await pumpEventQueue();
    refresh.complete();
    await pumpEventQueue();
    expect(refreshes, 1);
  });

  test('detachment clears locks and discards late command feedback', () async {
    final service = aService();
    source.add(CachedValue(data: [service]));
    await pumpEventQueue();
    bloc.add(ServiceRestart(service));
    await pumpEventQueue();
    expect(bloc.state.lockedServices, [service.id]);
    source.add(null);
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
  });
}
