import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/providers/dns_providers/cloudflare.dart';
import 'package:selfprivacy/logic/providers/dns_providers/desec.dart';
import 'package:selfprivacy/logic/providers/dns_providers/digital_ocean.dart';
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
        return CloudflareDnsProvider();
      case DnsProviderType.digitalOcean:
        return DigitalOceanDnsProvider();
      case DnsProviderType.desec:
        return DesecDnsProvider();
      case DnsProviderType.unknown:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
