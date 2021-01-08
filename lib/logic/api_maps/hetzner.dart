import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/server_details.dart';
import 'package:selfprivacy/logic/models/user.dart';

class HetznerApi extends ApiMap {
  HetznerApi([String token]) {
    if (token != null) {
      client.options = BaseOptions(headers: {'Authorization': 'Bearer $token'});
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

    Response response = await client.get(rootAddress, options: options);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('something bad happend');
    }
  }

  Future<HetznerServerDetails> createServer({
    @required User rootUser,
    @required String domainName,
  }) async {
    var data = {
      "name": "selfprivacy-server",
      "server_type": "cx11",
      "start_after_create": true,
      "image": "ubuntu-20.04",
      "ssh_keys": [],
      "volumes": [],
      "networks": [],
      'user-data':
          '#cloud-config\nruncmd:\n- curl https://git.selfprivacy.org/ilchub/selfprivacy-nixos-infect/raw/branch/master/nixos-infect | PROVIDER=hetzner NIX_CHANNEL=nixos-20.09 DOMAIN=$domainName USER=${rootUser.login} PASSWORD=${rootUser.password} HASHED_PASSWORD=${rootUser.hashPassword} bash 2>&1 | tee /tmp/infect.log'
    };
    Response response = await client.post(
      rootAddress,
      data: data,
    );

    return HetznerServerDetails(
      id: response.data['server']['id'],
      ip4: response.data['server']['public_net']['ipv4']['ip'],
      startTime: DateTime.now(),
    );
  }
}
