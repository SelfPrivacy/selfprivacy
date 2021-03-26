import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/models/hetzner_server_info.dart';

class ServerDetailsRepository {
  Future<HetznerServerInfo> load() async {
    var client = HetznerApi();
    return await client.getInfo();
  }
}
