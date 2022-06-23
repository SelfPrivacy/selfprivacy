import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class HetznerApi extends ApiMap {
  HetznerApi({this.hasLogger = false, this.isWithToken = true});
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

  Future<bool> isValid(final String token) async {
    validateStatus = (final int? status) =>
        status == HttpStatus.ok || status == HttpStatus.unauthorized;
    final Dio client = await getClient();
    final Response response = await client.get(
      '/servers',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    close(client);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

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
      final dbName = dbCreateResponse.data['volume']['name'];
      volume = ServerVolume(
        id: dbId,
        name: dbName,
      );
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volume;
  }

  Future<List<ServerVolume>> getVolumes(final String? status) async {
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
        final String dbName = rawVolume['name'];
        final volume = ServerVolume(
          id: dbId,
          name: dbName,
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

  Future<ServerVolume?> getVolume(final int id) async {
    ServerVolume? volume;

    final Response dbGetResponse;
    final Dio client = await getClient();
    try {
      dbGetResponse = await client.get('/volumes/$id');
      final int dbId = dbGetResponse.data['volume']['id'];
      final String dbName = dbGetResponse.data['volume']['name'];
      volume = ServerVolume(
        id: dbId,
        name: dbName,
      );
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return volume;
  }

  void deleteVolume(final int id) async {
    final Dio client = await getClient();
    try {
      await client.delete('/volumes/$id');
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

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

  Future<ServerHostingDetails?> createServer({
    required final String cloudFlareKey,
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
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$cloudFlareKey DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$hostname bash 2>&1 | tee /tmp/infect.log";
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
    } on DioError catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
    } finally {
      client.close();
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

  Future<void> deleteSelfprivacyServerAndAllVolumes({
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

  Future<ServerHostingDetails> reset() async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;

    final Dio client = await getClient();
    await client.post('/servers/${server.id}/actions/reset');
    close(client);

    return server.copyWith(startTime: DateTime.now());
  }

  Future<ServerHostingDetails> powerOn() async {
    final ServerHostingDetails server = getIt<ApiConfigModel>().serverDetails!;

    final Dio client = await getClient();
    await client.post('/servers/${server.id}/actions/poweron');
    close(client);

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

  Future<List<HetznerServerInfo>> getServers() async {
    final Dio client = await getClient();
    final Response response = await client.get('/servers');
    close(client);

    return (response.data!['servers'] as List)
        // ignore: unnecessary_lambdas
        .map((final e) => HetznerServerInfo.fromJson(e))
        .toList();
  }

  Future<void> createReverseDns({
    required final String ip4,
    required final String domainName,
  }) async {
    final ServerHostingDetails? hetznerServer =
        getIt<ApiConfigModel>().serverDetails;

    final Dio client = await getClient();
    try {
      await client.post(
        '/servers/${hetznerServer!.id}/actions/change_dns_ptr',
        data: {
          'ip': ip4,
          'dns_ptr': domainName,
        },
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
  }
}
