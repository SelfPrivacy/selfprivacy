import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/staging_options.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/utils/network_utils.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class HetznerApi extends ServerProviderApi with VolumeProviderApi {
  HetznerApi({
    this.region,
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
  String get rootAddress => 'https://api.hetzner.cloud/v1';

  @override
  String get infectProviderName => 'hetzner';

  @override
  String get displayProviderName => 'Hetzner';

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String message = '';
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

  ProviderApiTokenValidation getApiTokenValidation() =>
      ProviderApiTokenValidation(
        regexp: RegExp(r'\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]'),
        length: 64,
      );

  Future<Price?> getPricePerGb() async {
    double? price;

    final Response pricingResponse;
    final Dio client = await getClient();
    try {
      pricingResponse = await client.get('/pricing');

      final volume = pricingResponse.data['pricing']['volume'];
      final volumePrice = volume['price_per_gb_month']['gross'];
      price = double.parse(volumePrice);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return price == null
        ? null
        : Price(
            value: price,
            currency: 'EUR',
          );
  }

  Future<GenericResult<ServerVolume?>> createVolume() async {
    ServerVolume? volume;

    Response? createVolumeResponse;
    final Dio client = await getClient();
    try {
      createVolumeResponse = await client.post(
        '/volumes',
        data: {
          'size': 10,
          'name': StringGenerators.storageName(),
          'labels': {'labelkey': 'value'},
          'location': region,
          'automount': false,
          'format': 'ext4'
        },
      );
      final volumeId = createVolumeResponse.data['volume']['id'];
      final volumeSize = createVolumeResponse.data['volume']['size'];
      final volumeServer = createVolumeResponse.data['volume']['server'];
      final volumeName = createVolumeResponse.data['volume']['name'];
      final volumeDevice = createVolumeResponse.data['volume']['linux_device'];
      volume = ServerVolume(
        id: volumeId,
        name: volumeName,
        sizeByte: volumeSize,
        serverId: volumeServer,
        linuxDevice: volumeDevice,
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

    final Response getVolumesResonse;
    final Dio client = await getClient();
    try {
      getVolumesResonse = await client.get(
        '/volumes',
        queryParameters: {
          'status': status,
        },
      );
      final List<dynamic> rawVolumes = getVolumesResonse.data['volumes'];
      for (final rawVolume in rawVolumes) {
        final int volumeId = rawVolume['id'];
        final int volumeSize = rawVolume['size'] * 1024 * 1024 * 1024;
        final volumeServer = rawVolume['server'];
        final String volumeName = rawVolume['name'];
        final volumeDevice = rawVolume['linux_device'];
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
      print(e);
    } finally {
      client.close();
    }

    return volumes;
  }

  Future<ServerVolume?> getVolume(
    final String volumeId,
  ) async {
    ServerVolume? volume;

    final Response getVolumeResponse;
    final Dio client = await getClient();
    try {
      getVolumeResponse = await client.get('/volumes/$volumeId');
      final int responseVolumeId = getVolumeResponse.data['volume']['id'];
      final int volumeSize = getVolumeResponse.data['volume']['size'];
      final int volumeServer = getVolumeResponse.data['volume']['server'];
      final String volumeName = getVolumeResponse.data['volume']['name'];
      final volumeDevice = getVolumeResponse.data['volume']['linux_device'];
      volume = ServerVolume(
        id: responseVolumeId,
        name: volumeName,
        sizeByte: volumeSize,
        serverId: volumeServer,
        linuxDevice: volumeDevice,
      );
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volume;
  }

  Future<void> deleteVolume(final ServerVolume volume) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/${volume.id}');
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

  Future<bool> detachVolume(final ServerVolume volume) async {
    bool success = false;

    final Response detachVolumeResponse;
    final Dio client = await getClient();
    try {
      detachVolumeResponse = await client.post(
        '/volumes/${volume.id}/actions/detach',
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
        '/volumes/${volume.id}/actions/resize',
        data: {
          'size': size.gibibyte,
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

  Future<GenericResult> createServer({
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
  }) async {
    final String stagingAcme = StagingOptions.stagingAcme ? 'true' : 'false';
    Response? serverCreateResponse;
    DioError? hetznerError;
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
            '- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/providers/hetzner/nixos-infect | '
            "STAGING_ACME='$stagingAcme' PROVIDER=$infectProviderName DNS_PROVIDER_TYPE=$dnsProviderType "
            "NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' "
            'CF_TOKEN=$dnsApiToken DB_PASSWORD=$databasePassword API_TOKEN=$serverApiToken HOSTNAME=$hostName bash 2>&1 | '
            'tee /tmp/infect.log',
        'labels': {},
        'automount': true,
        'location': region!,
      };
      print('Decoded data: $data');

      serverCreateResponse = await client.post('/servers', data: data);
      success = true;
    } on DioError catch (e) {
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
      data: serverCreateResponse?.data,
      success: success && hetznerError == null,
      code: serverCreateResponse?.statusCode ??
          hetznerError?.response?.statusCode,
      message: apiResultMessage,
    );
  }

  Future<GenericResult<bool>> deleteServer({
    required final String domainName,
  }) async {
    final Dio client = await getClient();
    try {
      final String hostname = getHostnameFromDomain(domainName);

      final Response serversReponse = await client.get('/servers');
      final List servers = serversReponse.data['servers'];
      final Map server =
          servers.firstWhere((final el) => el['name'] == hostname);
      final List volumes = server['volumes'];
      final List<Future> laterFutures = <Future>[];

      for (final volumeId in volumes) {
        await client.post('/volumes/$volumeId/actions/detach');
      }
      await Future.delayed(const Duration(seconds: 10));

      for (final volumeId in volumes) {
        laterFutures.add(client.delete('/volumes/$volumeId'));
      }
      laterFutures.add(client.delete('/servers/${server['id']}'));

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

    return GenericResult(
      success: true,
      data: true,
    );
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

    return GenericResult(
      success: true,
      data: null,
    );
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

    return GenericResult(
      success: true,
      data: null,
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
        'type': type
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

  Future<GenericResult<List>> getAvailableLocations() async {
    List<ServerProviderLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/locations',
      );

      locations = response.data!['locations'];
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

  Future<GenericResult<List>> getAvailableServerTypes() async {
    List types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/server_types',
      );
      types = response.data!['server_types'];
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
}
