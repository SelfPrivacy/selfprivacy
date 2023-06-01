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
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/utils/extensions/string_extensions.dart';
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

  @override
  Future<APIGenericResult<bool>> isApiTokenValid(final String token) async {
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

  @override
  ProviderApiTokenValidation getApiTokenValidation() =>
      ProviderApiTokenValidation(
        regexp: RegExp(r'\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]'),
        length: 64,
      );

  @override
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

  @override
  Future<APIGenericResult<ServerVolume?>> createVolume() async {
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

  @override
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

    return APIGenericResult(
      data: success,
      success: true,
      code: attachVolumeResponse?.statusCode,
      message: attachVolumeResponse?.statusMessage,
    );
  }

  @override
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

  @override
  Future<APIGenericResult<ServerHostingDetails?>> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final String serverType,
    required final DnsProvider dnsProvider,
  }) async {
    final APIGenericResult<ServerVolume?> newVolumeResponse =
        await createVolume();

    if (!newVolumeResponse.success || newVolumeResponse.data == null) {
      return APIGenericResult(
        data: null,
        success: false,
        message: newVolumeResponse.message,
        code: newVolumeResponse.code,
      );
    }
    return createServerWithVolume(
      dnsApiToken: dnsApiToken,
      rootUser: rootUser,
      domainName: domainName,
      volume: newVolumeResponse.data!,
      serverType: serverType,
      dnsProvider: dnsProvider,
    );
  }

  Future<APIGenericResult<ServerHostingDetails?>> createServerWithVolume({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final ServerVolume volume,
    required final String serverType,
    required final DnsProvider dnsProvider,
  }) async {
    final Dio client = await getClient();

    final String dbPassword = StringGenerators.dbPassword();
    final int volumeId = volume.id;

    final String apiToken = StringGenerators.apiToken();
    final String hostname = getHostnameFromDomain(domainName);
    const String infectBranch = 'providers/hetzner';
    final String stagingAcme = StagingOptions.stagingAcme ? 'true' : 'false';
    final String base64Password =
        base64.encode(utf8.encode(rootUser.password ?? 'PASS'));
    final String dnsProviderType = dnsProviderToInfectName(dnsProvider);

    final String userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/$infectBranch/nixos-infect | DNS_PROVIDER_TYPE=$dnsProviderType STAGING_ACME='$stagingAcme' PROVIDER=$infectProviderName NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$hostname bash 2>&1 | tee /tmp/infect.log";

    Response? serverCreateResponse;
    ServerHostingDetails? serverDetails;
    DioError? hetznerError;
    bool success = false;

    try {
      final Map<String, Object> data = {
        'name': hostname,
        'server_type': serverType,
        'start_after_create': false,
        'image': 'ubuntu-20.04',
        'volumes': [volumeId],
        'networks': [],
        'user_data': userdataString,
        'labels': {},
        'automount': true,
        'location': region!,
      };
      print('Decoded data: $data');

      serverCreateResponse = await client.post(
        '/servers',
        data: data,
      );
      print(serverCreateResponse.data);
      serverDetails = ServerHostingDetails(
        id: serverCreateResponse.data['server']['id'],
        ip4: serverCreateResponse.data['server']['public_net']['ipv4']['ip'],
        createTime: DateTime.now(),
        volume: volume,
        apiToken: apiToken,
        provider: ServerProvider.hetzner,
      );
      success = true;
    } on DioError catch (e) {
      print(e);
      hetznerError = e;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    if (!success) {
      await Future.delayed(const Duration(seconds: 10));
      await deleteVolume(volume);
    }

    String? apiResultMessage = serverCreateResponse?.statusMessage;
    if (hetznerError != null &&
        hetznerError.response!.data['error']['code'] == 'uniqueness_error') {
      apiResultMessage = 'uniqueness_error';
    }

    return APIGenericResult(
      data: serverDetails,
      success: success && hetznerError == null,
      code: serverCreateResponse?.statusCode ??
          hetznerError?.response?.statusCode,
      message: apiResultMessage,
    );
  }

  @override
  Future<APIGenericResult<bool>> deleteServer({
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
      await client.post('/servers/${server.id}/actions/reset');
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
      await client.post('/servers/${server.id}/actions/poweron');
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return server.copyWith(startTime: DateTime.now());
  }

  Future<Map<String, dynamic>> requestRawMetrics(
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
    } finally {
      close(client);
    }

    return metrics;
  }

  List<TimeSeriesData> serializeTimeSeries(
    final Map<String, dynamic> json,
    final String type,
  ) {
    final List list = json['time_series'][type]['values'];
    return list
        .map((final el) => TimeSeriesData(el[0], double.parse(el[1])))
        .toList();
  }

  @override
  Future<ServerMetrics?> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  ) async {
    ServerMetrics? metrics;

    final Map<String, dynamic> rawCpuMetrics = await requestRawMetrics(
      serverId,
      start,
      end,
      'cpu',
    );
    final Map<String, dynamic> rawNetworkMetrics = await requestRawMetrics(
      serverId,
      start,
      end,
      'network',
    );

    if (rawNetworkMetrics.isEmpty || rawCpuMetrics.isEmpty) {
      return metrics;
    }

    metrics = ServerMetrics(
      cpu: serializeTimeSeries(
        rawCpuMetrics,
        'cpu',
      ),
      bandwidthIn: serializeTimeSeries(
        rawNetworkMetrics,
        'network.0.bandwidth.in',
      ),
      bandwidthOut: serializeTimeSeries(
        rawNetworkMetrics,
        'network.0.bandwidth.out',
      ),
      end: end,
      start: start,
      stepsInSecond: rawCpuMetrics['step'],
    );

    return metrics;
  }

  @override
  Future<List<ServerMetadataEntity>> getMetadata(final int serverId) async {
    List<ServerMetadataEntity> metadata = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/servers/$serverId');
      final hetznerInfo = HetznerServerInfo.fromJson(response.data!['server']);
      metadata = [
        ServerMetadataEntity(
          type: MetadataType.id,
          name: 'server.server_id'.tr(),
          value: hetznerInfo.id.toString(),
        ),
        ServerMetadataEntity(
          type: MetadataType.status,
          name: 'server.status'.tr(),
          value: hetznerInfo.status.toString().split('.')[1].capitalize(),
        ),
        ServerMetadataEntity(
          type: MetadataType.cpu,
          name: 'server.cpu'.tr(),
          value: 'server.core_count'.plural(hetznerInfo.serverType.cores),
        ),
        ServerMetadataEntity(
          type: MetadataType.ram,
          name: 'server.ram'.tr(),
          value: '${hetznerInfo.serverType.memory.toString()} GB',
        ),
        ServerMetadataEntity(
          type: MetadataType.cost,
          name: 'server.monthly_cost'.tr(),
          value: hetznerInfo.serverType.prices[1].monthly.toStringAsFixed(2),
        ),
        ServerMetadataEntity(
          type: MetadataType.location,
          name: 'server.location'.tr(),
          value:
              '${hetznerInfo.location.city}, ${hetznerInfo.location.country}',
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
      final Response response = await client.get('/servers');
      servers = response.data!['servers']
          .map<HetznerServerInfo>(
            (final e) => HetznerServerInfo.fromJson(e),
          )
          .toList()
          .where(
            (final server) => server.publicNet.ipv4 != null,
          )
          .map<ServerBasicInfo>(
            (final server) => ServerBasicInfo(
              id: server.id,
              name: server.name,
              ip: server.publicNet.ipv4.ip,
              reverseDns: server.publicNet.ipv4.reverseDns,
              created: server.created,
            ),
          )
          .toList();
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
  Future<APIGenericResult<List<ServerProviderLocation>>>
      getAvailableLocations() async {
    List<ServerProviderLocation> locations = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/locations',
      );

      locations = response.data!['locations']
          .map<ServerProviderLocation>(
            (final location) => ServerProviderLocation(
              title: location['city'],
              description: location['description'],
              flag: getEmojiFlag(location['country']),
              identifier: location['name'],
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      return APIGenericResult(
        success: false,
        data: [],
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(success: true, data: locations);
  }

  @override
  Future<APIGenericResult<List<ServerType>>> getServerTypesByLocation({
    required final ServerProviderLocation location,
  }) async {
    final List<ServerType> types = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/server_types',
      );
      final rawTypes = response.data!['server_types'];
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
    final Dio client = await getClient();
    try {
      await client.post(
        '/servers/${serverDetails.id}/actions/change_dns_ptr',
        data: {
          'ip': serverDetails.ip4,
          'dns_ptr': domain.domainName,
        },
      );
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

    return APIGenericResult(success: true, data: null);
  }
}
