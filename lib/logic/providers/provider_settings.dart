import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ServerProviderSettings {
  ServerProviderSettings({
    required this.provider,
    this.token,
    this.isAuthorized = false,
  });

  final bool isAuthorized;
  final ServerProviderType provider;
  final String? token;
}

class DnsProviderSettings {
  DnsProviderSettings({
    required this.provider,
    this.token,
    this.isAuthorized = false,
  });

  final bool isAuthorized;
  final DnsProviderType provider;
  final String? token;
}

class BackupsProviderSettings {
  BackupsProviderSettings({
    required this.provider,
    this.tokenId,
    this.token,
    this.isAuthorized = false,
  });

  final bool isAuthorized;
  final BackupsProviderType provider;
  final String? tokenId;
  final String? token;
}
