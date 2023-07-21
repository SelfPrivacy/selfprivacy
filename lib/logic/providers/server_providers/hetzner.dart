import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
import 'package:selfprivacy/utils/network_utils.dart';
import 'package:selfprivacy/utils/password_generator.dart';

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
    final String? location,
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
          region: location,
        );

  ApiAdapter _adapter;
  final Currency currency = Currency.fromType(CurrencyType.eur);

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
          id: hetznerServer.id,
          name: hetznerServer.name,
          ip: hetznerServer.publicNet.ipv4!.ip,
          reverseDns: hetznerServer.publicNet.ipv4!.reverseDns,
          created: hetznerServer.created,
          serverTypeId: hetznerServer.name,
        );
      } catch (e) {
        continue;
      }

      servers.add(server);
    }

    return GenericResult(success: true, data: servers);
  }

  @override
  Future<GenericResult<ServerType?>> getServerType(final int serverId) async {
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
      if (hetznerServer.publicNet.ipv4 != null ||
          hetznerServer.id == serverId) {
        server = hetznerServer;
        break;
      }
    }

    if (server == null) {
      const String msg = 'getServerType: no server!';
      print(msg);
      return GenericResult(
        success: false,
        data: serverType,
        message: msg,
      );
    }

    double? priceValue;
    for (final price in server.serverType.prices) {
      if (price.location == server.location.name) {
        priceValue = price.monthly;
      }
    }

    if (priceValue == null) {
      const String msg = 'getServerType: no price!';
      print(msg);
      return GenericResult(
        success: false,
        data: serverType,
        message: msg,
      );
    }

    return GenericResult(
      success: true,
      data: ServerType(
        title: server.serverType.description,
        identifier: server.serverType.name,
        ram: server.serverType.memory.toDouble(),
        cores: server.serverType.cores,
        disk: DiskSize(byte: server.serverType.disk * 1024 * 1024 * 1024),
        price: Price(
          value: priceValue,
          currency: currency,
        ),
        location: ServerProviderLocation(
          title: server.location.city,
          description: server.location.description,
          flag: server.location.flag,
          identifier: server.location.name,
        ),
      ),
    );
  }

  @override
  Future<GenericResult<CallbackDialogueBranching?>> launchInstallation(
    final LaunchInstallationData installationData,
  ) async {
    final volumeResult = await _adapter.api().createVolume();

    if (!volumeResult.success || volumeResult.data == null) {
      return GenericResult(
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(
              title: 'basis.cancel'.tr(),
              callback: () async => await installationData.errorCallback(),
            ),
            CallbackDialogueChoice(
              title: 'modals.try_again'.tr(),
              callback: () async => launchInstallation(installationData),
            ),
          ],
          description:
              volumeResult.message ?? 'modals.volume_creation_error'.tr(),
          title: 'modals.unexpected_error'.tr(),
        ),
        success: false,
        message: volumeResult.message,
        code: volumeResult.code,
      );
    }

    final volume = volumeResult.data!;
    final serverApiToken = StringGenerators.apiToken();
    final hostname = getHostnameFromDomain(
      installationData.serverDomain.domainName,
    );

    final serverResult = await _adapter.api().createServer(
          dnsApiToken: installationData.dnsApiToken,
          rootUser: installationData.rootUser,
          domainName: installationData.serverDomain.domainName,
          serverType: installationData.serverTypeId,
          dnsProviderType: installationData.dnsProviderType.toInfectName(),
          hostName: hostname,
          volumeId: volume.id,
          base64Password: base64.encode(
            utf8.encode(installationData.rootUser.password ?? 'PASS'),
          ),
          databasePassword: StringGenerators.dbPassword(),
          serverApiToken: serverApiToken,
        );

    if (!serverResult.success || serverResult.data == null) {
      await _adapter.api().deleteVolume(volume.id);
      await Future.delayed(const Duration(seconds: 5));
      if (serverResult.message != null &&
          serverResult.message == 'uniqueness_error') {
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
          message: volumeResult.message,
          code: volumeResult.code,
        );
      } else {
        return GenericResult(
          data: CallbackDialogueBranching(
            choices: [
              CallbackDialogueChoice(
                title: 'basis.cancel'.tr(),
                callback: () async {
                  final deletion = await deleteServer(hostname);
                  if (deletion.success) {
                    installationData.errorCallback();
                  }

                  return deletion;
                },
              ),
              CallbackDialogueChoice(
                title: 'modals.try_again'.tr(),
                callback: () async => launchInstallation(installationData),
              ),
            ],
            description:
                volumeResult.message ?? 'recovering.generic_error'.tr(),
            title: 'modals.unexpected_error'.tr(),
          ),
          success: false,
          message: volumeResult.message,
          code: volumeResult.code,
        );
      }
    }

    final serverDetails = ServerHostingDetails(
      id: serverResult.data!.id,
      ip4: serverResult.data!.publicNet.ipv4!.ip,
      createTime: DateTime.now(),
      volume: ServerVolume(
        id: volume.id,
        name: volume.name,
        sizeByte: volume.size * 1024 * 1024 * 1024,
        serverId: volume.serverId,
        linuxDevice: volume.linuxDevice,
      ),
      apiToken: serverApiToken,
      provider: ServerProviderType.hetzner,
    );

    final createDnsResult = await _adapter.api().createReverseDns(
          serverId: serverDetails.id,
          ip4: serverDetails.ip4,
          dnsPtr: installationData.serverDomain.domainName,
        );

    if (!createDnsResult.success) {
      return GenericResult(
        data: CallbackDialogueBranching(
          choices: [
            CallbackDialogueChoice(
              title: 'basis.cancel'.tr(),
              callback: () async {
                final deletion = await deleteServer(hostname);
                if (deletion.success) {
                  installationData.errorCallback();
                }

                return deletion;
              },
            ),
            CallbackDialogueChoice(
              title: 'modals.try_again'.tr(),
              callback: () async {
                await _adapter.api().deleteVolume(volume.id);
                await Future.delayed(const Duration(seconds: 5));
                final deletion = await deleteServer(hostname);
                if (deletion.success) {
                  await Future.delayed(const Duration(seconds: 5));
                  return launchInstallation(installationData);
                }

                return deletion;
              },
            ),
          ],
          description: volumeResult.message ?? 'recovering.generic_error'.tr(),
          title: 'modals.unexpected_error'.tr(),
        ),
        success: false,
        message: volumeResult.message,
        code: volumeResult.code,
      );
    }

    await installationData.successCallback(serverDetails);
    return GenericResult(success: true, data: null);
  }

  @override
  Future<GenericResult<CallbackDialogueBranching?>> deleteServer(
    final String hostname,
  ) async {
    final serversResult = await _adapter.api().getServers();
    try {
      final servers = serversResult.data;
      HetznerServerInfo? foundServer;
      for (final server in servers) {
        if (server.name == hostname) {
          foundServer = server;
          break;
        }
      }

      for (final volumeId in foundServer!.volumes) {
        await _adapter.api().detachVolume(volumeId);
      }

      await Future.delayed(const Duration(seconds: 10));
      final List<Future> laterFutures = <Future>[];

      for (final volumeId in foundServer.volumes) {
        laterFutures.add(_adapter.api().deleteVolume(volumeId));
      }
      laterFutures.add(_adapter.api().deleteServer(serverId: foundServer.id));

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

    return GenericResult(
      success: true,
      data: null,
    );
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

    final List<HetznerLocation> rawLocations = result.data;
    for (final rawLocation in rawLocations) {
      ServerProviderLocation? location;
      try {
        location = ServerProviderLocation(
          title: rawLocation.city,
          description: rawLocation.description,
          flag: rawLocation.flag,
          identifier: rawLocation.name,
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

    final rawTypes = result.data;
    for (final rawType in rawTypes) {
      for (final rawPrice in rawType.prices) {
        if (rawPrice.location == location.identifier) {
          types.add(
            ServerType(
              title: rawType.description,
              identifier: rawType.name,
              ram: rawType.memory.toDouble(),
              cores: rawType.cores,
              disk: DiskSize(byte: rawType.disk * 1024 * 1024 * 1024),
              price: Price(
                value: rawPrice.monthly,
                currency: currency,
              ),
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

    return GenericResult(
      success: true,
      data: timestamp,
    );
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

  @override
  Future<GenericResult<Price?>> getPricePerGb() async {
    final result = await _adapter.api().getPricePerGb();

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
      data: Price(
        value: result.data!,
        currency: currency,
      ),
    );
  }

  @override
  Future<GenericResult<List<ServerVolume>>> getVolumes({
    final String? status,
  }) async {
    final List<ServerVolume> volumes = [];

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
        final volume = ServerVolume(
          id: volumeId,
          name: volumeName,
          sizeByte: volumeSize,
          serverId: volumeServer,
          linuxDevice: volumeDevice,
        );
        volumes.add(volume);
      }
    } catch (e) {
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    }

    return GenericResult(
      data: volumes,
      success: true,
      code: result.code,
      message: result.message,
    );
  }

  @override
  Future<GenericResult<ServerVolume?>> createVolume() async {
    ServerVolume? volume;

    final result = await _adapter.api().createVolume();

    if (!result.success || result.data == null) {
      return GenericResult(
        data: null,
        success: false,
        message: result.message,
        code: result.code,
      );
    }

    try {
      volume = ServerVolume(
        id: result.data!.id,
        name: result.data!.name,
        sizeByte: result.data!.size * 1024 * 1024 * 1024,
        serverId: result.data!.serverId,
        linuxDevice: result.data!.linuxDevice,
      );
    } catch (e) {
      print(e);
      return GenericResult(
        data: null,
        success: false,
        message: e.toString(),
      );
    }

    return GenericResult(
      data: volume,
      success: true,
      code: result.code,
      message: result.message,
    );
  }

  @override
  Future<GenericResult<void>> deleteVolume(final ServerVolume volume) async =>
      _adapter.api().deleteVolume(volume.id);

  @override
  Future<GenericResult<bool>> resizeVolume(
    final ServerVolume volume,
    final DiskSize size,
  ) async =>
      _adapter.api().resizeVolume(
            HetznerVolume(
              volume.id,
              volume.sizeByte,
              volume.serverId,
              volume.name,
              volume.linuxDevice,
            ),
            size,
          );

  @override
  Future<GenericResult<bool>> attachVolume(
    final ServerVolume volume,
    final int serverId,
  ) async =>
      _adapter.api().attachVolume(
            HetznerVolume(
              volume.id,
              volume.sizeByte,
              volume.serverId,
              volume.name,
              volume.linuxDevice,
            ),
            serverId,
          );

  @override
  Future<GenericResult<bool>> detachVolume(
    final ServerVolume volume,
  ) async =>
      _adapter.api().detachVolume(
            volume.id,
          );

  @override
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
          value:
              '${server.serverType.prices[1].monthly.toStringAsFixed(2)} ${currency.shortcode}',
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

  @override
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
}
