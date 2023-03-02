import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';
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

  String dnsProviderToInfectName(final DnsProviderType dnsProvider) {
    String dnsProviderType;
    switch (dnsProvider) {
      case DnsProviderType.digitalOcean:
        dnsProviderType = 'DIGITALOCEAN';
        break;
      case DnsProviderType.cloudflare:
      default:
        dnsProviderType = 'CLOUDFLARE';
        break;
    }
    return dnsProviderType;
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
              callback: await installationData.errorCallback(),
            ),
            CallbackDialogueChoice(
              title: 'basis.try_again'.tr(),
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
    final hostname = getHostnameFromDomain(installationData.domainName);

    final serverResult = await _adapter.api().createServer(
          dnsApiToken: installationData.dnsApiToken,
          rootUser: installationData.rootUser,
          domainName: installationData.domainName,
          serverType: installationData.serverTypeId,
          dnsProviderType:
              dnsProviderToInfectName(installationData.dnsProviderType),
          hostName: hostname,
          volumeId: volume.id,
          base64Password: base64.encode(
            utf8.encode(installationData.rootUser.password ?? 'PASS'),
          ),
          databasePassword: StringGenerators.dbPassword(),
          serverApiToken: serverApiToken,
        );

    if (!serverResult.success || serverResult.data == null) {
      await _adapter.api().deleteVolume(volume);
      await Future.delayed(const Duration(seconds: 5));
      if (serverResult.message != null &&
          serverResult.message == 'uniqueness_error') {
        return GenericResult(
          data: CallbackDialogueBranching(
            choices: [
              CallbackDialogueChoice(
                title: 'basis.cancel'.tr(),
                callback: installationData.errorCallback(),
              ),
              CallbackDialogueChoice(
                title: 'basis.yes'.tr(),
                callback: () async {
                  final deleting = await deleteServer(hostname);
                  if (deleting.success) {
                    return launchInstallation(installationData);
                  }

                  return deleting;
                },
              ),
            ],
            description: volumeResult.message ?? 'modals.destroy_server'.tr(),
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
                title: 'basis.try_again'.tr(),
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
      id: serverResult.data['server']['id'],
      ip4: serverResult.data['server']['public_net']['ipv4']['ip'],
      createTime: DateTime.now(),
      volume: volume,
      apiToken: serverApiToken,
      provider: ServerProviderType.hetzner,
    );

    final createDnsResult = await _adapter.api().createReverseDns(
          serverId: serverDetails.id,
          ip4: serverDetails.ip4,
          dnsPtr: installationData.domainName,
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
              title: 'basis.try_again'.tr(),
              callback: () async {
                await _adapter.api().deleteVolume(volume);
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

  Future<GenericResult<CallbackDialogueBranching?>> deleteServer(
    final String hostname,
  ) async {}
}
