import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/digital_ocean_server_info.dart';
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
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
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

  Future<GenericResult<DigitalOceanVolume?>> createVolume() async {
    DigitalOceanVolume? volume;
    Response? createVolumeResponse;
    final Dio client = await getClient();
    try {
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
      volume = DigitalOceanVolume.fromJson(createVolumeResponse.data['volume']);
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

  Future<GenericResult<List<DigitalOceanVolume>>> getVolumes({
    final String? status,
  }) async {
    final List<DigitalOceanVolume> volumes = [];

    Response? getVolumesResponse;
    final Dio client = await getClient();
    try {
      getVolumesResponse = await client.get(
        '/volumes',
        queryParameters: {
          'status': status,
        },
      );
      for (final volume in getVolumesResponse.data['volumes']) {
        volumes.add(DigitalOceanVolume.fromJson(volume));
      }
    } catch (e) {
      print(e);
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      data: volumes,
      success: true,
    );
  }

  Future<GenericResult<void>> deleteVolume(final String uuid) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$uuid');
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
      data: null,
      success: true,
    );
  }

  Future<GenericResult<bool>> attachVolume(
    final String name,
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
          'volume_name': name,
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

  Future<GenericResult<bool>> detachVolume(
    final String name,
    final int serverId,
  ) async {
    bool success = false;

    final Response detachVolumeResponse;
    final Dio client = await getClient();
    try {
      detachVolumeResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'detach',
          'volume_name': name,
          'droplet_id': serverId,
          'region': region,
        },
      );
      success =
          detachVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
      return GenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      data: success,
      success: true,
    );
  }

  Future<GenericResult<bool>> resizeVolume(
    final String name,
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
          'volume_name': name,
          'size_gigabytes': size.gibibyte,
          'region': region,
        },
      );
      success =
          resizeVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
      return GenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      data: success,
      success: true,
    );
  }

  Future<GenericResult<int?>> createServer({
    required final String dnsApiToken,
    required final String dnsProviderType,
    required final String serverApiToken,
    required final User rootUser,
    required final String base64Password,
    required final String databasePassword,
    required final String domainName,
    required final String hostName,
    required final String serverType,
  }) async {
    final String stagingAcme = StagingOptions.stagingAcme ? 'true' : 'false';

    int? dropletId;
    Response? serverCreateResponse;
    final Dio client = await getClient();
    try {
      final Map<String, Object> data = {
        'name': hostName,
        'size': serverType,
        'image': 'ubuntu-20-04-x64',
        'user_data': '#cloud-config\n'
            'runcmd:\n'
            '- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/testing/final-digital-ocean/nixos-infect | '
            "PROVIDER=$infectProviderName DNS_PROVIDER_TYPE=$dnsProviderType STAGING_ACME='$stagingAcme' DOMAIN='$domainName' "
            "LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$databasePassword "
            'API_TOKEN=$serverApiToken HOSTNAME=$hostName bash 2>&1 | tee /tmp/infect.log',
        'region': region!,
      };
      print('Decoded data: $data');

      serverCreateResponse = await client.post(
        '/droplets',
        data: data,
      );
      dropletId = serverCreateResponse.data['droplet']['id'];
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
      data: dropletId,
      success: true,
      code: serverCreateResponse.statusCode,
      message: serverCreateResponse.statusMessage,
    );
  }

  Future<GenericResult<void>> deleteServer(final int serverId) async {
    final Dio client = await getClient();
    try {
      await client.delete('/droplets/$serverId');
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
      servers = response.data['droplets'];
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

  Future<GenericResult<List<DigitalOceanLocation>>>
      getAvailableLocations() async {
    final List<DigitalOceanLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/regions',
      );

      for (final region in response.data!['regions']) {
        locations.add(DigitalOceanLocation.fromJson(region));
      }
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

  Future<GenericResult<List<DigitalOceanServerType>>>
      getAvailableServerTypes() async {
    final List<DigitalOceanServerType> types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/sizes',
      );
      for (final size in response.data!['sizes']) {
        types.add(DigitalOceanServerType.fromJson(size));
      }
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
