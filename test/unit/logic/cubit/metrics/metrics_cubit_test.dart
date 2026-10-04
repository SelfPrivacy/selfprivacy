import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';

void main() {
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
