import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ServerProviderSettings {
  ServerProviderSettings({
    required this.provider,
    this.location,
  });

  final ServerProviderType provider;
  final String? location;
}

class DnsProviderSettings {
  DnsProviderSettings({
    required this.provider,
  });

  final DnsProviderType provider;
}
