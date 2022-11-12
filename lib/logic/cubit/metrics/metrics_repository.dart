import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';

import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

class MetricsLoadException implements Exception {
  MetricsLoadException(this.message);
  final String message;
}

class MetricsRepository {
  ServerProviderApiFactory? serverProviderApiFactory;

  void _buildServerProviderFactory() {
    final ServerProvider? providerType = getIt<ApiConfigModel>().serverProvider;
    final String? location = getIt<ApiConfigModel>().serverLocation;
    serverProviderApiFactory = ApiFactoryCreator.createServerProviderApiFactory(
      ServerProviderApiFactorySettings(
        provider: providerType ?? ServerProvider.unknown,
        location: location,
      ),
    );
  }

  Future<MetricsLoaded> getMetrics(final Period period) async {
    if (serverProviderApiFactory == null) {
      _buildServerProviderFactory();
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
        await serverProviderApiFactory!.getServerProvider().getMetrics(
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
