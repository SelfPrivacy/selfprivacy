// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/digital_ocean_server_info.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class DigitalOceanApi extends RestApiMap {
  DigitalOceanApi({
    this.token = '',
    this.hasLogger = true,
    this.isWithToken = true,
  }) : assert(
         !isWithToken || token.isNotEmpty,
         'DigitalOcean API requires a token to be set when isWithToken is true.',
       );

  @override
  bool hasLogger;
  @override
  bool isWithToken;

  final String token;

  static final logger = const AppLogger(name: 'digital_ocean_api_map').log;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      assert(
        token.isNotEmpty,
        'DigitalOcean API requires a token to be set when isWithToken is true.',
      );
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String get rootAddress => 'https://api.digitalocean.com/v2';
  String get infectProviderName => 'DIGITALOCEAN';

  Future<GenericResult<List>> getServers() async {
    List servers = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/droplets');
      servers = response.data['droplets'];
    } catch (e) {
      logger('Error while fetching droplets: $e', error: e);
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
    required final String? customSshKey,
    required final String region,
  }) async {
    final String stagingAcme = TlsOptions.stagingAcme ? 'true' : 'false';

    int? dropletId;
    Response? serverCreateResponse;
    final Dio client = await getClient();
    try {
      final Map<String, Object> data = {
        'name': hostName,
        'size': serverType,
        'image': 'ubuntu-24-04-x64',
        'user_data':
            '#cloud-config\n'
            'runcmd:\n'
            '- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | '
            "API_TOKEN=$serverApiToken ENCODED_PASSWORD='$base64Password' "
            "DNS_PROVIDER_TOKEN=$dnsApiToken DNS_PROVIDER_TYPE=$dnsProviderType DOMAIN='$domainName' "
            "HOSTNAME=$hostName LUSER='${rootUser.login}' PROVIDER=$infectProviderName STAGING_ACME='$stagingAcme' "
            "${customSshKey != null ? "SSH_AUTHORIZED_KEY='$customSshKey'" : ""} "
            'bash 2>&1 | tee /root/nixos-infect.log',
        'region': region,
      };
      logger('Decoded data: $data');
      serverCreateResponse = await client.post('/droplets', data: data);
      dropletId = serverCreateResponse.data['droplet']['id'];
    } catch (e) {
      logger('Error while creating droplet: $e', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
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
      logger('Error while deleting droplet: $e', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/account',
        options: Options(
          followRedirects: false,
          validateStatus:
              (final status) =>
                  status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      logger('Error while validating API token: $e', error: e);
      isValid = false;
      message = e.toString();
    } finally {
      close(client);
    }

    if (response == null) {
      return GenericResult(data: isValid, success: false, message: message);
    }

    message = response.statusMessage;

    if (response.statusCode == HttpStatus.ok) {
      isValid = true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      message = 'initializing.provider_bad_key_error';
      isValid = false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }

    return GenericResult(data: isValid, success: true, message: message);
  }

  Future<GenericResult<List<DigitalOceanLocation>>>
  getAvailableLocations() async {
    final List<DigitalOceanLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/regions');

      for (final region in response.data!['regions']) {
        locations.add(DigitalOceanLocation.fromJson(region));
      }
    } catch (e) {
      logger('Error while fetching regions: $e', error: e);
      return GenericResult(data: [], success: false, message: e.toString());
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
      final Response response = await client.get('/sizes');
      for (final size in response.data!['sizes']) {
        types.add(DigitalOceanServerType.fromJson(size));
      }
    } catch (e) {
      logger('Error while fetching sizes: $e', error: e);
      return GenericResult(data: [], success: false, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(data: types, success: true);
  }

  Future<GenericResult<void>> powerOn(final int serverId) async {
    final Dio client = await getClient();
    try {
      await client.post(
        '/droplets/$serverId/actions',
        data: {'type': 'power_on'},
      );
    } catch (e) {
      logger('Error while powering on droplet: $e', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
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
        data: {'type': 'reboot'},
      );
    } catch (e) {
      logger('Error while rebooting droplet: $e', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
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
        queryParameters: {'status': status},
      );
      for (final volume in getVolumesResponse.data['volumes']) {
        volumes.add(DigitalOceanVolume.fromJson(volume));
      }
    } catch (e) {
      logger('Error while fetching volumes: $e', error: e);
      return GenericResult(data: [], success: false, message: e.toString());
    } finally {
      client.close();
    }

    return GenericResult(data: volumes, success: true);
  }

  Future<GenericResult<DigitalOceanVolume?>> createVolume({
    required final int gb,
    required final String region,
  }) async {
    DigitalOceanVolume? volume;
    Response? createVolumeResponse;
    final Dio client = await getClient();
    try {
      await Future.delayed(const Duration(seconds: 6));

      createVolumeResponse = await client.post(
        '/volumes',
        data: {
          'size_gigabytes': gb,
          'name': 'volume${StringGenerators.storageName()}',
          'labels': {'labelkey': 'value'},
          'region': region,
          'filesystem_type': 'ext4',
        },
      );
      volume = DigitalOceanVolume.fromJson(createVolumeResponse.data['volume']);
    } catch (e) {
      logger('Error while creating volume: $e', error: e);
      return GenericResult(data: null, success: false, message: e.toString());
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

  Future<GenericResult<bool>> attachVolume({
    required final String name,
    required final int serverId,
    required final String region,
  }) async {
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
      logger('Error while attaching volume: $e', error: e);
      return GenericResult(data: false, success: false, message: e.toString());
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

  Future<GenericResult<bool>> detachVolume({
    required final String name,
    required final int serverId,
    required final String region,
  }) async {
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
      logger('Error while detaching volume: $e', error: e);
      return GenericResult(data: false, success: false, message: e.toString());
    } finally {
      client.close();
    }

    return GenericResult(data: success, success: true);
  }

  Future<GenericResult<void>> deleteVolume(final String uuid) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$uuid');
    } catch (e) {
      logger('Error while deleting volume: $e', error: e);
      return GenericResult(data: null, success: false, message: e.toString());
    } finally {
      client.close();
    }

    return GenericResult(data: null, success: true);
  }

  Future<GenericResult<bool>> resizeVolume({
    required final String uuid,
    required final int gb,
    required final String region,
  }) async {
    bool success = false;

    final Response resizeVolumeResponse;
    final Dio client = await getClient();
    try {
      resizeVolumeResponse = await client.post(
        '/volumes/$uuid/actions',
        data: {'type': 'resize', 'size_gigabytes': gb, 'region': region},
      );
      success =
          resizeVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      logger('Error while resizing volume: $e', error: e);
      return GenericResult(data: false, success: false, message: e.toString());
    } finally {
      client.close();
    }

    return GenericResult(data: success, success: true);
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
      logger('Error while fetching CPU metrics: $e', error: e);
      return GenericResult(success: false, data: [], message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: metrics);
  }

  Future<GenericResult<List>> getMetricsBandwidth({
    required final int serverId,
    required final DateTime start,
    required final DateTime end,
    required final bool isInbound,
  }) async {
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
      logger('Error while fetching bandwidth metrics: $e', error: e);
      return GenericResult(success: false, data: [], message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: metrics);
  }
}
