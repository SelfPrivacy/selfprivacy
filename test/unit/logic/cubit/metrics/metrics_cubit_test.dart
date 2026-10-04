import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/connection/lifecycle/connection_observation.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';

void main() {
  test('an access change during deferred dispatch resumes the poll', () async {
    final access = StreamController<ConnectionObservation<bool>>(sync: true);
    final origin = ServerStateOrigin('server');
    final pending = Completer<MetricsStateUpdate>();
    var calls = 0;
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (_, final period) => ++calls == 1
          ? pending.future
          : Future.value(MetricsStateUpdate(MetricsUnsupported(period), 60)),
    );
    addTearDown(() async {
      await cubit.close();
      await access.close();
    });
    access
      ..add(ConnectionObservation.attached(origin, true))
      ..add(ConnectionObservation.attached(origin, false))
      ..add(ConnectionObservation.attached(origin, true));
    pending.completeError(const GraphQLDispatchDeferred());
    await pumpEventQueue();
    expect(calls, 2);
    expect(cubit.state, const MetricsUnsupported(Period.day));
  });

  test(
    'a period selected during a poll replaces its obsolete result',
    () async {
      final access = StreamController<ConnectionObservation<bool>>();
      final poll = Completer<MetricsStateUpdate>();
      final cubit = MetricsCubit(
        access: access.stream,
        loadMetrics: (_, final period) => period == Period.day
            ? poll.future
            : Future.value(MetricsStateUpdate(MetricsUnsupported(period), 60)),
      );
      addTearDown(() async {
        await cubit.close();
        await access.close();
      });
      access.add(
        ConnectionObservation.attached(ServerStateOrigin('server'), true),
      );
      await pumpEventQueue();
      await cubit.changePeriod(Period.hour);
      poll.complete(
        MetricsStateUpdate(const MetricsUnsupported(Period.day), 60),
      );
      await pumpEventQueue();
      expect(cubit.state, const MetricsUnsupported(Period.hour));
    },
  );

  test('reset clears metrics and does not wait for the old request', () async {
    final access = StreamController<ConnectionObservation<bool>>();
    final old = ServerStateOrigin('server');
    final replacement = ServerStateOrigin('server');
    final pending = Completer<MetricsStateUpdate>();
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (final origin, final period) => identical(origin, old)
          ? pending.future
          : Future.value(MetricsStateUpdate(MetricsUnsupported(period), 60)),
    );
    addTearDown(() async {
      await cubit.close();
      await access.close();
    });
    access.add(ConnectionObservation.attached(old, true));
    await pumpEventQueue();
    access.add(const ConnectionObservation.absent());
    await pumpEventQueue();
    expect(cubit.state, isA<MetricsLoading>());
    access.add(ConnectionObservation.attached(replacement, true));
    await pumpEventQueue();
    expect(cubit.state, const MetricsUnsupported(Period.day));
    pending.complete(
      MetricsStateUpdate(const MetricsUnsupported(Period.hour), 60),
    );
    await pumpEventQueue();
    expect(cubit.state, const MetricsUnsupported(Period.day));
  });

  test('closing cancels refresh and rejects an in-flight result', () async {
    final access = StreamController<ConnectionObservation<bool>>();
    final pending = Completer<MetricsStateUpdate>();
    final cubit = MetricsCubit(
      access: access.stream,
      loadMetrics: (_, _) => pending.future,
    );
    access.add(
      ConnectionObservation.attached(ServerStateOrigin('server'), true),
    );
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
