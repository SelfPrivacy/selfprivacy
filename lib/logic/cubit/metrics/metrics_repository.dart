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

class MetricsRepository {
  Future<MetricsLoaded> getMetrics(final Period period) async {
    if (!(ProvidersController.currentServerProvider?.isAuthorized ?? false)) {
      throw MetricsUnsupportedException('Server Provider data is null');
    }

    final DateTime end = DateTime.now();
    DateTime start;

    switch (period) {
      case Period.hour:
        start = end.subtract(const Duration(hours: 1));
        break;
      case Period.day:
        start = end.subtract(const Duration(days: 1));
        break;
      case Period.month:
        start = end.subtract(const Duration(days: 15));
        break;
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
    );
  }
}
