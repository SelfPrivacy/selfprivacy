import 'package:selfprivacy/logic/models/hive/server.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

Future<List<ServerMetadataEntity>> fetchServerMetadata({
  required final Server server,
  required final ServerProvider? serverProvider,
  required final DnsProvider? dnsProvider,
}) async {
  final hosting = server.hostingDetails;
  final dnsName = dnsProvider != null && dnsProvider.isAuthorized
      ? dnsProvider.type.displayName
      : server.domain.provider.displayName;
  final data = <ServerMetadataEntity>[];
  if (serverProvider != null && serverProvider.isAuthorized) {
    final id = hosting.providerId;
    final location = hosting.serverLocation;
    if (id != null && location != null) {
      final result = await serverProvider.getMetadata(id, location);
      data.addAll(result.data);
    }
  } else {
    data.add(
      ServerMetadataEntity(
        trId: 'server.server_provider',
        value: hosting.provider.displayName,
      ),
    );
  }
  data.add(ServerMetadataEntity(trId: 'server.dns_provider', value: dnsName));
  return List.unmodifiable(data);
}
