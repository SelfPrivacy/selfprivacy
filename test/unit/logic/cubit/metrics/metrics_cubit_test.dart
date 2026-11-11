import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';

void main() {
  testWidgets('month fallback refresh follows the 30-day range', (
    final tester,
  ) async {
    final access = StreamController<bool?>(sync: true);
    final periods = <Period>[];
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (final period) async {
        periods.add(period);
        return MetricsStateUpdate(MetricsUnsupported(period), 0);
      },
    );
    try {
      access.add(true);
      await tester.pump();
      await cubit.changePeriod(Period.month);
      periods.clear();
      await tester.pump(const Duration(seconds: 12959));
      expect(periods, isEmpty);
      await tester.pump(const Duration(seconds: 1));
      expect(periods, [Period.month]);
    } finally {
      await tester.runAsync(() async {
        await cubit.close();
        await access.close();
      });
    }
  });

  test('an access change during deferred dispatch resumes the poll', () async {
    final access = StreamController<bool?>(sync: true);
    final pending = Completer<MetricsStateUpdate>();
    var calls = 0;
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (final period) => ++calls == 1
          ? pending.future
          : Future.value(MetricsStateUpdate(MetricsUnsupported(period), 60)),
    );
    addTearDown(() async {
      await cubit.close();
      await access.close();
    });
    access
      ..add(true)
      ..add(false)
      ..add(true);
    pending.completeError(const GraphQLDispatchDeferred());
    await pumpEventQueue();
    expect(calls, 2);
    expect(cubit.state, const MetricsUnsupported(Period.day));
  });

  test(
    'a period selected during a poll replaces its obsolete result',
    () async {
      final access = StreamController<bool?>();
      final poll = Completer<MetricsStateUpdate>();
      final cubit = MetricsCubit(
        access: access.stream,
        loadMetrics: (final period) => period == Period.day
            ? poll.future
            : Future.value(MetricsStateUpdate(MetricsUnsupported(period), 60)),
      );
      addTearDown(() async {
        await cubit.close();
        await access.close();
      });
      access.add(true);
      await pumpEventQueue();
      await cubit.changePeriod(Period.hour);
      poll.complete(
        MetricsStateUpdate(const MetricsUnsupported(Period.day), 60),
      );
      await pumpEventQueue();
      expect(cubit.state, const MetricsUnsupported(Period.hour));
    },
  );

  test('closing cancels refresh and rejects an in-flight result', () async {
    final access = StreamController<bool?>();
    final pending = Completer<MetricsStateUpdate>();
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (_) => pending.future,
    );
    access.add(true);
    await pumpEventQueue();
    await cubit.close();
    pending.complete(
      MetricsStateUpdate(const MetricsUnsupported(Period.day), 60),
    );
    await pumpEventQueue();
    expect(cubit.state, isA<MetricsLoading>());
    expect(cubit.timer, isNull);
    await access.close();
  });
}
