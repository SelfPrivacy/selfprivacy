import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_repository.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

import '../../../../helpers/fixtures/metrics_fixtures.dart';

class _Api extends Mock implements ServerApi {}

class _Provider extends Mock implements ServerProvider {}

void main() {
  setUpAll(() => registerFallbackValue(DateTime.utc(2026)));

  test('one captured API supplies the complete aggregate', () async {
    final api = _Api();
    final metrics = aServerMetrics();
    when(
      () => api.getServerMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    ).thenAnswer((_) async => GenericResult(success: true, data: metrics));
    when(
      () => api.getMemoryMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    ).thenAnswer((_) async => GenericResult(success: false, data: null));
    when(
      () => api.getDiskMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    ).thenAnswer((_) async => GenericResult(success: false, data: null));
    final update = await MetricsRepository(
      api: api,
      version: Version(3, 6, 0),
      isAvailable: () => true,
    ).getRelevantServerMetrics(Period.day);
    expect(
      update.newState,
      isA<MetricsLoaded>()
          .having(
            (final state) => state.source,
            'source',
            MetricsDataSource.server,
          )
          .having((final state) => state.metrics, 'metrics', same(metrics)),
    );
    expect(update.nextCheckInSeconds, 300);
    verify(
      () => api.getDiskMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    ).called(1);
  });

  test('legacy fallback uses the captured provider and provider ID', () async {
    final provider = _Provider();
    when(() => provider.isAuthorized).thenReturn(true);
    when(() => provider.getMetrics('provider-123', any(), any())).thenAnswer(
      (_) async => GenericResult(success: true, data: aServerMetrics()),
    );
    final update = await MetricsRepository(
      api: _Api(),
      version: Version(3, 0, 0),
      isAvailable: () => true,
      provider: provider,
      providerId: 'provider-123',
    ).getRelevantServerMetrics(Period.hour);
    expect(
      update.newState,
      isA<MetricsLoaded>().having(
        (final state) => state.source,
        'source',
        MetricsDataSource.legacy,
      ),
    );
    verify(() => provider.getMetrics('provider-123', any(), any())).called(1);
  });

  test('detaching during an aggregate stops its remaining requests', () async {
    final api = _Api();
    var available = true;
    final response = Completer<GenericResult<ServerMetrics?>>();
    when(
      () => api.getServerMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    ).thenAnswer((_) => response.future);
    final repository = MetricsRepository(
      api: api,
      version: Version(3, 6, 0),
      isAvailable: () => available,
    );
    final load = repository.getRelevantServerMetrics(Period.day);
    final discarded = expectLater(
      load,
      throwsA(isA<GraphQLDispatchDeferred>()),
    );
    available = false;
    response.complete(GenericResult(success: true, data: aServerMetrics()));
    await discarded;
    verifyNever(
      () => api.getMemoryMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    );
    verifyNever(
      () => api.getDiskMetrics(
        start: any(named: 'start'),
        end: any(named: 'end'),
        step: any(named: 'step'),
      ),
    );
  });
}
