import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/utils/password_generator2.dart';

class HetznerApi extends ApiMap {
  bool hasLoger;
  bool isWithToken;

  HetznerApi({this.hasLoger = false, this.isWithToken = true});

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

  Future<bool> isFreeToCreate() async {
    var client = await getClient();

    Response serversReponse = await client.get('/servers');
    List servers = serversReponse.data['servers'];
    var server = servers.firstWhere(
      (el) => el['name'] == 'selfprivacy-server',
      orElse: null,
    );
    client.close();
    return server == null;
  }

  Future<HetznerServerDetails> createServer({
    required String cloudFlareKey,
    required User rootUser,
    required String domainName,
  }) async {
    var dbPassword = getRandomString(40);

    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    var dbStorageName = getRandomString(6, chars);
    var client = await getClient();

    Response dbCreateResponse = await client.post(
      '/volumes',
      data: {
        "size": 10,
        "name": dbStorageName,
        "labels": {"labelkey": "value"},
        "location": "fsn1",
        "automount": false,
        "format": "ext4"
      },
    );
    var dbId = dbCreateResponse.data['volume']['id'];
    var data = jsonDecode(
      '''{"name":"$domainName","server_type":"cx11","start_after_create":false,"image":"ubuntu-20.04", "volumes":[$dbId], "networks":[],"user_data":"#cloud-config\\nruncmd:\\n- curl https://git.selfprivacy.org/ilchub/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-20.09 DOMAIN=$domainName LUSER=${rootUser.login} PASSWORD=${rootUser.password} HASHED_PASSWORD=${rootUser.hashPassword} CF_TOKEN=$cloudFlareKey DB_PASSWORD=$dbPassword bash 2>&1 | tee /tmp/infect.log","labels":{},"automount":true, "location": "fsn1"}''',
    );

    Response serverCreateResponse = await client.post(
      '/servers',
      data: data,
    );
    client.close();
    return HetznerServerDetails(
      id: serverCreateResponse.data['server']['id'],
      ip4: serverCreateResponse.data['server']['public_net']['ipv4']['ip'],
      createTime: DateTime.now(),
      dataBase: HetznerDataBase(
        id: dbId,
        name: dbCreateResponse.data['volume']['name'],
      ),
    );
  }

  Future<void> deleteSelfprivacyServerAndAllVolumes({
    required String domainName,
  }) async {
    var client = await getClient();

    Response serversReponse = await client.get('/servers');
    List servers = serversReponse.data['servers'];
    var server = servers.firstWhere((el) => el['name'] == domainName);
    await client.delete('/servers/${server['id']}');

    Response volumesReponse = await client.get('/volumes');
    List volumes = volumesReponse.data['volumes'];

    var laterFutures = <Future>[];
    for (var volume in volumes) {
      if (volume['server'] == null) {
        await client.delete('/volumes/${volume['id']}');
      } else {
        laterFutures.add(Future.delayed(Duration(seconds: 60)).then(
          (_) => client.delete('/volumes/${volume['id']}'),
        ));
      }
    }

    if (laterFutures.isEmpty) {
      close(client);
    } else {
      Future.wait(laterFutures).then((value) => close(client));
    }
  }

  Future<HetznerServerDetails> reset() async {
    var server = getIt<ApiConfigModel>().hetznerServer!;

    var client = await getClient();
    await client.post('/servers/${server.id}/actions/reset');
    close(client);

    return server.copyWith(startTime: DateTime.now());
  }

  Future<HetznerServerDetails> powerOn() async {
    var server = getIt<ApiConfigModel>().hetznerServer!;

    var client = await getClient();
    await client.post('/servers/${server.id}/actions/poweron');
    close(client);

    return server.copyWith(startTime: DateTime.now());
  }

  Future<Map<String, dynamic>> getMetrics(DateTime start, DateTime end, String type) async {
    var hetznerServer = getIt<ApiConfigModel>().hetznerServer;
    var client = await getClient();

    Map<String, dynamic> queryParameters = {
      "start": start.toUtc().toIso8601String(),
      "end": end.toUtc().toIso8601String(),
      "type": type
    };
    var res = await client.get(
      '/servers/${hetznerServer!.id}/metrics',
      queryParameters: queryParameters,
    );
    close(client);
    return res.data;
  }

  Future<HetznerServerInfo> getInfo() async {
    var hetznerServer = getIt<ApiConfigModel>().hetznerServer;
    var client = await getClient();
    Response response = await client.get('/servers/${hetznerServer!.id}');
    close(client);

    return HetznerServerInfo.fromJson(response.data!['server']);
  }
}
