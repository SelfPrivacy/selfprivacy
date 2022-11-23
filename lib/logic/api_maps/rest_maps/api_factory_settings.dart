import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ServerProviderApiFactorySettings {
  ServerProviderApiFactorySettings({
    required this.provider,
    this.location,
  });

  final ServerProvider provider;
  final String? location;
}

class DnsProviderApiFactorySettings {
  DnsProviderApiFactorySettings({
    required this.provider,
  });

  final DnsProvider provider;
}
