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
  @override
  bool hasLogger;
  @override
  bool isWithToken;

  HetznerApi({this.hasLogger = false, this.isWithToken = true});

  @override
  BaseOptions get options {
    var options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      var token = getIt<ApiConfigModel>().hetznerKey;
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

  Future<bool> isValid(String token) async {
    validateStatus = (status) {
      return status == HttpStatus.ok || status == HttpStatus.unauthorized;
    };
    var client = await getClient();
    Response response = await client.get(
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

  Future<ServerVolume> createVolume() async {
    var client = await getClient();
    Response dbCreateResponse = await client.post(
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
    var dbId = dbCreateResponse.data['volume']['id'];
    return ServerVolume(
      id: dbId,
      name: dbCreateResponse.data['volume']['name'],
    );
  }

  Future<ServerHostingDetails> createServer({
    required String cloudFlareKey,
    required User rootUser,
    required String domainName,
    required ServerVolume dataBase,
  }) async {
    var client = await getClient();

    var dbPassword = StringGenerators.dbPassword();
    var dbId = dataBase.id;

    final apiToken = StringGenerators.apiToken();

    final hostname = getHostnameFromDomain(domainName);

    final base64Password =
        base64.encode(utf8.encode(rootUser.password ?? 'PASS'));

    print('hostname: $hostname');

    /// add ssh key when you need it: e.g. "ssh_keys":["kherel"]
    /// check the branch name, it could be "development" or "master".
    ///
    final userdataString =
        "#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/SelfPrivacy/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-21.05 DOMAIN='$domainName' LUSER='${rootUser.login}' ENCODED_PASSWORD='$base64Password' CF_TOKEN=$cloudFlareKey DB_PASSWORD=$dbPassword API_TOKEN=$apiToken HOSTNAME=$hostname bash 2>&1 | tee /tmp/infect.log";
    print(userdataString);

    final data = {
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

    Response serverCreateResponse = await client.post(
      '/servers',
      data: data,
    );

    print(serverCreateResponse.data);
    client.close();
    return ServerHostingDetails(
      id: serverCreateResponse.data['server']['id'],
      ip4: serverCreateResponse.data['server']['public_net']['ipv4']['ip'],
      createTime: DateTime.now(),
      volume: dataBase,
      apiToken: apiToken,
      provider: ServerProvider.hetzner,
    );
  }

  static String getHostnameFromDomain(String domain) {
    // Replace all non-alphanumeric characters with an underscore
    var hostname =
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
    required String domainName,
  }) async {
    var client = await getClient();

    final hostname = getHostnameFromDomain(domainName);

    Response serversReponse = await client.get('/servers');
    List servers = serversReponse.data['servers'];
    Map server = servers.firstWhere((el) => el['name'] == hostname);
    List volumes = server['volumes'];
    var laterFutures = <Future>[];

    for (var volumeId in volumes) {
      await client.post('/volumes/$volumeId/actions/detach');
    }
    await Future.delayed(const Duration(seconds: 10));

    for (var volumeId in volumes) {
      laterFutures.add(client.delete('/volumes/$volumeId'));
    }
    laterFutures.add(client.delete('/servers/${server['id']}'));

    await Future.wait(laterFutures);
    close(client);
  }

  Future<ServerHostingDetails> reset() async {
    var server = getIt<ApiConfigModel>().serverDetails!;

    var client = await getClient();
    await client.post('/servers/${server.id}/actions/reset');
    close(client);

    return server.copyWith(startTime: DateTime.now());
  }

  Future<ServerHostingDetails> powerOn() async {
    var server = getIt<ApiConfigModel>().serverDetails!;

    var client = await getClient();
    await client.post('/servers/${server.id}/actions/poweron');
    close(client);

    return server.copyWith(startTime: DateTime.now());
  }

  Future<Map<String, dynamic>> getMetrics(
      DateTime start, DateTime end, String type) async {
    var hetznerServer = getIt<ApiConfigModel>().serverDetails;
    var client = await getClient();

    Map<String, dynamic> queryParameters = {
      'start': start.toUtc().toIso8601String(),
      'end': end.toUtc().toIso8601String(),
      'type': type
    };
    var res = await client.get(
      '/servers/${hetznerServer!.id}/metrics',
      queryParameters: queryParameters,
    );
    close(client);
    return res.data;
  }

  Future<HetznerServerInfo> getInfo() async {
    var hetznerServer = getIt<ApiConfigModel>().serverDetails;
    var client = await getClient();
    Response response = await client.get('/servers/${hetznerServer!.id}');
    close(client);

    return HetznerServerInfo.fromJson(response.data!['server']);
  }

  Future<List<HetznerServerInfo>> getServers() async {
    var client = await getClient();
    Response response = await client.get('/servers');
    close(client);

    return (response.data!['servers'] as List)
        .map((e) => HetznerServerInfo.fromJson(e))
        .toList();
  }

  Future<void> createReverseDns({
    required String ip4,
    required String domainName,
  }) async {
    var hetznerServer = getIt<ApiConfigModel>().serverDetails;
    var client = await getClient();
    await client.post(
      '/servers/${hetznerServer!.id}/actions/change_dns_ptr',
      data: {
        'ip': ip4,
        'dns_ptr': domainName,
      },
    );
    close(client);
  }
}
