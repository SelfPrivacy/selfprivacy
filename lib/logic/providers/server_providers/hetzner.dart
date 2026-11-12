// ignore_for_file: avoid_dynamic_calls

import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/provisioning_request.dart';
import 'package:selfprivacy/logic/models/provisioning_result.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
import 'package:selfprivacy/utils/network_utils.dart';

class ApiAdapter {
  ApiAdapter({
    final bool isWithToken = true,
    final String? token,
    this.clientFactory,
  }) : _api = HetznerApi(
         isWithToken: isWithToken,
         token: token ?? '',
         clientFactory: clientFactory,
       );

  HetznerApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : HetznerApi(isWithToken: false, clientFactory: clientFactory);

  final HetznerApi _api;
  final RestApiClientFactory? clientFactory;
}

class HetznerServerProvider extends ServerProvider {
  HetznerServerProvider({final RestApiClientFactory? clientFactory})
    : _adapter = ApiAdapter(isWithToken: false, clientFactory: clientFactory);
  HetznerServerProvider.load({
    required final String token,
    final RestApiClientFactory? clientFactory,
  }) : _adapter = ApiAdapter(
         isWithToken: true,
         token: token,
         clientFactory: clientFactory,
       );

  final ApiAdapter _adapter;
  final Currency currency = Currency.fromType(CurrencyType.eur);
  int? cachedCoreAmount;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  ServerProviderType get type => ServerProviderType.hetzner;

