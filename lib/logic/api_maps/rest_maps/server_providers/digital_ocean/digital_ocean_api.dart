import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/utils/network_utils.dart';
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

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
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
      return GenericResult(
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

    return GenericResult(
      data: isValid,
      success: true,
      message: response.statusMessage,
    );
  }

  /// Hardcoded on their documentation and there is no pricing API at all
  /// Probably we should scrap the doc page manually
  Future<Price?> getPricePerGb() async => Price(
        value: 0.10,
        currency: 'USD',
      );

  Future<GenericResult<ServerVolume?>> createVolume() async {
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
      return GenericResult(
        data: null,
        success: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      data: volume,
      success: true,
      code: createVolumeResponse.statusCode,
      message: createVolumeResponse.statusMessage,
    );
  }

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

  Future<GenericResult<bool>> attachVolume(
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
      return GenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(
      data: success,
      success: true,
      code: attachVolumeResponse.statusCode,
      message: attachVolumeResponse.statusMessage,
    );
  }

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

  Future<GenericResult<ServerHostingDetails?>> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final String serverType,
    required final DnsProviderType dnsProvider,
  }) async {
    ServerHostingDetails? serverDetails;

    final String dbPassword = StringGenerators.dbPassword();
    final String apiToken = StringGenerators.apiToken();

    final String base64Password =
        base64.encode(utf8.encode(rootUser.password ?? 'PASS'));

    final String formattedHostname = getHostnameFromDomain(domainName);
    const String infectBranch = 'testing/digital-ocean';
    final String stagingAcme = StagingOptions.stagingAcme ? 'true' : 'false';
    final String dnsProviderType = dnsProviderToInfectName(dnsProvider);

    final String userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/$infectBranch/nixos-infect | PROVIDER=$infectProviderName DNS_PROVIDER_TYPE=$dnsProviderType STAGING_ACME='$stagingAcme' DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$formattedHostname bash 2>&1 | tee /tmp/infect.log";
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
          provider: ServerProviderType.digitalOcean,
        );
      }
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(
      data: serverDetails,
      success: true,
      code: serverCreateResponse.statusCode,
      message: serverCreateResponse.statusMessage,
    );
  }

  @override
  Future<GenericResult<bool>> deleteServer({
    required final String domainName,
  }) async {
    final Dio client = await getClient();

    final String hostname = getHostnameFromDomain(domainName);
    final servers = await getServers();
    final ServerBasicInfo serverToRemove;
    try {
      serverToRemove = servers.firstWhere(
        (final el) => el.name == hostname,
      );
    } catch (e) {
      print(e);
      return GenericResult(
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
      return GenericResult(
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
      laterFutures.add(client.delete('/droplets/${serverToRemove.id}'));
      await Future.wait(laterFutures);
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: true);
  }

  Future<GenericResult<void>> restart(final int serverId) async {
    final Dio client = await getClient();
    try {
      await client.post(
        '/droplets/$serverId/actions',
        data: {
          'type': 'reboot',
        },
      );
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<void>> powerOn(final int serverId) async {
    final Dio client = await getClient();
    try {
      await client.post(
        '/droplets/$serverId/actions',
        data: {
          'type': 'power_on',
        },
      );
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List>> getMetricsCpu(
    final int serverId,
    final DateTime start,
    final DateTime end,
  ) async {
    List metrics = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/monitoring/metrics/droplet/cpu',
        queryParameters: {
          'start': '${(start.microsecondsSinceEpoch / 1000000).round()}',
          'end': '${(end.microsecondsSinceEpoch / 1000000).round()}',
          'host_id': '$serverId',
        },
      );
      metrics = response.data['data']['result'];
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: [],
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: metrics);
  }

  Future<GenericResult<List>> getMetricsBandwidth(
    final int serverId,
    final DateTime start,
    final DateTime end,
    final bool isInbound,
  ) async {
    List metrics = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/monitoring/metrics/droplet/bandwidth',
        queryParameters: {
          'start': '${(start.microsecondsSinceEpoch / 1000000).round()}',
          'end': '${(end.microsecondsSinceEpoch / 1000000).round()}',
          'host_id': '$serverId',
          'interface': 'public',
          'direction': isInbound ? 'inbound' : 'outbound',
        },
      );
      metrics = response.data['data']['result'][0]['values'];
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: [],
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: metrics);
  }

  Future<GenericResult<List>> getServers() async {
    List servers = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/droplets');
      servers = response.data;
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: servers,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: servers);
  }

  Future<GenericResult<List>> getAvailableLocations() async {
    List<ServerProviderLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/regions',
      );

      locations = response.data!['regions'];
    } catch (e) {
      print(e);
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(data: locations, success: true);
  }

  Future<GenericResult<List>> getAvailableServerTypes() async {
    List types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/sizes',
      );
      types = response.data!['sizes'];
    } catch (e) {
      print(e);
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(data: types, success: true);
  }
}
