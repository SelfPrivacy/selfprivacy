import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
import 'package:selfprivacy/utils/network_utils.dart';

class ApiAdapter {
  ApiAdapter({final String? region, final bool isWithToken = true})
      : _api = DigitalOceanApi(
          region: region,
          isWithToken: isWithToken,
        );

  DigitalOceanApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : DigitalOceanApi(
          region: _api.region,
          isWithToken: false,
        );

  final DigitalOceanApi _api;
}

class DigitalOceanServerProvider extends ServerProvider {
  DigitalOceanServerProvider() : _adapter = ApiAdapter();
  DigitalOceanServerProvider.load(
    final ServerType serverType,
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
          region: serverType.location.identifier,
        );

  ApiAdapter _adapter;

  @override
  Future<GenericResult<bool>> trySetServerLocation(
    final String location,
  ) async {
    final bool apiInitialized = _adapter.api().isWithToken;
    if (!apiInitialized) {
      return GenericResult(
        success: true,
        data: false,
        message: 'Not authorized!',
      );
    }

    _adapter = ApiAdapter(
      isWithToken: true,
      region: location,
    );
    return success;
  }

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }

    _adapter = ApiAdapter(region: api.region, isWithToken: true);
    return result;
  }

  String? getEmojiFlag(final String query) {
    String? emoji;

    switch (query.toLowerCase().substring(0, 3)) {
      case 'fra':
        emoji = '🇩🇪';
        break;

      case 'ams':
        emoji = '🇳🇱';
        break;

      case 'sgp':
        emoji = '🇸🇬';
        break;

      case 'lon':
        emoji = '🇬🇧';
        break;

      case 'tor':
        emoji = '🇨🇦';
        break;

      case 'blr':
        emoji = '🇮🇳';
        break;

      case 'nyc':
      case 'sfo':
        emoji = '🇺🇸';
        break;
    }

    return emoji;
  }

  @override
  Future<GenericResult<List<ServerProviderLocation>>>
      getAvailableLocations() async {
    final List<ServerProviderLocation> locations = [];
    final result = await _adapter.api().getAvailableLocations();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: locations,
        code: result.code,
        message: result.message,
      );
    }

    final List rawLocations = result.data;
    for (final rawLocation in rawLocations) {
      ServerProviderLocation? location;
      try {
        location = ServerProviderLocation(
          title: rawLocation['slug'],
          description: rawLocation['name'],
          flag: getEmojiFlag(rawLocation['slug']),
          identifier: rawLocation['slug'],
        );
      } catch (e) {
        continue;
      }
      locations.add(location);
    }

    return GenericResult(success: true, data: locations);
  }

  @override
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  }) async {
    final List<ServerType> types = [];
    final result = await _adapter.api().getAvailableServerTypes();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: types,
        code: result.code,
        message: result.message,
      );
    }

    final List rawSizes = result.data;
    for (final rawSize in rawSizes) {
      for (final rawRegion in rawSize['regions']) {
        final ramMb = rawSize['memory'].toDouble();
        if (rawRegion.toString() == location.identifier && ramMb > 1024) {
          types.add(
            ServerType(
              title: rawSize['description'],
              identifier: rawSize['slug'],
              ram: ramMb / 1024,
              cores: rawSize['vcpus'],
              disk: DiskSize(byte: rawSize['disk'] * 1024 * 1024 * 1024),
              price: Price(
                value: rawSize['price_monthly'],
                currency: 'USD',
              ),
              location: location,
            ),
          );
        }
      }
    }

    return GenericResult(success: true, data: types);
  }

  Future<GenericResult<List<ServerBasicInfo>>> getServers() async {
    final List<ServerBasicInfo> servers = [];
    final result = await _adapter.api().getServers();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: servers,
        code: result.code,
        message: result.message,
      );
    }

    final List rawServers = result.data;
    rawServers.map<ServerBasicInfo>(
      (final server) {
        String ipv4 = '0.0.0.0';
        if (server['networks']['v4'].isNotEmpty) {
          for (final v4 in server['networks']['v4']) {
            if (v4['type'].toString() == 'public') {
              ipv4 = v4['ip_address'].toString();
            }
          }
        }

        return ServerBasicInfo(
          id: server['id'],
          reverseDns: server['name'],
          created: DateTime.now(),
          ip: ipv4,
          name: server['name'],
        );
      },
    ).toList();

    return GenericResult(success: true, data: servers);
  }

  Future<GenericResult<List<ServerMetadataEntity>>> getMetadata(
    final int serverId,
  ) async {
    List<ServerMetadataEntity> metadata = [];
    final result = await _adapter.api().getServers();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: false,
        data: metadata,
        code: result.code,
        message: result.message,
      );
    }

    final List servers = result.data;
    try {
      final droplet = servers.firstWhere(
        (final server) => server['id'] == serverId,
      );

      metadata = [
        ServerMetadataEntity(
          type: MetadataType.id,
          trId: 'server.server_id',
          value: droplet['id'].toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.status,
          trId: 'server.status',
          value: droplet['status'].toString().capitalize(),
        ),
        ServerMetadataEntity(
          type: MetadataType.cpu,
          trId: 'server.cpu',
          value: droplet['vcpus'].toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.ram,
          trId: 'server.ram',
          value: "${droplet['memory'].toString()} MB",
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          trId: 'server.monthly_cost',
          value: droplet['size']['price_monthly'].toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          trId: 'server.location',
          value:
              '${droplet['region']['name']} ${getEmojiFlag(droplet['region']['slug'].toString()) ?? ''}',
        ),
        ServerMetadataEntity(
          type: MetadataType.other,
          trId: 'server.provider',
          value: _adapter.api().displayProviderName,
        ),
      ];
    } catch (e) {
      return GenericResult(
        success: false,
        data: [],
        message: e.toString(),
      );
    }

    return GenericResult(success: true, data: metadata);
  }

  /// Digital Ocean returns a map of lists of /proc/stat values,
  /// so here we are trying to implement average CPU
  /// load calculation for each point in time on a given interval.
  ///
  /// For each point of time:
  ///
  /// `Average Load = 100 * (1 - (Idle Load / Total Load))`
  ///
  /// For more info please proceed to read:
  /// https://rosettacode.org/wiki/Linux_CPU_utilization
  List<TimeSeriesData> calculateCpuLoadMetrics(final List rawProcStatMetrics) {
    final List<TimeSeriesData> cpuLoads = [];

    final int pointsInTime = (rawProcStatMetrics[0]['values'] as List).length;
    for (int i = 0; i < pointsInTime; ++i) {
      double currentMetricLoad = 0.0;
      double? currentMetricIdle;
      for (final rawProcStat in rawProcStatMetrics) {
        final String rawProcValue = rawProcStat['values'][i][1];
        // Converting MBit into bit
        final double procValue = double.parse(rawProcValue) * 1000000;
        currentMetricLoad += procValue;
        if (currentMetricIdle == null &&
            rawProcStat['metric']['mode'] == 'idle') {
          currentMetricIdle = procValue;
        }
      }
      currentMetricIdle ??= 0.0;
      currentMetricLoad = 100.0 * (1 - (currentMetricIdle / currentMetricLoad));
      cpuLoads.add(
        TimeSeriesData(
          rawProcStatMetrics[0]['values'][i][0],
          currentMetricLoad,
        ),
      );
    }

    return cpuLoads;
  }

  @override
  Future<GenericResult<ServerMetrics?>> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  ) async {
    ServerMetrics? metrics;

    const int step = 15;
    final inboundResult = await _adapter.api().getMetricsBandwidth(
          serverId,
          start,
          end,
          true,
        );

    if (inboundResult.data.isEmpty || !inboundResult.success) {
      return GenericResult(
        success: false,
        data: null,
        code: inboundResult.code,
        message: inboundResult.message,
      );
    }

    final outboundResult = await _adapter.api().getMetricsBandwidth(
          serverId,
          start,
          end,
          false,
        );

    if (outboundResult.data.isEmpty || !outboundResult.success) {
      return GenericResult(
        success: false,
        data: null,
        code: outboundResult.code,
        message: outboundResult.message,
      );
    }

    final cpuResult = await _adapter.api().getMetricsCpu(serverId, start, end);

    if (cpuResult.data.isEmpty || !cpuResult.success) {
      return GenericResult(
        success: false,
        data: null,
        code: cpuResult.code,
        message: cpuResult.message,
      );
    }

    metrics = ServerMetrics(
      bandwidthIn: inboundResult.data
          .map(
            (final el) => TimeSeriesData(el[0], double.parse(el[1]) * 100000),
          )
          .toList(),
      bandwidthOut: outboundResult.data
          .map(
            (final el) => TimeSeriesData(el[0], double.parse(el[1]) * 100000),
          )
          .toList(),
      cpu: calculateCpuLoadMetrics(cpuResult.data),
      start: start,
      end: end,
      stepsInSecond: step,
    );

    return GenericResult(success: true, data: metrics);
  }

  @override
  Future<GenericResult<DateTime?>> restart(final int serverId) async {
    DateTime? timestamp;
    final result = await _adapter.api().restart(serverId);
    if (!result.success) {
      return GenericResult(
        success: false,
        data: timestamp,
        code: result.code,
        message: result.message,
      );
    }

    timestamp = DateTime.now();

    return GenericResult(
      success: true,
      data: timestamp,
    );
  }

  Future<GenericResult<CallbackDialogueBranching?>> deleteServer(
    final String hostname,
  ) async {
    final String deletionName = getHostnameFromDomain(hostname);
    final serversResult = await getServers();
    try {
      final servers = serversResult.data;
      ServerBasicInfo? foundServer;
      for (final server in servers) {
        if (server.name == deletionName) {
          foundServer = server;
          break;
        }
      }

      final volumes = await _adapter.api().getVolumes();
      final ServerVolume volumeToRemove;
      volumeToRemove = volumes.firstWhere(
        (final el) => el.serverId == foundServer!.id,
      );

      await _adapter.api().detachVolume(volumeToRemove);

      await Future.delayed(const Duration(seconds: 10));
      final List<Future> laterFutures = <Future>[];
      laterFutures.add(_adapter.api().deleteVolume(volumeToRemove));
      laterFutures.add(_adapter.api().deleteServer(foundServer!.id));

      await Future.wait(laterFutures);
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(
              title: 'basis.cancel'.tr(),
              callback: null,
            ),
            CallbackDialogueChoice(
              title: 'basis.try_again'.tr(),
              callback: () async {
                await Future.delayed(const Duration(seconds: 5));
                return deleteServer(hostname);
              },
            ),
          ],
          description: 'modals.try_again'.tr(),
          title: 'modals.server_deletion_error'.tr(),
        ),
        message: e.toString(),
      );
    }

    return GenericResult(
      success: true,
      data: null,
    );
  }
}
