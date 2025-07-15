// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/digital_ocean_server_info.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
import 'package:selfprivacy/utils/network_utils.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class ApiAdapter {
  ApiAdapter({final bool isWithToken = true, final String? token})
    : _api = DigitalOceanApi(isWithToken: isWithToken, token: token ?? '');

  DigitalOceanApi api({final bool getInitialized = true}) =>
      getInitialized ? _api : DigitalOceanApi(isWithToken: false);

  final DigitalOceanApi _api;
}

class DigitalOceanServerProvider extends ServerProvider {
  DigitalOceanServerProvider() : _adapter = ApiAdapter(isWithToken: false);
  DigitalOceanServerProvider.load({
    required final bool isAuthorized,
    final String? token,
  }) : _adapter = ApiAdapter(isWithToken: isAuthorized, token: token);

  final ApiAdapter _adapter;
  final Currency currency = Currency.fromType(CurrencyType.usd);

  static final logger = const AppLogger(name: 'digital_ocean').log;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  ServerProviderType get type => ServerProviderType.digitalOcean;

  @override
  Future<GenericResult<List<ServerBasicInfo>>> getServers() async {
    List<ServerBasicInfo> servers = [];
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
    servers =
        rawServers.map<ServerBasicInfo>((final server) {
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
            location: server['region']['slug'],
          );
        }).toList();

