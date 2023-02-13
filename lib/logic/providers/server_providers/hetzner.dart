import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';

class ApiAdapter {
  ApiAdapter({final String? region, final bool isWithToken = true})
      : _api = HetznerApi(
          region: region,
          isWithToken: isWithToken,
        );

  HetznerApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : HetznerApi(
          region: _api.region,
          isWithToken: false,
        );

  final HetznerApi _api;
}

class HetznerServerProvider extends ServerProvider {
  HetznerServerProvider() : _adapter = ApiAdapter();
  HetznerServerProvider.load(
    final ServerType serverType,
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
          region: serverType.location.identifier,
        );

  ApiAdapter _adapter;

  @override
  Future<GenericResult<bool>> trySetServerType(final ServerType type) async {
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
      region: type.location.identifier,
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

    switch (query.toLowerCase()) {
      case 'de':
        emoji = '🇩🇪';
        break;

      case 'fi':
        emoji = '🇫🇮';
        break;

      case 'us':
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
          title: rawLocation['city'],
          description: rawLocation['description'],
          flag: getEmojiFlag(rawLocation['country']),
          identifier: rawLocation['name'],
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

    final List rawTypes = result.data;
    for (final rawType in rawTypes) {
      for (final rawPrice in rawType['prices']) {
        if (rawPrice['location'].toString() == location.identifier) {
          types.add(
            ServerType(
              title: rawType['description'],
              identifier: rawType['name'],
              ram: rawType['memory'],
              cores: rawType['cores'],
              disk: DiskSize(byte: rawType['disk'] * 1024 * 1024 * 1024),
              price: Price(
                value: double.parse(rawPrice['price_monthly']['gross']),
                currency: 'EUR',
              ),
              location: location,
            ),
          );
        }
      }
    }

    return GenericResult(success: true, data: types);
  }

  Future<GenericResult<void>> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  }) async =>
      _adapter.api().createReverseDns(
            serverId: serverDetails.id,
            ip4: serverDetails.ip4,
            dnsPtr: domain.domainName,
          );

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

    final List<HetznerServerInfo> hetznerServers = result.data;
    for (final hetznerServer in hetznerServers) {
      if (hetznerServer.publicNet.ipv4 == null) {
        continue;
      }

      ServerBasicInfo? server;
      try {
        server = ServerBasicInfo(
          id: hetznerServer.id,
          name: hetznerServer.name,
          ip: hetznerServer.publicNet.ipv4!.ip,
          reverseDns: hetznerServer.publicNet.ipv4!.reverseDns,
          created: hetznerServer.created,
        );
      } catch (e) {
        continue;
      }

      servers.add(server);
    }

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

    final List<HetznerServerInfo> servers = result.data;
    try {
      final HetznerServerInfo server = servers.firstWhere(
        (final server) => server.id == serverId,
      );

      metadata = [
        ServerMetadataEntity(
          type: MetadataType.id,
          trId: 'server.server_id',
          value: server.id.toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.status,
          trId: 'server.status',
          value: server.status.toString().split('.')[1].capitalize(),
        ),
        ServerMetadataEntity(
          type: MetadataType.cpu,
          trId: 'server.cpu',
          value: server.serverType.cores.toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.ram,
          trId: 'server.ram',
          value: '${server.serverType.memory.toString()} GB',
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          trId: 'server.monthly_cost',
          value: server.serverType.prices[1].monthly.toStringAsFixed(2),
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          trId: 'server.location',
          value: '${server.location.city}, ${server.location.country}',
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

  Future<GenericResult<ServerMetrics?>> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  ) async {
    ServerMetrics? metrics;

    List<TimeSeriesData> serializeTimeSeries(
      final Map<String, dynamic> json,
      final String type,
    ) {
      final List list = json['time_series'][type]['values'];
      return list
          .map((final el) => TimeSeriesData(el[0], double.parse(el[1])))
          .toList();
    }

    final cpuResult = await _adapter.api().getMetrics(
          serverId,
          start,
          end,
          'cpu',
        );
    if (cpuResult.data.isEmpty || !cpuResult.success) {
      return GenericResult(
        success: false,
        data: metrics,
        code: cpuResult.code,
        message: cpuResult.message,
      );
    }

    final netResult = await _adapter.api().getMetrics(
          serverId,
          start,
          end,
          'network',
        );

    if (cpuResult.data.isEmpty || !netResult.success) {
      return GenericResult(
        success: false,
        data: metrics,
        code: netResult.code,
        message: netResult.message,
      );
    }

    metrics = ServerMetrics(
      cpu: serializeTimeSeries(
        cpuResult.data,
        'cpu',
      ),
      bandwidthIn: serializeTimeSeries(
        netResult.data,
        'network.0.bandwidth.in',
      ),
      bandwidthOut: serializeTimeSeries(
        netResult.data,
        'network.0.bandwidth.out',
      ),
      end: end,
      start: start,
      stepsInSecond: cpuResult.data['step'],
    );

    return GenericResult(data: metrics, success: true);
  }

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

  Future<GenericResult<DateTime?>> powerOn(final int serverId) async {
    DateTime? timestamp;
    final result = await _adapter.api().powerOn(serverId);
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
}
