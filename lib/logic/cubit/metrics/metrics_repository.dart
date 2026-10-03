import 'package:easy_localization/easy_localization.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

class MetricsLoadException implements Exception {
  MetricsLoadException(this.message);
  final String message;
}

class MetricsUnsupportedException implements Exception {
  MetricsUnsupportedException(this.message);
  final String message;
}

class MetricsStateUpdate {
  MetricsStateUpdate(this.newState, this.nextCheckInSeconds);
  final MetricsState newState;
  final int nextCheckInSeconds;
}

class MetricsRepository {
  MetricsRepository({
    required final ServerApi api,
    required final Version? version,
    required final bool Function() isAvailable,
    final ServerProvider? provider,
    final String? providerId,
  }) : _api = api,
       _version = version,
       _isAvailable = isAvailable,
       _provider = provider,
       _providerId = providerId;

  final ServerApi _api;
  final Version? _version;
  final bool Function() _isAvailable;
  final ServerProvider? _provider;
  final String? _providerId;

  void _requireAvailable() {
    if (!_isAvailable()) {
      throw const GraphQLDispatchDeferred();
    }
  }

  static const String metricsSupportedVersion = '>=3.3.0';

  Future<MetricsStateUpdate> getRelevantServerMetrics(
    final Period period,
  ) async {
    _requireAvailable();
    MetricsLoaded? state;
    int nextUpdate = 0;

    try {
      final stateLoaded = await _getServerMetrics(period);
      nextUpdate = stateLoaded.metrics.stepsInSecond.toInt();
      state = stateLoaded;
    } on GraphQLDispatchDeferred {
      rethrow;
    } catch (_) {}

    _requireAvailable();
    const minAmountForRendering = 20;

    if (state != null &&
        state.metrics.cpu.length >= minAmountForRendering &&
        state.metrics.bandwidthIn.length >= minAmountForRendering &&
        state.metrics.bandwidthOut.length >= minAmountForRendering) {
      return MetricsStateUpdate(state, nextUpdate);
    }

    _requireAvailable();
    try {
      final stateLoaded = await _getLegacyMetrics(period);
      nextUpdate = stateLoaded.metrics.stepsInSecond.toInt();
      state = stateLoaded;
    } on GraphQLDispatchDeferred {
      rethrow;
    } catch (_) {}

    _requireAvailable();
    if (state != null) {
      return MetricsStateUpdate(state, nextUpdate);
    }

    return MetricsStateUpdate(MetricsUnsupported(period), nextUpdate);
  }

  Future<MetricsLoaded> _getServerMetrics(final Period period) async {
    final apiVersion = _version;
    if (apiVersion == null) {
      throw Exception('basis.network_error'.tr());
    }
    if (!VersionConstraint.parse(metricsSupportedVersion).allows(apiVersion)) {
      throw Exception(
        'basis.feature_unsupported_on_api_version'.tr(
          namedArgs: {
            'versionConstraint': metricsSupportedVersion,
            'currentVersion': apiVersion.toString(),
          },
        ),
      );
    }

    final DateTime end = DateTime.now();
    DateTime start;

    switch (period) {
      case Period.hour:
        start = end.subtract(const Duration(hours: 1));
      case Period.day:
        start = end.subtract(const Duration(days: 1));
      case Period.month:
        start = end.subtract(const Duration(days: 15));
    }

    final result = await _api.getServerMetrics(
      start: start,
      end: end,
      step: end.difference(start).inSeconds ~/ 120,
    );

    _requireAvailable();
    if (result.data == null || !result.success) {
      throw MetricsLoadException('Metrics data is null');
    }

    final memoryResult = await _api.getMemoryMetrics(
      start: start,
      end: end,
      step: end.difference(start).inSeconds ~/ 120,
    );

    _requireAvailable();
    final diskResult = await _api.getDiskMetrics(
      start: start,
      end: end,
      step: end.difference(start).inSeconds ~/ 120,
    );

    _requireAvailable();
    return MetricsLoaded(
      period: period,
      metrics: result.data!,
      source: MetricsDataSource.server,
      memoryMetrics: memoryResult.data,
      diskMetrics: diskResult.data,
    );
  }

  Future<MetricsLoaded> _getLegacyMetrics(final Period period) async {
    if (!(_provider?.isAuthorized ?? false)) {
      throw MetricsUnsupportedException('Server Provider data is null');
    }

    final DateTime end = DateTime.now();
    DateTime start;

    switch (period) {
      case Period.hour:
        start = end.subtract(const Duration(hours: 1));
      case Period.day:
        start = end.subtract(const Duration(days: 1));
      case Period.month:
        start = end.subtract(const Duration(days: 15));
    }

    final providerId = _providerId;
    if (providerId == null) {
      throw MetricsUnsupportedException('Server provider ID is null');
    }
    final result = await _provider!.getMetrics(providerId, start, end);

    if (result.data == null || !result.success) {
      throw MetricsLoadException('Metrics data is null');
    }

    _requireAvailable();
    return MetricsLoaded(
      period: period,
      metrics: result.data!,
      source: MetricsDataSource.legacy,
    );
  }
}
