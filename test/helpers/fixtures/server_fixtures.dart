import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

ServerProviderVolume aServerProviderVolume({
  final int id = 0,
  final String name = '',
  final int sizeByte = 0,
  final int serverId = 1,
  final String linuxDevice = '',
}) => ServerProviderVolume(
  id: id,
  name: name,
  sizeByte: sizeByte,
  serverId: serverId,
  linuxDevice: linuxDevice,
);

ServerHostingDetails aServerHostingDetails({
  final int id = 1,
  final String ip4 = '203.0.113.10',
  final String apiToken = 'api-token',
  final ServerProviderType provider = ServerProviderType.hetzner,
  final DateTime? createTime,
  final DateTime? startTime,
  final DateTime? apiTokenRotatedAt,
  final ServerProviderVolume? volume,
}) => ServerHostingDetails(
  id: id,
  ip4: ip4,
  apiToken: apiToken,
  provider: provider,
  createTime: createTime,
  startTime: startTime,
  apiTokenRotatedAt: apiTokenRotatedAt,
  volume: volume ?? aServerProviderVolume(serverId: id),
);

ServerDomain aServerDomain({
  final String domainName = 'example.org',
  final DnsProviderType provider = DnsProviderType.cloudflare,
}) => ServerDomain(domainName: domainName, provider: provider);

Server aServer({
  final ServerHostingDetails? hostingDetails,
  final ServerDomain? domain,
}) => Server(
  hostingDetails: hostingDetails ?? aServerHostingDetails(),
  domain: domain ?? aServerDomain(),
);
