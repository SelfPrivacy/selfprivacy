import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class HetznerApi extends ServerProviderApi with VolumeProviderApi {
  HetznerApi({final this.hasLogger = false, final this.isWithToken = true});
  @override
  bool hasLogger;
  @override
  bool isWithToken;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      final String? token = getIt<ApiConfigModel>().hetznerKey;
      assert(token != null);
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String rootAddress = 'https://api.hetzner.cloud/v1';

  @override
  Future<bool> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/servers',
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

  @override
  RegExp getApiTokenValidation() =>
      RegExp(r'\s+|[-!$%^&*()@+|~=`{}\[\]:<>?,.\/]');

  @override
  Future<ServerVolume?> createVolume() async {
    ServerVolume? volume;

    final Response dbCreateResponse;
    final Dio client = await getClient();
    try {
      dbCreateResponse = await client.post(
        '/volumes',
        data: {
          'size': 10,
          'name': StringGenerators.dbStorageName(),
          'labels': {'labelkey': 'value'},
          'location': 'fsn1',
          'automount': false,
          'format': 'ext4'
        },
      );
      final dbId = dbCreateResponse.data['volume']['id'];
      final dbSize = dbCreateResponse.data['volume']['size'];
      final dbServer = dbCreateResponse.data['volume']['server'];
      final dbName = dbCreateResponse.data['volume']['name'];
      volume = ServerVolume(
        id: dbId,
        name: dbName,
        sizeByte: dbSize,
        serverId: dbServer,
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
      for (final rawVolume in rawVolumes) {
        final int dbId = rawVolume['id'];
        final int dbSize = rawVolume['size'];
        final dbServer = rawVolume['server'];
        final String dbName = rawVolume['name'];
        final volume = ServerVolume(
          id: dbId,
          name: dbName,
          sizeByte: dbSize,
          serverId: dbServer,
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

  @override
  Future<ServerVolume?> getVolume(final int id) async {
    ServerVolume? volume;

    final Response dbGetResponse;
    final Dio client = await getClient();
    try {
      dbGetResponse = await client.get('/volumes/$id');
      final int dbId = dbGetResponse.data['volume']['id'];
      final int dbSize = dbGetResponse.data['volume']['size'];
      final int dbServer = dbGetResponse.data['volume']['server'];
      final String dbName = dbGetResponse.data['volume']['name'];
      volume = ServerVolume(
        id: dbId,
        name: dbName,
        sizeByte: dbSize,
        serverId: dbServer,
      );
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volume;
  }

  @override
  Future<void> deleteVolume(final int id) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$id');
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Future<bool> attachVolume(final int volumeId, final int serverId) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post(
        '/volumes/$volumeId/actions/attach',
        data: {
          'automount': true,
          'server': serverId,
        },
      );
      success = dbPostResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  @override
  Future<bool> detachVolume(final int volumeId) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post('/volumes/$volumeId/actions/detach');
      success = dbPostResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  @override
  Future<bool> resizeVolume(final int volumeId, final int sizeGb) async {
    bool success = false;

    final Response dbPostResponse;
    final Dio client = await getClient();
    try {
      dbPostResponse = await client.post(
        '/volumes/$volumeId/actions/resize',
        data: {
          'size': sizeGb,
        },
      );
      success = dbPostResponse.data['action']['status'].toString() != 'error';
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return success;
  }

  @override
  Future<ServerHostingDetails?> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
  }) async {
    ServerHostingDetails? details;

    final ServerVolume? newVolume = await createVolume();
    if (newVolume == null) {
      return details;
    }

    details = await createServerWithVolume(
      dnsApiToken: dnsApiToken,
      rootUser: rootUser,
      domainName: domainName,
      dataBase: newVolume,
    );

    return details;
  }

  Future<ServerHostingDetails?> createServerWithVolume({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final ServerVolume dataBase,
  }) async {
    final Dio client = await getClient();

    final String dbPassword = StringGenerators.dbPassword();
    final int dbId = dataBase.id;

    final String apiToken = StringGenerators.apiToken();

    final String hostname = getHostnameFromDomain(domainName);

    final String base64Password =
        base64.encode(utf8.encode(rootUser.password ?? 'PASS'));

    print('hostname: $hostname');

    /// add ssh key when you need it: e.g. "ssh_keys":["kherel"]
    /// check the branch name, it could be "development" or "master".
    ///
    final String userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$dnsApiToken DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$hostname bash 2>&1 | tee /tmp/infect.log";
    print(userdataString);

    final Map<String, Object> data = {
      'name': hostname,
      'server_type': 'cx11',
      'start_after_create': false,
      'image': 'ubuntu-20.04',
      'volumes': [dbId],
      'networks': [],
      'user_data': userdataString,
      'labels': {},
      'automount': true,
      'location': 'fsn1'
    };
    print('Decoded data: $data');

    ServerHostingDetails? serverDetails;
    DioError? hetznerError;
    bool success = false;

    try {
      final Response serverCreateResponse = await client.post(
        '/servers',
        data: data,
      );
      print(serverCreateResponse.data);
      serverDetails = ServerHostingDetails(
        id: serverCreateResponse.data['server']['id'],
        ip4: serverCreateResponse.data['server']['public_net']['ipv4']['ip'],
        createTime: DateTime.now(),
        volume: dataBase,
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
      await deleteVolume(dbId);
    }

    if (hetznerError != null) {
      throw hetznerError;
    }

    return serverDetails;
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
  Future<void> deleteServer({
    required final String domainName,
  }) async {
    final Dio client = await getClient();

    final String hostname = getHostnameFromDomain(domainName);

    final Response serversReponse = await client.get('/servers');
    final List servers = serversReponse.data['servers'];
    final Map server = servers.firstWhere((final el) => el['name'] == hostname);
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
    close(client);
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

  Future<Map<String, dynamic>> getMetrics(
    final DateTime start,
    final DateTime end,
    final String type,
  ) async {
    final ServerHostingDetails? hetznerServer =
        getIt<ApiConfigModel>().serverDetails;
    final Dio client = await getClient();

    final Map<String, dynamic> queryParameters = {
      'start': start.toUtc().toIso8601String(),
      'end': end.toUtc().toIso8601String(),
      'type': type
    };
    final Response res = await client.get(
      '/servers/${hetznerServer!.id}/metrics',
      queryParameters: queryParameters,
    );
    close(client);
    return res.data;
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
      final Response response = await client.get('/servers');
      servers = (response.data!['servers'] as List)
          .map(
            (final e) => HetznerServerInfo.fromJson(e),
          )
          .toList()
          .map(
            (final HetznerServerInfo server) => ServerBasicInfo(
              id: server.id,
              name: server.name,
              ip: server.publicNet.ipv4.ip,
              reverseDns: server.publicNet.ipv4.reverseDns,
              created: server.created,
              volumeId: server.volumes.isNotEmpty ? server.volumes[0] : 0,
            ),
          )
          .toList();
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return servers;
  }

  @override
  Future<void> createReverseDns({
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
    } finally {
      close(client);
    }
  }
}
