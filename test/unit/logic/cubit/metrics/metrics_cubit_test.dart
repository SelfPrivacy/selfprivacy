import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';

import '../../../../helpers/operation_fixture.dart';

class _Api extends Mock implements ServerApi {}

class _Adapter extends Mock implements ApiConnectionRepository {}

class _Metrics extends Mock implements MetricsRepository {}

void main() {
  tearDown(getIt.reset);

  test(
    'a period selected during a poll replaces its obsolete result',
    () async {
      final adapter = _Adapter();
      final hub = fixtureHub(_Api());
      when(() => adapter.hub).thenReturn(hub);
      getIt.registerSingleton<ApiConnectionRepository>(adapter);
      final repository = _Metrics();
      final poll = Completer<MetricsStateUpdate>();
      var reads = 0;
      when(() => repository.getRelevantServerMetrics(Period.day)).thenAnswer(
        (_) => ++reads == 1
            ? Future.value(
                MetricsStateUpdate(const MetricsUnsupported(Period.day), 60),
              )
            : poll.future,
      );
      when(() => repository.getRelevantServerMetrics(Period.hour)).thenAnswer(
        (_) async =>
            MetricsStateUpdate(const MetricsUnsupported(Period.hour), 60),
      );
      final cubit = MetricsCubit(repository: repository);
      addTearDown(cubit.close);
      await cubit.load(Period.day);
      final pending = cubit.load(Period.day);
      await cubit.changePeriod(Period.hour);
      poll.complete(
        MetricsStateUpdate(const MetricsUnsupported(Period.day), 60),
      );
      await pending;
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state, const MetricsUnsupported(Period.hour));
    },
  );
}