    return GenericResult(success: true, data: servers);
  }

  @override
  Future<GenericResult<ServerType?>> getServerType(final int serverId) async {
    ServerType? serverType;
    dynamic server;
    final result = await _adapter.api().getServers();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: serverType,
        code: result.code,
        message: result.message,
      );
    }

    final List rawServers = result.data;
    for (final rawServer in rawServers) {
      if (rawServer['networks']['v4'].isNotEmpty) {
        for (final v4 in rawServer['networks']['v4']) {
          if (v4['type'].toString() == 'public') {
            server = rawServer;
          }
        }
      }
    }

    if (server == null) {
      const String msg = 'getServerType: no server!';
      logger(msg);
      return GenericResult(success: false, data: serverType, message: msg);
    }

    final rawLocationsResult = await getAvailableLocations();
    if (rawLocationsResult.data.isEmpty || !rawLocationsResult.success) {
      return GenericResult(
        success: rawLocationsResult.success,
        data: serverType,
        code: rawLocationsResult.code,
        message: rawLocationsResult.message,
      );
    }

    ServerProviderLocation? location;
    for (final rawLocation in rawLocationsResult.data) {
      if (rawLocation.identifier == server['region']['slug']) {
        location = rawLocation;
      }
    }

    if (location == null) {
      const String msg = 'getServerType: no location!';
      logger(msg);
      return GenericResult(success: false, data: serverType, message: msg);
    }

    ServerType? type;
    final rawSize = DigitalOceanServerType.fromJson(server['size']);
    for (final rawRegion in rawSize.regions) {
      if (rawRegion == server['region']['slug']) {
        type = ServerType(
          title: rawSize.description,
          identifier: rawSize.slug,
          ram: rawSize.memory / 1024,
          cores: rawSize.vcpus,
          disk: DiskSize(byte: rawSize.disk * 1024 * 1024 * 1024),
          price: Price(value: rawSize.priceMonthly, currency: currency),
          location: location,
        );
      }
    }

    return GenericResult(success: true, data: type);
  }

  @override
  Future<GenericResult<CallbackDialogueBranching?>> launchInstallation(
    final LaunchInstallationData installationData,
  ) async {
    ServerHostingDetails? serverDetails;
    final serverApiToken = StringGenerators.apiToken();
    final hostname = getHostnameFromDomain(
      installationData.serverDomain.domainName,
    );
    final pastServers = await getServers();
    for (final pastServer in pastServers.data) {
      if (pastServer.name == hostname) {
        return GenericResult(
          data: CallbackDialogueBranching(
            choices: [
              CallbackDialogueChoice(
                title: 'basis.cancel'.tr(),
                callback: () async => installationData.errorCallback(),
              ),
              CallbackDialogueChoice(
                title: 'modals.yes'.tr(),
                callback: () async {
                  final deleting = await deleteServer(hostname);
                  if (deleting.success) {
                    await Future.delayed(const Duration(seconds: 20));
                    return launchInstallation(installationData);
                  }

                  return deleting;
                },
              ),
            ],
            description: 'modals.destroy_server'.tr(),
            title: 'modals.already_exists'.tr(),
          ),
          success: false,
          message: 'Droplet "$hostname" already exists.',
        );
      }
    }

    final serverResult = await _adapter.api().createServer(
      dnsApiToken: installationData.dnsApiToken,
      rootUser: installationData.rootUser,
      domainName: installationData.serverDomain.domainName,
      serverType: installationData.serverTypeId,
      dnsProviderType: installationData.dnsProviderType.toInfectName(),
      hostName: hostname,
      base64Password: base64.encode(
        utf8.encode(installationData.rootUser.password ?? 'PASS'),
      ),
      databasePassword: StringGenerators.dbPassword(),
      serverApiToken: serverApiToken,
      customSshKey: installationData.customSshKey,
      region: installationData.location,
    );

    if (!serverResult.success || serverResult.data == null) {
      GenericResult(
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(
              title: 'basis.cancel'.tr(),
              callback: () async => await installationData.errorCallback(),
            ),
            CallbackDialogueChoice(
              title: 'modals.try_again'.tr(),
              callback: () => launchInstallation(installationData),
            ),
          ],
          description: serverResult.message ?? 'recovering.generic_error'.tr(),
          title: 'modals.unexpected_error'.tr(),
        ),
        success: false,
        message: serverResult.message,
        code: serverResult.code,
      );
    }

    try {
      final int dropletId = serverResult.data!;
      final newVolume =
          (await createVolume(
            installationData.storageSize.gibibyte.toInt(),
            installationData.location,
          )).data;
      final bool attachedVolume =
          (await _adapter.api().attachVolume(
            name: newVolume!.name,
            serverId: dropletId,
            region: installationData.location,
          )).data;

      String? ipv4;
      int attempts = 0;
      while (attempts < 10 && ipv4 == null) {
        await Future.delayed(const Duration(seconds: 20));
        final servers = await getServers();
        for (final server in servers.data) {
          if (server.name == hostname && server.ip != '0.0.0.0') {
            ipv4 = server.ip;
            break;
          }
        }
        ++attempts;
      }

      if (attachedVolume && ipv4 != null) {
        serverDetails = ServerHostingDetails(
          id: dropletId,
          ip4: ipv4,
          createTime: DateTime.now(),
          volume: newVolume,
          apiToken: serverApiToken,
          provider: ServerProviderType.digitalOcean,
        );
      }
    } catch (e) {
      return GenericResult(
        success: false,
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(title: 'basis.cancel'.tr(), callback: null),
            CallbackDialogueChoice(
              title: 'modals.try_again'.tr(),
              callback: () async {
                await Future.delayed(const Duration(seconds: 5));
                final deletion = await deleteServer(hostname);
                return deletion.success
                    ? await launchInstallation(installationData)
                    : deletion;
              },
            ),
          ],
          description: 'modals.try_again'.tr(),
          title: 'modals.server_deletion_error'.tr(),
        ),
        message: e.toString(),
      );
    }

    await installationData.successCallback(serverDetails!);
    return GenericResult(success: true, data: null);
  }

  @override
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

      final volumes = await getVolumes();
      final ServerProviderVolume volumeToRemove;
      volumeToRemove = volumes.data.firstWhere(
        (final el) => el.serverId == foundServer!.id,
      );

      if (volumeToRemove.location == null) {
        throw Exception('Volume location is null!');
      }

      await _adapter.api().detachVolume(
        name: volumeToRemove.name,
        serverId: volumeToRemove.serverId!,
        region: volumeToRemove.location!,
      );

      await Future.delayed(const Duration(seconds: 10));
      final List<Future> laterFutures = <Future>[
        _adapter.api().deleteVolume(volumeToRemove.uuid!),
        _adapter.api().deleteServer(foundServer!.id),
      ];

      await Future.wait(laterFutures);
    } catch (e) {
      logger("Couldn't delete the server", error: e);
      return GenericResult(
        success: false,
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(title: 'basis.cancel'.tr(), callback: null),
            CallbackDialogueChoice(
              title: 'modals.try_again'.tr(),
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

    return GenericResult(success: true, data: null);
  }

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }

    return result;
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

    final List<DigitalOceanLocation> rawLocations = result.data;
    for (final rawLocation in rawLocations) {
      ServerProviderLocation? location;
      try {
        location = ServerProviderLocation(
          title: rawLocation.slug,
          description: rawLocation.name,
          flag: rawLocation.flag,
          identifier: rawLocation.slug,
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
        message: result.message,
      );
    }

    final List<DigitalOceanServerType> rawSizes = result.data;
    for (final rawSize in rawSizes) {
      for (final rawRegion in rawSize.regions) {
        if (rawRegion == location.identifier && rawSize.memory > 1024) {
          types.add(
            ServerType(
              title: rawSize.description,
              identifier: rawSize.slug,
              ram: rawSize.memory / 1024,
              cores: rawSize.vcpus,
              disk: DiskSize(byte: rawSize.disk * 1024 * 1024 * 1024),
              price: Price(value: rawSize.priceMonthly, currency: currency),
              location: location,
            ),
          );
        }
      }
    }

    return GenericResult(success: true, data: types);
  }

  @override
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

    return GenericResult(success: true, data: timestamp);
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

    return GenericResult(success: true, data: timestamp);
  }

  @override
  Future<GenericResult<AdditionalPricing?>> getAdditionalPricing(
    final String location,
  ) async => GenericResult(
    success: true,
    data: AdditionalPricing(
      perVolumeGb: Price(
        /// Hardcoded in their documentation and there is no pricing API
        value: 0.10,
        currency: currency,
      ),
      perPublicIpv4: Price(value: 0, currency: currency),
    ),
  );

  @override
  Future<GenericResult<List<ServerProviderVolume>>> getVolumes({
    final String? status,
  }) async {
    final List<ServerProviderVolume> volumes = [];

    final result = await _adapter.api().getVolumes();

    if (!result.success || result.data.isEmpty) {
      return GenericResult(
        data: [],
        success: false,
        code: result.code,
        message: result.message,
      );
    }

    try {
      int id = 0;
      for (final rawVolume in result.data) {
        final String volumeName = rawVolume.name;
        final volume = ServerProviderVolume(
          id: id++,
          name: volumeName,
          sizeByte: rawVolume.sizeGigabytes * 1024 * 1024 * 1024,
          serverId:
              (rawVolume.dropletIds != null && rawVolume.dropletIds!.isNotEmpty)
                  ? rawVolume.dropletIds![0]
                  : null,
          linuxDevice: 'scsi-0DO_Volume_$volumeName',
          uuid: rawVolume.id,
          location: rawVolume.region.slug,
        );
        volumes.add(volume);
      }
    } catch (e) {
      logger("Couldn't parse volumes", error: e);
      return GenericResult(data: [], success: false, message: e.toString());
    }

    return GenericResult(data: volumes, success: true);
  }

  @override
  Future<GenericResult<ServerProviderVolume?>> createVolume(
    final int gb,
    final String location,
  ) async {
    ServerProviderVolume? volume;

    final result = await _adapter.api().createVolume(gb: gb, region: location);

    if (!result.success || result.data == null) {
      return GenericResult(
        data: null,
        success: false,
        code: result.code,
        message: result.message,
      );
    }

    final getVolumesResult = await _adapter.api().getVolumes();

    if (!getVolumesResult.success || getVolumesResult.data.isEmpty) {
      return GenericResult(
        data: null,
        success: false,
        code: result.code,
        message: result.message,
      );
    }

    final String volumeName = result.data!.name;
    volume = ServerProviderVolume(
      id: getVolumesResult.data.length,
      name: volumeName,
      sizeByte: result.data!.sizeGigabytes,
      serverId: null,
      linuxDevice: '/dev/disk/by-id/scsi-0DO_Volume_$volumeName',
      uuid: result.data!.id,
    );

    return GenericResult(data: volume, success: true);
  }

  Future<GenericResult<ServerProviderVolume?>> getVolume(
    final String volumeUuid,
  ) async {
    ServerProviderVolume? requestedVolume;

    final result = await getVolumes();

    if (!result.success || result.data.isEmpty) {
      return GenericResult(
        data: null,
        success: false,
        code: result.code,
        message: result.message,
      );
    }

    for (final volume in result.data) {
      if (volume.uuid == volumeUuid) {
        requestedVolume = volume;
      }
    }

    return GenericResult(data: requestedVolume, success: true);
  }

  @override
  Future<GenericResult<bool>> attachVolume(
    final ServerProviderVolume volume,
    final int serverId,
  ) => _adapter.api().attachVolume(
    name: volume.name,
    serverId: serverId,
    region: volume.location!,
  );

  @override
  Future<GenericResult<bool>> detachVolume(final ServerProviderVolume volume) =>
      _adapter.api().detachVolume(
        name: volume.name,
        serverId: volume.serverId!,
        region: volume.location!,
      );

  @override
  Future<GenericResult<void>> deleteVolume(final ServerProviderVolume volume) =>
      _adapter.api().deleteVolume(volume.uuid!);

  @override
  Future<GenericResult<bool>> resizeVolume(
    final ServerProviderVolume volume,
    final DiskSize size,
  ) => _adapter.api().resizeVolume(
    uuid: volume.uuid!,
    gb: size.gibibyte.toInt(),
    region: volume.location!,
  );

  @override
  Future<GenericResult<List<ServerMetadataEntity>>> getMetadata(
    final int serverId,
    final String location,
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

    final List servers = result.data;
    final List<DigitalOceanVolume> volumes = resultVolumes.data;
    try {
      final Price pricePerGb = resultPricePerGb.data!.perVolumeGb;
      final droplet = servers.firstWhere(
        (final server) => server['id'] == serverId,
      );

      final volume = volumes.firstWhere(
        (final volume) => droplet['volume_ids'].contains(volume.id),
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
          value: "${droplet['memory']} MB",
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          trId: 'server.monthly_cost',
          value:
              '${droplet['size']['price_monthly']} + ${(volume.sizeGigabytes * pricePerGb.value).toStringAsFixed(2)} ${currency.shortcode}',
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          trId: 'server.location',
          value: '${droplet['region']['name']}',
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
      double currentMetricLoad = 0;
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
      serverId: serverId,
      start: start,
      end: end,
      isInbound: true,
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
      serverId: serverId,
      start: start,
      end: end,
      isInbound: false,
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
      bandwidthIn:
          inboundResult.data
              .map(
                (final el) =>
                    TimeSeriesData(el[0], double.parse(el[1]) * 100000),
              )
              .toList(),
      bandwidthOut:
          outboundResult.data
              .map(
                (final el) =>
                    TimeSeriesData(el[0], double.parse(el[1]) * 100000),
              )
              .toList(),
      cpu: calculateCpuLoadMetrics(cpuResult.data),
      start: start,
      end: end,
      stepsInSecond: step,
    );

    return GenericResult(success: true, data: metrics);
  }
}
