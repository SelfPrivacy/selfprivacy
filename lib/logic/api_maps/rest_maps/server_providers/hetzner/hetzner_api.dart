import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/api_maps/tls_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class HetznerApi extends RestApiMap {
  HetznerApi({
    this.token = '',
    this.hasLogger = true,
    this.isWithToken = true,
  }) : assert(isWithToken ? token.isNotEmpty : true);

  @override
  bool hasLogger;
  @override
  bool isWithToken;

  final String token;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      assert(token.isNotEmpty);
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String get rootAddress => 'https://api.hetzner.cloud/v1';
  String get infectProviderName => 'HETZNER';

  Future<GenericResult<List<HetznerServerInfo>>> getServers() async {
    List<HetznerServerInfo> servers = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/servers');
      servers = response.data!['servers']
          .map<HetznerServerInfo>(
            (final e) => HetznerServerInfo.fromJson(e),
          )
          .toList();
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

    return GenericResult(data: servers, success: true);
  }

  Future<GenericResult<HetznerServerInfo?>> createServer({
    required final String dnsApiToken,
    required final String dnsProviderType,
    required final String serverApiToken,
    required final User rootUser,
    required final String base64Password,
    required final String databasePassword,
    required final String domainName,
    required final String hostName,
    required final int volumeId,
    required final String serverType,
    required final String? customSshKey,
    required final String region,
  }) async {
    final String stagingAcme = TlsOptions.stagingAcme ? 'true' : 'false';
    Response? serverCreateResponse;
    HetznerServerInfo? serverInfo;
    DioException? hetznerError;
    bool success = false;

    final Dio client = await getClient();
    try {
      final Map<String, Object> data = {
        'name': hostName,
        'server_type': serverType,
        'start_after_create': false,
        'image': 'ubuntu-20.04',
        'volumes': [volumeId],
        'networks': [],
        'user_data': '#cloud-config\n'
            'runcmd:\n'
            '- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | '
            "API_TOKEN=$serverApiToken ENCODED_PASSWORD='$base64Password' "
            "DNS_PROVIDER_TOKEN=$dnsApiToken DNS_PROVIDER_TYPE=$dnsProviderType DOMAIN='$domainName'  "
            "HOSTNAME=$hostName LUSER='${rootUser.login}' PROVIDER=$infectProviderName STAGING_ACME='$stagingAcme' "
            "${customSshKey != null ? "SSH_AUTHORIZED_KEY='$customSshKey'" : ""} "
            'bash 2>&1 | tee /root/nixos-infect.log',
        'labels': {},
        'automount': true,
        'location': region,
      };
      print('Decoded data: $data');

      serverCreateResponse = await client.post('/servers', data: data);
      serverInfo = HetznerServerInfo.fromJson(
        serverCreateResponse.data['server'],
      );
      success = true;
    } on DioException catch (e) {
      print(e);
      hetznerError = e;
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    String? apiResultMessage = serverCreateResponse?.statusMessage;
    if (hetznerError != null &&
        hetznerError.response!.data['error']['code'] == 'uniqueness_error') {
      apiResultMessage = 'uniqueness_error';
    }

    return GenericResult(
      data: serverInfo,
      success: success && hetznerError == null,
      code: serverCreateResponse?.statusCode ??
          hetznerError?.response?.statusCode,
      message: apiResultMessage,
    );
  }

  Future<GenericResult<void>> createReverseDns({
    required final int serverId,
    required final String ip4,
    required final String dnsPtr,
  }) async {
    final Dio client = await getClient();
    try {
      await client.post(
        '/servers/$serverId/actions/change_dns_ptr',
        data: {
          'ip': ip4,
          'dns_ptr': dnsPtr,
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

  Future<GenericResult<void>> deleteServer({
    required final int serverId,
  }) async {
    final Dio client = await getClient();
    try {
      await client.delete('/servers/$serverId');
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

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/servers',
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

    message = response.statusMessage;

    if (response.statusCode == HttpStatus.ok) {
      isValid = true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      message = 'initializing.provider_bad_key_error';
      isValid = false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }

    return GenericResult(
      data: isValid,
      success: true,
      message: message,
    );
  }

  Future<GenericResult<List<HetznerLocation>>> getAvailableLocations() async {
    final List<HetznerLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/locations');
      for (final location in response.data!['locations']) {
        locations.add(HetznerLocation.fromJson(location));
      }
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

    return GenericResult(success: true, data: locations);
  }

  Future<GenericResult<List<HetznerServerTypeInfo>>>
      getAvailableServerTypes() async {
    final List<HetznerServerTypeInfo> types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/server_types',
      );
      for (final type in response.data!['server_types']) {
        types.add(HetznerServerTypeInfo.fromJson(type));
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

  Future<GenericResult<void>> powerOn(final int serverId) async {
    final Dio client = await getClient();
    try {
      await client.post('/servers/$serverId/actions/poweron');
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
      await client.post('/servers/$serverId/actions/reset');
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

  Future<GenericResult<HetznerPricing?>> getPricing({
    required final String region,
  }) async {
    HetznerPricing? pricing;

    final Response pricingResponse;
    final Dio client = await getClient();
    try {
      pricingResponse = await client.get('/pricing');

      final volume = pricingResponse.data['pricing']['volume'];
      final volumePrice = volume['price_per_gb_month']['gross'];
      final primaryIps = pricingResponse.data['pricing']['primary_ips'];
      String? ipPrice;
      for (final primaryIp in primaryIps) {
        if (primaryIp['type'] == 'ipv4') {
          for (final primaryIpPrice in primaryIp['prices']) {
            if (primaryIpPrice['location'] == region) {
              ipPrice = primaryIpPrice['price_monthly']['gross'];
            }
          }
        }
      }
      pricing = HetznerPricing(
        region,
        double.parse(volumePrice),
        double.parse(ipPrice!),
      );
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: pricing,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(success: true, data: pricing);
  }

  Future<GenericResult<List<HetznerVolume>>> getVolumes() async {
    final List<HetznerVolume> volumes = [];

    Response? getVolumesResponse;
    final Dio client = await getClient();
    try {
      getVolumesResponse = await client.get('/volumes');
      for (final volume in getVolumesResponse.data['volumes']) {
        volumes.add(HetznerVolume.fromJson(volume));
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
      code: getVolumesResponse.statusCode,
      message: getVolumesResponse.statusMessage,
    );
  }

  Future<GenericResult<HetznerVolume?>> createVolume({
    required final int gb,
    required final String region,
  }) async {
    Response? createVolumeResponse;
    HetznerVolume? volume;
    final Dio client = await getClient();
    try {
      createVolumeResponse = await client.post(
        '/volumes',
        data: {
          'size': gb,
          'name': StringGenerators.storageName(),
          'labels': {'labelkey': 'value'},
          'location': region,
          'automount': false,
          'format': 'ext4',
        },
      );
      volume = HetznerVolume.fromJson(createVolumeResponse.data['volume']);
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

  Future<GenericResult<bool>> deleteVolume(final int volumeId) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$volumeId');
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      success: true,
      data: true,
    );
  }

  Future<GenericResult<HetznerVolume?>> getVolume(
    final String volumeId,
  ) async {
    HetznerVolume? volume;

    final Response getVolumeResponse;
    final Dio client = await getClient();
    try {
      getVolumeResponse = await client.get('/volumes/$volumeId');
      volume = HetznerVolume.fromJson(getVolumeResponse.data['volume']);
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
    );
  }

  Future<GenericResult<bool>> detachVolume(final int volumeId) async {
    bool success = false;

    final Response detachVolumeResponse;
    final Dio client = await getClient();
    try {
      detachVolumeResponse = await client.post(
        '/volumes/$volumeId/actions/detach',
      );
      success =
          detachVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: false,
        message: e.toString(),
      );
    } finally {
      client.close();
    }

    return GenericResult(
      success: false,
      data: success,
    );
  }

  Future<GenericResult<bool>> attachVolume(
    final HetznerVolume volume,
    final int serverId,
  ) async {
    bool success = false;

    Response? attachVolumeResponse;
    final Dio client = await getClient();
    try {
      attachVolumeResponse = await client.post(
        '/volumes/${volume.id}/actions/attach',
        data: {
          'automount': true,
          'server': serverId,
        },
      );
      success =
          attachVolumeResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return GenericResult(
      data: success,
      success: true,
      code: attachVolumeResponse?.statusCode,
      message: attachVolumeResponse?.statusMessage,
    );
  }

  Future<GenericResult<bool>> resizeVolume(
    final HetznerVolume volume,
    final DiskSize size,
  ) async {
    bool success = false;

    final Response resizeVolumeResponse;
    final Dio client = await getClient();
    try {
      resizeVolumeResponse = await client.post(
        '/volumes/${volume.id}/actions/resize',
        data: {
          'size': size.gibibyte.floor(),
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

  Future<GenericResult<Map<String, dynamic>>> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
    final String type,
  ) async {
    Map<String, dynamic> metrics = {};
    final Dio client = await getClient();
    try {
      final Map<String, dynamic> queryParameters = {
        'start': start.toUtc().toIso8601String(),
        'end': end.toUtc().toIso8601String(),
        'type': type,
      };
      final Response res = await client.get(
        '/servers/$serverId/metrics',
        queryParameters: queryParameters,
      );
      metrics = res.data['metrics'];
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: {},
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(data: metrics, success: true);
  }
}
