import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/dns_providers/cloudflare.dart';
import 'package:selfprivacy/logic/providers/dns_providers/desec.dart';
import 'package:selfprivacy/logic/providers/dns_providers/digital_ocean_dns.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';

class UnknownProviderException implements Exception {
  UnknownProviderException(this.message);
  final String message;
}

class DnsProviderFactory {
  static DnsProvider createDnsProviderInterface(
    final DnsProviderSettings settings,
  ) {
    switch (settings.provider) {
      case DnsProviderType.cloudflare:
        return settings.isAuthorized
            ? CloudflareDnsProvider.load(
              isAuthorized: settings.isAuthorized,
              token: settings.token,
            )
            : CloudflareDnsProvider();
      case DnsProviderType.digitalOcean:
        return settings.isAuthorized
            ? DigitalOceanDnsProvider.load(
              isAuthorized: settings.isAuthorized,
              token: settings.token,
            )
            : DigitalOceanDnsProvider();
      case DnsProviderType.desec:
        return settings.isAuthorized
            ? DesecDnsProvider.load(
              isAuthorized: settings.isAuthorized,
              token: settings.token,
            )
            : DesecDnsProvider();
      case DnsProviderType.unknown:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
