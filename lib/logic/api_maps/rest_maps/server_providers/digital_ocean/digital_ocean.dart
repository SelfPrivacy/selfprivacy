import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class DigitalOceanApi extends ServerProviderApi with VolumeProviderApi {
  DigitalOceanApi({
    required this.region,
    this.hasLogger = false,
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
  String rootAddress = 'https://api.digitalocean.com/v2';

  @override
  Future<bool> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/account',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      print(e);
      isValid = false;
    } finally {
      close(client);
    }

    if (response != null) {
      if (response.statusCode == HttpStatus.ok) {
        isValid = true;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        isValid = false;
      } else {
        throw Exception('code: ${response.statusCode}');
      }
    }

    return isValid;
  }

  /// Hardcoded on their documentation and there is no pricing API at all
  /// Probably we should scrap the doc page manually
  @override
  Future<Price?> getPricePerGb() async => Price(
        value: 0.10,
        currency: 'USD',
      );

  @override
  Future<ServerVolume?> createVolume() async {
    ServerVolume? volume;

    final Response dbCreateResponse;
    final Dio client = await getClient();
    try {
      final List<ServerVolume> volumes = await getVolumes();
      await Future.delayed(const Duration(seconds: 6));

      dbCreateResponse = await client.post(
        '/volumes',
        data: {
          'size_gigabytes': 10,
          'name': 'volume${StringGenerators.dbStorageName()}',
          'labels': {'labelkey': 'value'},
          'region': region,
          'filesystem_type': 'ext4',
        },
      );
      final dbId = dbCreateResponse.data['volume']['id'];
      final dbSize = dbCreateResponse.data['volume']['size_gigabytes'];
      final dbName = dbCreateResponse.data['volume']['name'];
      volume = ServerVolume(
        id: volumes.length,
        name: dbName,
        sizeByte: dbSize,
        serverId: null,
        linuxDevice: null,
        uuid: dbId,
      );
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volume;
  }

  @override
  Future<List<ServerVolume>> getVolumes({final String? status}) async {
    final List<ServerVolume> volumes = [];

    final Response dbGetResponse;
    final Dio client = await getClient();
    try {
      dbGetResponse = await client.get(
        '/volumes',
        queryParameters: {
          'status': status,
        },
      );
      final List<dynamic> rawVolumes = dbGetResponse.data['volumes'];
      int id = 0;
      for (final rawVolume in rawVolumes) {
        final dbId = rawVolume['id'];
        final int dbSize = rawVolume['size_gigabytes'] * 1024 * 1024 * 1024;
        final dbDropletIds = rawVolume['droplet_ids'];
        final String dbName = rawVolume['name'];
        final volume = ServerVolume(
          id: id++,
          name: dbName,
          sizeByte: dbSize,
          serverId: dbDropletIds.isNotEmpty ? dbDropletIds[0] : null,
          linuxDevice: null,
          uuid: dbId,
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
    ServerVolume? neededVolume;

    final List<ServerVolume> volumes = await getVolumes();

    for (final volume in volumes) {
      if (volume.uuid == volumeUuid) {
        neededVolume = volume;
      }
    }

    return neededVolume;
  }

  @override
  Future<void> deleteVolume(final ServerVolume volume) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$volume.uuid');
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<bool> attachVolume(
    final ServerVolume volume,
    final int serverId,
  ) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'attach',
          'volume_name': volume.name,
          'region': region,
          'droplet_id': serverId,
        },
      );
      success = dbPostResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return success;
  }

  @override
  Future<bool> detachVolume(final ServerVolume volume) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'detach',
          'volume_name': volume.name,
          'droplet_id': volume.serverId,
          'region': region,
        },
      );
      success =
          dbPostResponse.data['action']['status'].toString() == 'completed';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  @override
  Future<bool> resizeVolume(final ServerVolume volume, final int sizeGb) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post(
        '/volumes/actions',
        data: {
          'type': 'resize',
          'volume_name': volume.name,
          'size_gigabytes': sizeGb,
          'region': region,
        },
      );
      success =
          dbPostResponse.data['action']['status'].toString() == 'completed';
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
  Future<ServerHostingDetails?> createServer({
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

    final String userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=digital-ocean NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$formattedHostname bash 2>&1 | tee /tmp/infect.log";
    print(userdataString);

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

      final Response serverCreateResponse = await client.post(
        '/droplets',
        data: data,
      );

      final int serverId = serverCreateResponse.data['droplet']['id'];
      final ServerVolume? newVolume = await createVolume();
      final bool attachedVolume = await attachVolume(newVolume!, serverId);

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
    } finally {
      close(client);
    }

    return serverDetails;
  }

  @override
  Future<void> deleteServer({
    required final String domainName,
  }) async {
    final Dio client = await getClient();

    final ServerBasicInfo serverToRemove = (await getServers()).firstWhere(
      (final el) => el.name == domainName,
    );
    final ServerVolume volumeToRemove = (await getVolumes()).firstWhere(
      (final el) => el.serverId == serverToRemove.id,
    );
    final List<Future> laterFutures = <Future>[];

    await detachVolume(volumeToRemove);
    await Future.delayed(const Duration(seconds: 10));

    try {
      laterFutures.add(deleteVolume(volumeToRemove));
      laterFutures.add(client.delete('/droplets/$serverToRemove.id'));
      await Future.wait(laterFutures);
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
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

  Future<Map<String, dynamic>> getMetrics(
    final DateTime start,
    final DateTime end,
    final String type,
  ) async {
    final ServerHostingDetails? hetznerServer =
        getIt<ApiConfigModel>().serverDetails;

    Map<String, dynamic> metrics = {};
    final Dio client = await getClient();
    try {
      final Map<String, dynamic> queryParameters = {
        'start': start.toUtc().toIso8601String(),
        'end': end.toUtc().toIso8601String(),
        'type': type
      };
      final Response res = await client.get(
        '/servers/${hetznerServer!.id}/metrics',
        queryParameters: queryParameters,
      );
      metrics = res.data;
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return metrics;
  }

  Future<HetznerServerInfo> getInfo() async {
    final ServerHostingDetails? hetznerServer =
        getIt<ApiConfigModel>().serverDetails;
    final Dio client = await getClient();
    final Response response = await client.get('/servers/${hetznerServer!.id}');
    close(client);

    return HetznerServerInfo.fromJson(response.data!['server']);
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

    switch (query.toLowerCase().substring(0, 2)) {
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
  Future<List<ServerProviderLocation>> getAvailableLocations() async {
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
    } finally {
      close(client);
    }

    return locations;
  }

  @override
  Future<List<ServerType>> getServerTypesByLocation({
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
    } finally {
      close(client);
    }

    return types;
  }

  @override
  Future<void> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  }) async {
    /// TODO remove from provider interface
  }

  @override
  ProviderApiTokenValidation getApiTokenValidation() =>
      ProviderApiTokenValidation(
        regexp: RegExp(r'\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]'),
        length: 71,
      );
}
