import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class LaunchInstallationData {
  LaunchInstallationData({
    required this.rootUser,
    required this.dnsApiToken,
    required this.dnsProviderType,
    required this.dnsProvider,
    required this.serverDomain,
    required this.serverTypeId,
    required this.errorCallback,
    required this.successCallback,
  });

  final User rootUser;
  final String dnsApiToken;
  final ServerDomain serverDomain;
  final DnsProviderType dnsProviderType;
  final DnsProvider dnsProvider;
  final String serverTypeId;
  final Function() errorCallback;
  final Function(ServerHostingDetails details) successCallback;
}
