import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ServerProviderSettings {
  ServerProviderSettings({
    required this.provider,
    this.isAuthorized = false,
    this.location,
  });

  final bool isAuthorized;
  final ServerProviderType provider;
  final String? location;
}

class DnsProviderSettings {
  DnsProviderSettings({
    required this.provider,
    this.isAuthorized = false,
  });

  final bool isAuthorized;
  final DnsProviderType provider;
}