  @override
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
          providerId: hetznerServer.id.toString(),
          name: hetznerServer.name,
          ip: hetznerServer.publicNet.ipv4!.ip,
          reverseDns: hetznerServer.publicNet.ipv4!.reverseDns,
          created: hetznerServer.created,
          location: hetznerServer.location.name,
        );
      } catch (e) {
        continue;
      }

      servers.add(server);
    }

    return GenericResult(success: true, data: servers);
  }

  @override
  Future<GenericResult<ServerType?>> getServerType(
    final String providerId,
  ) async {
    ServerType? serverType;
    HetznerServerInfo? server;
    final result = await _adapter.api().getServers();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: serverType,
        code: result.code,
        message: result.message,
      );
    }

    final List<HetznerServerInfo> hetznerServers = result.data;
    for (final hetznerServer in hetznerServers) {
      if (hetznerServer.publicNet.ipv4 != null &&
          hetznerServer.id.toString() == providerId) {
        server = hetznerServer;
        break;
      }
    }

    if (server == null) {
      const String msg = 'getServerType: no server!';

      return GenericResult(success: false, data: serverType, message: msg);
    }

    double? priceValue;
    for (final price in server.serverType.prices) {
      if (price.location == server.location.name) {
        priceValue = price.monthly;
      }
    }

    if (priceValue == null) {
      const String msg = 'getServerType: no price!';

      return GenericResult(success: false, data: serverType, message: msg);
    }

    return GenericResult(
      success: true,
      data: ServerType(
        title: server.serverType.description,
        identifier: server.serverType.name,
        ram: server.serverType.memory.toDouble(),
        cores: server.serverType.cores,
        disk: DiskSize(byte: server.serverType.disk * 1024 * 1024 * 1024),
        price: Price(value: priceValue, currency: currency),
        location: ServerProviderLocation(
          title: server.location.city,
          description: server.location.description,
          flag: server.location.flag,
          identifier: server.location.name,
          countryDisplayKey: server.location.countryDisplayKey,
        ),
      ),
    );
  }

  @override
  Future<ProvisioningResult> provisionServer(
    final ProvisioningRequest request,
  ) async {
    final resources = <ProvisionedResource>[];
    final volumeResult = await _adapter.api().createVolume(
      gb: request.storageSize.gibibyte.toInt(),
      region: request.location,
    );
    if (volumeResult.wasCreated) {
      resources.add(
        ProvisionedResource(
          provider: type,
          kind: ProvisionedResourceKind.volume,
          id: volumeResult.resourceId,
        ),
      );
    }
    if (!volumeResult.success ||
        volumeResult.data == null ||
        volumeResult.outcome != ResourceCreationOutcome.confirmed) {
      return ProvisioningFailed(
        stage: ProvisioningStage.createVolume,
        kind: switch (volumeResult.outcome) {
          ResourceCreationOutcome.confirmed =>
            ProvisioningFailureKind.unreadable,
          ResourceCreationOutcome.rejected => ProvisioningFailureKind.rejected,
          ResourceCreationOutcome.indeterminate =>
            ProvisioningFailureKind.indeterminate,
        },
        resources: resources,
        code: volumeResult.code,
      );
    }

    final volume = volumeResult.data!;
    final serverResult = await _adapter.api().createServer(
      dnsApiCredential: request.dnsApiCredential,
      domainName: request.serverDomain.domainName,
      serverType: request.serverTypeId,
      hostName: getHostnameFromDomain(request.serverDomain.domainName),
      volumeId: volume.id,
      serverApiToken: request.serverApiToken,
      customSshKey: request.customSshKey,
      region: request.location,
    );
    if (serverResult.wasCreated) {
      resources.add(
        ProvisionedResource(
          provider: type,
          kind: ProvisionedResourceKind.server,
          id: serverResult.resourceId,
        ),
      );
    }
    if (!serverResult.success ||
        serverResult.data == null ||
        serverResult.outcome != ResourceCreationOutcome.confirmed) {
      return ProvisioningFailed(
        stage: ProvisioningStage.createServer,
        kind: switch (serverResult.outcome) {
          ResourceCreationOutcome.confirmed =>
            ProvisioningFailureKind.unreadable,
          ResourceCreationOutcome.rejected
              when serverResult.message == 'uniqueness_error' =>
            ProvisioningFailureKind.nameConflict,
          ResourceCreationOutcome.rejected => ProvisioningFailureKind.rejected,
          ResourceCreationOutcome.indeterminate =>
            ProvisioningFailureKind.indeterminate,
        },
        resources: resources,
        code: serverResult.code,
      );
    }

    final server = serverResult.data!;
    final ipv4 = server.publicNet.ipv4?.ip;
    if (ipv4 == null) {
      return ProvisioningFailed(
        stage: ProvisioningStage.awaitIpv4,
        kind: ProvisioningFailureKind.unreadable,
        resources: resources,
      );
    }
    cachedCoreAmount = server.serverType.cores;
    final reverseDns = await _adapter.api().createReverseDns(
      serverId: server.id,
      ip4: ipv4,
      dnsPtr: request.serverDomain.domainName,
    );
    if (!reverseDns.success) {
      return ProvisioningFailed(
        stage: ProvisioningStage.setReverseDns,
        kind: ProvisioningFailureKind.actionFailed,
        resources: resources,
        code: reverseDns.code,
      );
    }
    return ProvisioningCompleted(
      details: ServerHostingDetails(
        providerId: server.id.toString(),
        ip4: ipv4,
        createTime: DateTime.now(),
        volume: ServerProviderVolume(
          id: volume.id.toString(),
          name: volume.name,
          sizeByte: volume.size * 1024 * 1024 * 1024,
          serverId: volume.serverId?.toString(),
          linuxDevice: volume.linuxDevice,
        ),
        apiToken: request.serverApiToken,
        provider: type,
      ),
      resources: resources,
    );
  }

  @override
  Future<GenericResult<void>> deleteProvisionedResource(
    final ProvisionedResource resource,
  ) async {
    final id = int.tryParse(resource.id ?? '');
    if (resource.provider != type || id == null || id <= 0) {
      return GenericResult(success: false, data: null);
    }
    return switch (resource.kind) {
      ProvisionedResourceKind.server => deleteServer(resource.id!),
      ProvisionedResourceKind.volume => _adapter.api().deleteVolume(id),
    };
  }

  @override
  Future<GenericResult<void>> deleteServer(final String providerId) async {
    final id = int.tryParse(providerId);
    if (id == null || id <= 0) {
      return GenericResult(success: false, data: null);
    }
    return _adapter.api().deleteServer(serverId: id);
  }

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) {
    final api = _adapter.api(getInitialized: false);
    return api.isApiTokenValid(token);
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
        message: serverProviderConnectionErrorMessageKey,
      );
    }

    final List<HetznerLocation> rawLocations = result.data;
    for (final rawLocation in rawLocations) {
      ServerProviderLocation? location;
      try {
        location = ServerProviderLocation(
          title: rawLocation.city,
          description: rawLocation.description,
          flag: rawLocation.flag,
          identifier: rawLocation.name,
          countryDisplayKey: rawLocation.countryDisplayKey,
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
        message: serverProviderConnectionErrorMessageKey,
      );
    }

    final rawTypes = result.data;
    for (final rawType in rawTypes) {
      if (rawType.architecture == 'arm') {
        continue;
      }
      final locationEntry = rawType.locations
          .where((final l) => l.name == location.identifier)
          .firstOrNull;
      if (locationEntry == null ||
          !locationEntry.available ||
          locationEntry.deprecation != null) {
        continue;
      }
      for (final rawPrice in rawType.prices) {
        if (rawPrice.location == location.identifier) {
          types.add(
            ServerType(
              title: rawType.description,
              identifier: rawType.name,
              ram: rawType.memory.toDouble(),
              cores: rawType.cores,
              disk: DiskSize(byte: rawType.disk * 1024 * 1024 * 1024),
              price: Price(value: rawPrice.monthly, currency: currency),
              location: location,
            ),
          );
        }
      }
    }

    types.sort((final a, final b) => a.price.value.compareTo(b.price.value));
    return GenericResult(success: true, data: types);
  }

  @override
  Future<GenericResult<DateTime?>> powerOn(final String providerId) async {
    DateTime? timestamp;
    final result = await _adapter.api().powerOn(int.parse(providerId));
    if (!result.success) {
      return GenericResult(
        success: false,
        data: timestamp,
        code: result.code,
        message: result.message,
      );
    }

    timestamp = DateTime.now();

    return GenericResult(success: true, data: timestamp);
  }

  @override
  Future<GenericResult<DateTime?>> restart(final String providerId) async {
    DateTime? timestamp;
    final result = await _adapter.api().restart(int.parse(providerId));
    if (!result.success) {
      return GenericResult(
        success: false,
        data: timestamp,
        code: result.code,
        message: result.message,
      );
    }

    timestamp = DateTime.now();

    return GenericResult(success: true, data: timestamp);
  }

  @override
  Future<GenericResult<AdditionalPricing?>> getAdditionalPricing(
    final String location,
  ) async {
    final result = await _adapter.api().getPricing(region: location);

    if (!result.success || result.data == null) {
      return GenericResult(
        data: null,
        success: false,
        message: result.message,
        code: result.code,
      );
    }

    return GenericResult(
      success: true,
      data: AdditionalPricing(
        perVolumeGb: Price(value: result.data!.perVolumeGb, currency: currency),
        perPublicIpv4: Price(
          value: result.data!.perPublicIpv4,
          currency: currency,
        ),
      ),
    );
  }

  @override
  Future<GenericResult<List<ServerProviderVolume>>> getVolumes({
    final String? status,
  }) async {
    final List<ServerProviderVolume> volumes = [];

    final result = await _adapter.api().getVolumes();

    if (!result.success) {
      return GenericResult(
        data: [],
        success: false,
        message: result.message,
        code: result.code,
      );
    }

    try {
      for (final rawVolume in result.data) {
        final int volumeId = rawVolume.id;
        final int volumeSize = rawVolume.size * 1024 * 1024 * 1024;
        final volumeServer = rawVolume.serverId;
        final String volumeName = rawVolume.name;
        final volumeDevice = rawVolume.linuxDevice;
        final volumeLocation = rawVolume.location.name;
        final volume = ServerProviderVolume(
          id: volumeId.toString(),
          name: volumeName,
          sizeByte: volumeSize,
          serverId: volumeServer?.toString(),
          linuxDevice: volumeDevice,
          location: volumeLocation,
        );
        volumes.add(volume);
      }
    } catch (e) {
      return GenericResult(data: [], success: false, message: e.toString());
    }

    return GenericResult(
      data: volumes,
      success: true,
      code: result.code,
      message: result.message,
    );
  }

  @override
  Future<ResourceCreationResult<ServerProviderVolume>> createVolume(
    final int gb,
    final String location,
  ) async {
    ServerProviderVolume? volume;

    final result = await _adapter.api().createVolume(gb: gb, region: location);

    if (!result.success || result.data == null) {
      return ResourceCreationResult(
        data: null,
        success: false,
        outcome: result.outcome,
        resourceId: result.resourceId,
        message: result.message,
        code: result.code,
      );
    }

    try {
      volume = ServerProviderVolume(
        id: result.data!.id.toString(),
        name: result.data!.name,
        sizeByte: result.data!.size * 1024 * 1024 * 1024,
        serverId: result.data!.serverId?.toString(),
        linuxDevice: result.data!.linuxDevice,
      );
    } catch (e) {
      return ResourceCreationResult(
        data: null,
        success: false,
        outcome: result.outcome,
        resourceId: result.resourceId,
        message: e.toString(),
      );
    }

    return ResourceCreationResult(
      data: volume,
      success: true,
      outcome: result.outcome,
      resourceId: result.resourceId,
      code: result.code,
      message: result.message,
    );
  }

  @override
  Future<GenericResult<void>> deleteVolume(
    final ServerProviderVolume volume,
  ) async {
    final id = int.tryParse(volume.id ?? '');
    if (id == null || id <= 0) {
      return GenericResult(success: false, data: null);
    }
    return _adapter.api().deleteVolume(id);
  }

  @override
  Future<GenericResult<bool>> resizeVolume(
    final ServerProviderVolume volume,
    final DiskSize size,
  ) async {
    final id = int.tryParse(volume.id ?? '');
    if (id == null || id <= 0) {
      return GenericResult(success: false, data: false);
    }
    return _adapter.api().resizeVolume(
      HetznerVolume(
        id,
        volume.sizeByte,
        int.tryParse(volume.serverId ?? ''),
        volume.name,
        volume.linuxDevice,
        HetznerLocation.empty(),
      ),
      size,
    );
  }

  @override
  Future<GenericResult<bool>> attachVolume(
    final ServerProviderVolume volume,
    final String providerId,
  ) async {
    final id = int.tryParse(volume.id ?? '');
    if (id == null || id <= 0) {
      return GenericResult(success: false, data: false);
    }
    return _adapter.api().attachVolume(
      HetznerVolume(
        id,
        volume.sizeByte,
        int.tryParse(volume.serverId ?? ''),
        volume.name,
        volume.linuxDevice,
        HetznerLocation.empty(),
      ),
      int.parse(providerId),
    );
  }

  @override
  Future<GenericResult<bool>> detachVolume(
    final ServerProviderVolume volume,
  ) async {
    final id = int.tryParse(volume.id ?? '');
    if (id == null || id <= 0) {
      return GenericResult(success: false, data: false);
    }
    return _adapter.api().detachVolume(id);
  }

  @override
  Future<GenericResult<List<ServerMetadataEntity>>> getMetadata(
    final String providerId,
    final String location,
  ) async {
    List<ServerMetadataEntity> metadata = [];
    final resultServers = await _adapter.api().getServers();
    if (resultServers.data.isEmpty || !resultServers.success) {
      return GenericResult(
        success: false,
        data: metadata,
        code: resultServers.code,
        message: resultServers.message,
      );
    }
    final resultVolumes = await _adapter.api().getVolumes();
    if (resultVolumes.data.isEmpty || !resultVolumes.success) {
      return GenericResult(
        success: false,
        data: metadata,
        code: resultVolumes.code,
        message: resultVolumes.message,
      );
    }
    final resultPricePerGb = await getAdditionalPricing(location);
    if (resultPricePerGb.data == null || !resultPricePerGb.success) {
      return GenericResult(
        success: false,
        data: metadata,
        code: resultPricePerGb.code,
        message: resultPricePerGb.message,
      );
    }

    final List<HetznerServerInfo> servers = resultServers.data;
    final List<HetznerVolume> volumes = resultVolumes.data;

    try {
      final Price pricePerGb = resultPricePerGb.data!.perVolumeGb;
      final Price pricePerIp = resultPricePerGb.data!.perPublicIpv4;
      final HetznerServerInfo server = servers.firstWhere(
        (final server) => server.id.toString() == providerId,
      );
      final HetznerVolume volume = volumes.firstWhere(
        (final volume) => server.volumes.contains(volume.id),
      );
      final HetznerPriceInfo serverPrice = server.serverType.prices.firstWhere(
        (final price) => price.location == server.location.name,
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
          value: '${server.serverType.memory} GB',
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          trId: 'server.monthly_cost',
          value:
              // TODO(NaiJi): Make more descriptive
              '${serverPrice.monthly.toStringAsFixed(2)} + ${(volume.size * pricePerGb.value).toStringAsFixed(2)} + ${pricePerIp.value.toStringAsFixed(2)} ${currency.shortcode}',
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          trId: 'server.location',
          value: '${server.location.city}, ${server.location.country}',
        ),
        ServerMetadataEntity(
          type: MetadataType.other,
          trId: 'server.server_provider',
          value: type.displayName,
        ),
      ];
    } catch (e) {
      return GenericResult(success: false, data: [], message: e.toString());
    }

    return GenericResult(success: true, data: metadata);
  }

  @override
  Future<GenericResult<ServerMetrics?>> getMetrics(
    final String providerId,
    final DateTime start,
    final DateTime end,
  ) async {
    ServerMetrics? metrics;

    List<TimeSeriesData> serializeTimeNetworkSeries(
      final Map<String, dynamic> json,
      final String type,
    ) {
      final List list = json['time_series'][type]['values'];
      return list
          .map((final el) => TimeSeriesData(el[0], double.parse(el[1])))
          .toList();
    }

    if (cachedCoreAmount == null) {
      final serversResult = await _adapter.api().getServers();
      if (serversResult.data.isEmpty || !serversResult.success) {
        return GenericResult(
          success: false,
          data: metrics,
          code: serversResult.code,
          message: serversResult.message,
        );
      }

      for (final server in serversResult.data) {
        if (server.id.toString() == providerId) {
          cachedCoreAmount = server.serverType.cores;
        }
      }

      if (cachedCoreAmount == null) {
        return GenericResult(
          success: false,
          data: metrics,
          message: "Couldn't find active server to cache core amount",
        );
      }
    }

    List<TimeSeriesData> serializeTimeCpuSeries(
      final Map<String, dynamic> json,
      final String type,
    ) {
      final List list = json['time_series'][type]['values'];
      return list
          .map(
            (final el) =>
                TimeSeriesData(el[0], double.parse(el[1]) / cachedCoreAmount!),
          )
          .toList();
    }

    final cpuResult = await _adapter.api().getMetrics(
      int.parse(providerId),
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
      int.parse(providerId),
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
      cpu: serializeTimeCpuSeries(cpuResult.data, 'cpu'),
      bandwidthIn: serializeTimeNetworkSeries(
        netResult.data,
        'network.0.bandwidth.in',
      ),
      bandwidthOut: serializeTimeNetworkSeries(
        netResult.data,
        'network.0.bandwidth.out',
      ),
      end: end,
      start: start,
      stepsInSecond: cpuResult.data['step'],
    );

    return GenericResult(data: metrics, success: true);
  }
}
