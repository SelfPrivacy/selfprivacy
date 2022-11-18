import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_controller.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';

import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

class MetricsLoadException implements Exception {
  MetricsLoadException(this.message);
  final String message;
}

class MetricsRepository {
  Future<MetricsLoaded> getMetrics(final Period period) async {
    final providerApiFactory = ApiController.currentServerProviderApiFactory;
    if (providerApiFactory == null) {
      throw MetricsLoadException('Server Provider data is null');
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

    final serverId = getIt<ApiConfigModel>().serverDetails!.id;
    final ServerMetrics? metrics =
        await providerApiFactory.getServerProvider().getMetrics(
              serverId,
              start,
              end,
            );

    if (metrics == null) {
      throw MetricsLoadException('Metrics data is null');
    }

    return MetricsLoaded(
      period: period,
      metrics: metrics,
    );
  }
}
