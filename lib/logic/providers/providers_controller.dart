import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

class ProvidersController {
  static ServerProvider? get currentServerProvider => _serverProvider;
  static DnsProvider? get currentDnsProvider => _dnsProvider;

  static void initServerProvider(
    final ServerProviderSettings settings,
  ) {
    _serverProvider = ServerProviderFactory.createServerProviderInterface(
      settings,
    );
  }

  static void initDnsProvider(
    final DnsProviderSettings settings,
  ) {
    _dnsProvider = DnsProviderFactory.createDnsProviderInterface(
      settings,
    );
  }

  static void clearProviders() {
    _serverProvider = null;
    _dnsProvider = null;
  }

  static ServerProvider? _serverProvider;
  static DnsProvider? _dnsProvider;
}
