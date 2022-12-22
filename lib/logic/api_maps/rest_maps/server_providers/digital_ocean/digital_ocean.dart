import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class DigitalOceanApi extends ServerProviderApi with VolumeProviderApi {
  DigitalOceanApi({
    required this.region,
    this.hasLogger = true,
    this.isWithToken = true,
  });
  @override
  bool hasLogger;
  @override
  bool isWithToken;

  final String? region;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      final String? token = getIt<ApiConfigModel>().serverProviderKey;
      assert(token != null);
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String get rootAddress => 'https://api.digitalocean.com/v2';

  @override
  String get infectProviderName => 'digitalocean';

  @override
  String get displayProviderName => 'Digital Ocean';

  @override
  Future<APIGenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String message = '';
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/account',
        options: Options(
          followRedirects: false,
          validateStatus: (final status) =>
              status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      print(e);
      isValid = false;
      message = e.toString();
    } finally {
      close(client);
    }

    if (response == null) {
      return APIGenericResult(
        data: isValid,
        success: false,
        message: message,
      );
    }

    if (response.statusCode == HttpStatus.ok) {
      isValid = true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      isValid = false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }

    return APIGenericResult(
      data: isValid,
      success: true,
      message: response.statusMessage,
    );
  }

  /// Hardcoded on their documentation and there is no pricing API at all
  /// Probably we should scrap the doc page manually
  @override
  Future<Price?> getPricePerGb() async => Price(
        value: 0.10,
        currency: 'USD',
      );

  @override
  Future<APIGenericResult<ServerVolume?>> createVolume() async {
    ServerVolume? volume;

    Response? createVolumeResponse;
    final Dio client = await getClient();
    try {
      final List<ServerVolume> volumes = await getVolumes();
      await Future.delayed(const Duration(seconds: 6));

      createVolumeResponse = await client.post(
        '/volumes',
        data: {
          'size_gigabytes': 10,
          'name': 'volume${StringGenerators.storageName()}',
          'labels': {'labelkey': 'value'},
          'region': region,
          'filesystem_type': 'ext4',
        },
      );
      final volumeId = createVolumeResponse.data['volume']['id'];
      final volumeSize = createVolumeResponse.data['volume']['size_gigabytes'];
      final volumeName = createVolumeResponse.data['volume']['name'];
      volume = ServerVolume(
        id: volumes.length,
        name: volumeName,
        sizeByte: volumeSize,
        serverId: null,
        linuxDevice: '/dev/disk/by-id/scsi-0DO_Volume_$volumeName',
        uuid: volumeId,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: null,
        success: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return APIGenericResult(
      data: volume,
      success: true,
      code: createVolumeResponse.statusCode,
      message: createVolumeResponse.statusMessage,
    );
  }

  @override
  Future<List<ServerVolume>> getVolumes({final String? status}) async {
    final List<ServerVolume> volumes = [];

    final Response getVolumesResponse;
    final Dio client = await getClient();
    try {
      getVolumesResponse = await client.get(
        '/volumes',
        queryParameters: {
          'status': status,
        },
      );
      final List<dynamic> rawVolumes = getVolumesResponse.data['volumes'];
      int id = 0;
      for (final rawVolume in rawVolumes) {
        final volumeId = rawVolume['id'];
        final int volumeSize = rawVolume['size_gigabytes'] * 1024 * 1024 * 1024;
        final volumeDropletIds = rawVolume['droplet_ids'];
        final String volumeName = rawVolume['name'];
        final volume = ServerVolume(
          id: id++,
          name: volumeName,
          sizeByte: volumeSize,
          serverId: volumeDropletIds.isNotEmpty ? volumeDropletIds[0] : null,
          linuxDevice: 'scsi-0DO_Volume_$volumeName',
          uuid: volumeId,
        );
        volumes.add(volume);
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volumes;
  }

  Future<ServerVolume?> getVolume(final String volumeUuid) async {
    ServerVolume? requestedVolume;

    final List<ServerVolume> volumes = await getVolumes();

    for (final volume in volumes) {
      if (volume.uuid == volumeUuid) {
        requestedVolume = volume;
      }
    }

    return requestedVolume;
  }

  @override
  Future<void> deleteVolume(final ServerVolume volume) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/${volume.uuid}');
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<APIGenericResult<bool>> attachVolume(
    final ServerVolume volume,
    final int serverId,
  ) async {
    bool success = false;

    Response? attachVolumeResponse;
    final Dio client = await getClient();
    try {
      attachVolumeResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'attach',
          'volume_name': volume.name,
          'region': region,
          'droplet_id': serverId,
        },
      );
      success =
          attachVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(
      data: success,
      success: true,
      code: attachVolumeResponse.statusCode,
      message: attachVolumeResponse.statusMessage,
    );
  }

  @override
  Future<bool> detachVolume(final ServerVolume volume) async {
    bool success = false;

    final Response detachVolumeResponse;
    final Dio client = await getClient();
    try {
      detachVolumeResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'detach',
          'volume_name': volume.name,
          'droplet_id': volume.serverId,
          'region': region,
        },
      );
      success =
          detachVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  @override
  Future<bool> resizeVolume(
    final ServerVolume volume,
    final DiskSize size,
  ) async {
    bool success = false;

    final Response resizeVolumeResponse;
    final Dio client = await getClient();
    try {
      resizeVolumeResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'resize',
          'volume_name': volume.name,
          'size_gigabytes': size.gibibyte,
          'region': region,
        },
      );
      success =
          resizeVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  static String getHostnameFromDomain(final String domain) {
    // Replace all non-alphanumeric characters with an underscore
    String hostname =
        domain.split('.')[0].replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
    if (hostname.endsWith('-')) {
      hostname = hostname.substring(0, hostname.length - 1);
    }
    if (hostname.startsWith('-')) {
      hostname = hostname.substring(1);
    }
    if (hostname.isEmpty) {
      hostname = 'selfprivacy-server';
    }

    return hostname;
  }

  @override
  Future<APIGenericResult<ServerHostingDetails?>> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final String serverType,
  }) async {
    ServerHostingDetails? serverDetails;

    final String dbPassword = StringGenerators.dbPassword();
    final String apiToken = StringGenerators.apiToken();

    final String base64Password =
        base64.encode(utf8.encode(rootUser.password ?? 'PASS'));

    final String formattedHostname = getHostnameFromDomain(domainName);
    const String infectBranch = 'providers/digital-ocean';
    final String stagingAcme = StagingOptions.stagingAcme ? 'true' : 'false';

    final String userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/$infectBranch/nixos-infect | PROVIDER=$infectProviderName STAGING_ACME='$stagingAcme' DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$formattedHostname bash 2>&1 | tee /tmp/infect.log";
    print(userdataString);

    Response? serverCreateResponse;
    final Dio client = await getClient();
    try {
      final Map<String, Object> data = {
        'name': formattedHostname,
        'size': serverType,
        'image': 'ubuntu-20-04-x64',
        'user_data': userdataString,
        'region': region!,
      };
      print('Decoded data: $data');

      serverCreateResponse = await client.post(
        '/droplets',
        data: data,
      );

      final int serverId = serverCreateResponse.data['droplet']['id'];
      final ServerVolume? newVolume = (await createVolume()).data;
      final bool attachedVolume =
          (await attachVolume(newVolume!, serverId)).data;

      String? ipv4;
      int attempts = 0;
      while (attempts < 5 && ipv4 == null) {
        await Future.delayed(const Duration(seconds: 20));
        final List<ServerBasicInfo> servers = await getServers();
        for (final server in servers) {
          if (server.name == formattedHostname && server.ip != '0.0.0.0') {
            ipv4 = server.ip;
            break;
          }
        }
        ++attempts;
      }

      if (attachedVolume && ipv4 != null) {
        serverDetails = ServerHostingDetails(
          id: serverId,
          ip4: ipv4,
          createTime: DateTime.now(),
          volume: newVolume,
          apiToken: apiToken,
          provider: ServerProvider.digitalOcean,
        );
      }
    } catch (e) {
      print(e);
      return APIGenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(
      data: serverDetails,
      success: true,
      code: serverCreateResponse.statusCode,
      message: serverCreateResponse.statusMessage,
    );
  }

  @override
  Future<APIGenericResult<bool>> deleteServer({
    required final String domainName,
  }) async {
    final Dio client = await getClient();

    final servers = await getServers();
    final ServerBasicInfo serverToRemove;
    try {
      serverToRemove = servers.firstWhere(
        (final el) => el.name == domainName,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    }

    final volumes = await getVolumes();
    final ServerVolume volumeToRemove;
    try {
      volumeToRemove = volumes.firstWhere(
        (final el) => el.serverId == serverToRemove.id,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    }

    final List<Future> laterFutures = <Future>[];

    await detachVolume(volumeToRemove);
    await Future.delayed(const Duration(seconds: 10));

    try {
      laterFutures.add(deleteVolume(volumeToRemove));
      laterFutures.add(client.delete('/droplets/$serverToRemove.id'));
      await Future.wait(laterFutures);
    } catch (e) {
      print(e);
      return APIGenericResult(
        success: false,
        data: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(
      success: true,
      data: true,
    );
  }

  @override
  Future<ServerHostingDetails> restart() async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;

    final Dio client = await getClient();
    try {
      await client.post(
        '/droplets/${server.id}/actions',
        data: {
          'type': 'reboot',
        },
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return server.copyWith(startTime: DateTime.now());
  }

  @override
  Future<ServerHostingDetails> powerOn() async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;

    final Dio client = await getClient();
    try {
      await client.post(
        '/droplets/${server.id}/actions',
        data: {
          'type': 'power_on',
        },
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return server.copyWith(startTime: DateTime.now());
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
  Future<ServerMetrics?> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  ) async {
    ServerMetrics? metrics;

    const int step = 15;
    final Dio client = await getClient();
    try {
      Response response = await client.get(
        '/monitoring/metrics/droplet/bandwidth',
        queryParameters: {
          'start': '${(start.microsecondsSinceEpoch / 1000000).round()}',
          'end': '${(end.microsecondsSinceEpoch / 1000000).round()}',
          'host_id': '$serverId',
          'interface': 'public',
          'direction': 'inbound',
        },
      );

      final List inbound = response.data['data']['result'][0]['values'];

      response = await client.get(
        '/monitoring/metrics/droplet/bandwidth',
        queryParameters: {
          'start': '${(start.microsecondsSinceEpoch / 1000000).round()}',
          'end': '${(end.microsecondsSinceEpoch / 1000000).round()}',
          'host_id': '$serverId',
          'interface': 'public',
          'direction': 'outbound',
        },
      );

      final List outbound = response.data['data']['result'][0]['values'];

      response = await client.get(
        '/monitoring/metrics/droplet/cpu',
        queryParameters: {
          'start': '${(start.microsecondsSinceEpoch / 1000000).round()}',
          'end': '${(end.microsecondsSinceEpoch / 1000000).round()}',
          'host_id': '$serverId',
        },
      );

      metrics = ServerMetrics(
        bandwidthIn: inbound
            .map(
              (final el) => TimeSeriesData(el[0], double.parse(el[1]) * 100000),
            )
            .toList(),
        bandwidthOut: outbound
            .map(
              (final el) => TimeSeriesData(el[0], double.parse(el[1]) * 100000),
            )
            .toList(),
        cpu: calculateCpuLoadMetrics(response.data['data']['result']),
        start: start,
        end: end,
        stepsInSecond: step,
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return metrics;
  }

  @override
  Future<List<ServerMetadataEntity>> getMetadata(final int serverId) async {
    List<ServerMetadataEntity> metadata = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/droplets/$serverId');
      final droplet = response.data!['droplet'];
      metadata = [
        ServerMetadataEntity(
          type: MetadataType.id,
          name: 'server.server_id'.tr(),
          value: droplet['id'].toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.status,
          name: 'server.status'.tr(),
          value: droplet['status'].toString().capitalize(),
        ),
        ServerMetadataEntity(
          type: MetadataType.cpu,
          name: 'server.cpu'.tr(),
          value: 'server.core_count'.plural(droplet['vcpus']),
        ),
        ServerMetadataEntity(
          type: MetadataType.ram,
          name: 'server.ram'.tr(),
          value: "${droplet['memory'].toString()} MB",
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          name: 'server.monthly_cost'.tr(),
          value: droplet['size']['price_monthly'].toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          name: 'server.location'.tr(),
          value:
              '${droplet['region']['name']} ${getEmojiFlag(droplet['region']['slug'].toString()) ?? ''}',
        ),
        ServerMetadataEntity(
          type: MetadataType.other,
          name: 'server.provider'.tr(),
          value: displayProviderName,
        ),
      ];
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return metadata;
  }

  @override
  Future<List<ServerBasicInfo>> getServers() async {
    List<ServerBasicInfo> servers = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/droplets');
      servers = response.data!['droplets'].map<ServerBasicInfo>(
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
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    print(servers);
    return servers;
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
  Future<APIGenericResult<List<ServerProviderLocation>>>
      getAvailableLocations() async {
    List<ServerProviderLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/regions',
      );

      locations = response.data!['regions']
          .map<ServerProviderLocation>(
            (final location) => ServerProviderLocation(
              title: location['slug'],
              description: location['name'],
              flag: getEmojiFlag(location['slug']),
              identifier: location['slug'],
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(data: locations, success: true);
  }

  @override
  Future<APIGenericResult<List<ServerType>>> getServerTypesByLocation({
    required final ServerProviderLocation location,
  }) async {
    final List<ServerType> types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/sizes',
      );
      final rawSizes = response.data!['sizes'];
      for (final rawSize in rawSizes) {
        for (final rawRegion in rawSize['regions']) {
          if (rawRegion.toString() == location.identifier) {
            types.add(
              ServerType(
                title: rawSize['description'],
                identifier: rawSize['slug'],
                ram: rawSize['memory'].toDouble(),
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
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(data: types, success: true);
  }

  @override
  Future<APIGenericResult<void>> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  }) async {
    /// TODO remove from provider interface
    const bool success = true;
    return APIGenericResult(success: success, data: null);
  }

  @override
  ProviderApiTokenValidation getApiTokenValidation() =>
      ProviderApiTokenValidation(
        regexp: RegExp(r'\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]'),
        length: 71,
      );
}
