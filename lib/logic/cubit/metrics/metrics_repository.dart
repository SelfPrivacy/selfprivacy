import 'package:easy_localization/easy_localization.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';

import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

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
  static const String metricsSupportedVersion = '>=3.3.0';

  Future<MetricsStateUpdate> getRelevantServerMetrics(
    final Period period,
  ) async {
    MetricsLoaded? state;
    int nextUpdate = 0;

    try {
      final stateLoaded = await _getServerMetrics(period);
      nextUpdate = stateLoaded.metrics.stepsInSecond.toInt();
      state = stateLoaded;
    } catch (_) {}

    const minAmountForRendering = 20;

    if (state != null &&
        state.metrics.cpu.length >= minAmountForRendering &&
        state.metrics.bandwidthIn.length >= minAmountForRendering &&
        state.metrics.bandwidthOut.length >= minAmountForRendering) {
      return MetricsStateUpdate(state, nextUpdate);
    }

    try {
      final stateLoaded = await _getLegacyMetrics(period);
      nextUpdate = stateLoaded.metrics.stepsInSecond.toInt();
      state = stateLoaded;
    } catch (_) {}

    if (state != null) {
      return MetricsStateUpdate(state, nextUpdate);
    }

    return MetricsStateUpdate(MetricsUnsupported(period), nextUpdate);
  }

  Future<MetricsLoaded> _getServerMetrics(final Period period) async {
    final String? apiVersion =
        getIt<ApiConnectionRepository>().apiData.apiVersion.data;
    if (apiVersion == null) {
      throw Exception('basis.network_error'.tr());
    }
    if (!VersionConstraint.parse(
      metricsSupportedVersion,
    ).allows(Version.parse(apiVersion))) {
      throw Exception(
        'basis.feature_unsupported_on_api_version'.tr(
          namedArgs: {
            'versionConstraint': metricsSupportedVersion,
            'currentVersion': apiVersion,
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

    final result = await getIt<ApiConnectionRepository>().api.getServerMetrics(
      start: start,
      end: end,
      step: end.difference(start).inSeconds ~/ 120,
    );

    if (result.data == null || !result.success) {
      throw MetricsLoadException('Metrics data is null');
    }

    final memoryResult = await getIt<ApiConnectionRepository>().api
        .getMemoryMetrics(
          start: start,
          end: end,
          step: end.difference(start).inSeconds ~/ 120,
        );

    final diskResult = await getIt<ApiConnectionRepository>().api
        .getDiskMetrics(
          start: start,
          end: end,
          step: end.difference(start).inSeconds ~/ 120,
        );

    return MetricsLoaded(
      period: period,
      metrics: result.data!,
      source: MetricsDataSource.server,
      memoryMetrics: memoryResult.data,
      diskMetrics: diskResult.data,
    );
  }

  Future<MetricsLoaded> _getLegacyMetrics(final Period period) async {
    if (!(ProvidersController.currentServerProvider?.isAuthorized ?? false)) {
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

    final serverId = getIt<ResourcesModel>().serverDetails!.id;
    final result = await ProvidersController.currentServerProvider!.getMetrics(
      serverId,
      start,
      end,
    );

    if (result.data == null || !result.success) {
      throw MetricsLoadException('Metrics data is null');
    }

    return MetricsLoaded(
      period: period,
      metrics: result.data!,
      source: MetricsDataSource.legacy,
    );
  }
}
