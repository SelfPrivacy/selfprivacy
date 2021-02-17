import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

class HetznerApi extends ApiMap {
  HetznerApi([String token]) {
    if (token != null) {
      loggedClient.options = BaseOptions(
        headers: {'Authorization': 'Bearer $token'},
        baseUrl: rootAddress,
      );
    }
  }

  @override
  String rootAddress = 'https://api.hetzner.cloud/v1/servers';

  Future<bool> isValid(String token) async {
    var options = Options(
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (status) {
        return status == HttpStatus.ok || status == HttpStatus.unauthorized;
      },
    );

    Response response = await loggedClient.get(rootAddress, options: options);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  Future<HetznerServerDetails> createServer({
    @required String cloudFlareKey,
    @required User rootUser,
    @required String domainName,
    @required String dbPassword,
  }) async {
    var data = jsonDecode(
      '''{"name":"selfprivacy-server","server_type":"cx11","start_after_create":false,"image":"ubuntu-20.04", "volumes":[],"networks":[],"user_data":"#cloud-config\\nruncmd:\\n- curl https://git.selfprivacy.org/ilchub/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-20.09 DOMAIN=$domainName LUSER=${rootUser.login} PASSWORD=${rootUser.password} HASHED_PASSWORD=${rootUser.hashPassword} CF_TOKEN=$cloudFlareKey DB_PASSWORD=$dbPassword bash 2>&1 | tee /tmp/infect.log","labels":{},"automount":false}''',
    );

    Response response = await loggedClient.post(
      rootAddress,
      data: data,
    );

    return HetznerServerDetails(
      id: response.data['server']['id'],
      ip4: response.data['server']['public_net']['ipv4']['ip'],
      createTime: DateTime.now(),
    );
  }

  Future<void> deleteSelfprivacyServer({
    @required String cloudFlareKey,
  }) async {
    Response response = await loggedClient.get(rootAddress);

    List list = response.data['servers'];
    var server = list.firstWhere((el) => el['name'] == 'selfprivacy-server');
    return await loggedClient.delete('$rootAddress/${server['id']}');
  }

  Future<HetznerServerDetails> startServer({
    HetznerServerDetails server,
  }) async {
    await loggedClient.post('/${server.id}/actions/poweron');

    return server.copyWith(
      startTime: DateTime.now(),
    );
  }

  Future<HetznerServerDetails> restart({
    HetznerServerDetails server,
  }) async {
    await loggedClient.post('/${server.id}/actions/poweron');

    return server.copyWith(
      startTime: DateTime.now(),
    );
  }
}
