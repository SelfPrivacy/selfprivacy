import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
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

  ValidateStatus? validateStatus;

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
    client.close();

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  Future<HetznerServerDetails> createServer({
    required String cloudFlareKey,
    required User rootUser,
    required String domainName,
  }) async {
    var dbPassword = getRandomString(40);

    var data = jsonDecode(
      '''{"name":"selfprivacy-server","server_type":"cx11","start_after_create":false,"image":"ubuntu-20.04", "volumes":[],"networks":[],"user_data":"#cloud-config\\nruncmd:\\n- curl https://git.selfprivacy.org/ilchub/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-20.09 DOMAIN=$domainName LUSER=${rootUser.login} PASSWORD=${rootUser.password} HASHED_PASSWORD=${rootUser.hashPassword} CF_TOKEN=$cloudFlareKey DB_PASSWORD=$dbPassword bash 2>&1 | tee /tmp/infect.log","labels":{},"automount":false}''',
    );

    var client = await getClient();
    Response response = await client.post(
      '/servers',
      data: data,
    );
    client.close();
    return HetznerServerDetails(
      id: response.data['server']['id'],
      ip4: response.data['server']['public_net']['ipv4']['ip'],
      createTime: DateTime.now(),
    );
  }

  Future<void> deleteSelfprivacyServer() async {
    var client = await getClient();
    Response response = await client.get('/servers');

    List list = response.data['servers'];
    var server = list.firstWhere((el) => el['name'] == 'selfprivacy-server');
    await client.delete('/servers/${server['id']}');
    client.close();
  }

  Future<HetznerServerDetails> startServer({
    required HetznerServerDetails server,
  }) async {
    var client = await getClient();

    await client.post('/servers/${server.id}/actions/poweron');
    client.close();

    return server.copyWith(
      startTime: DateTime.now(),
    );
  }

  Future<HetznerServerDetails> restart({
    required HetznerServerDetails server,
  }) async {
    var client = await getClient();
    await client.post('/servers/${server.id}/actions/poweron');
    client.close();
    return server.copyWith(
      startTime: DateTime.now(),
    );
  }

  metrics() async {
    var hetznerServer = getIt<ApiConfigModel>().hetznerServer;
    var client = await getClient();
    await client.post('/servers/${hetznerServer!.id}/metrics');
    client.close();
  }

  getInfo() async {
    var hetznerServer = getIt<ApiConfigModel>().hetznerServer;
    var client = await getClient();
    await client.post('/servers/${hetznerServer!.id}');
    client.close();
  }
}
