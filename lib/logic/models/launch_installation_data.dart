import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class LaunchInstallationData {
  LaunchInstallationData({
    required this.dnsApiCredential,
    required this.serverDomain,
    required this.serverTypeId,
    required this.errorCallback,
    required this.successCallback,
    required this.storageSize,
    required this.customSshKey,
    required this.location,
  });

  final DnsProviderCredential dnsApiCredential;
  final ServerDomain serverDomain;
  final String serverTypeId;
  final Function() errorCallback;
  final Function(ServerHostingDetails details) successCallback;
  final DiskSize storageSize;
  final String? customSshKey;
  final String location;
}
