import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/hive/provider_credentials.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

ServerProvider? resolveServerProvider(
  final ResourcesModel resources,
  final String serverUuid, {
  final RestApiClientFactory? clientFactory,
}) {
  final server = resources.servers
      .where((final server) => server.uuid == serverUuid)
      .firstOrNull;
  if (server == null) {
    return null;
  }
  final matches = resources.serverProviderCredentials
      .where(
        (final credential) =>
            credential.provider == server.hostingDetails.provider &&
            credential.associatedServerUuids.contains(serverUuid),
      )
      .toList();
  if (matches.length != 1) {
    return null;
  }
  final credentials = matches.single.credentials;
  if (credentials is! BearerTokenCredential ||
      credentials.token.trim().isEmpty) {
    return null;
  }
  return ServerProviderFactory.createServerProviderInterface(
    ServerProviderSettings(
      provider: matches.single.provider,
      credentials: credentials,
    ),
    clientFactory: clientFactory,
  );
}

DnsProvider? resolveDnsProvider(
  final ResourcesModel resources,
  final String serverUuid, {
  final RestApiClientFactory? clientFactory,
}) {
  final server = resources.servers
      .where((final server) => server.uuid == serverUuid)
      .firstOrNull;
  if (server == null) {
    return null;
  }
  final matches = resources.dnsProviderCredentials
      .where(
        (final credential) =>
            credential.provider == server.domain.provider &&
            credential.associatedDomainNames.contains(server.domain.domainName),
      )
      .toList();
  if (matches.length != 1 || matches.single.token.trim().isEmpty) {
    return null;
  }
  final credential = matches.single;
  if (credential.provider == DnsProviderType.porkbun &&
      (credential.tokenId?.trim().isEmpty ?? true)) {
    return null;
  }
  return DnsProviderFactory.createDnsProviderInterface(
    DnsProviderSettings(
      provider: credential.provider,
      token: credential.token,
      tokenId: credential.tokenId,
      url: credential.url,
      tenant: credential.tenant,
      secondaryToken: credential.secondaryToken,
      isAuthorized: true,
    ),
    clientFactory: clientFactory,
  );
}
