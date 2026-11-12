import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class ProvisioningRequest {
  const ProvisioningRequest({
    required this.dnsApiCredential,
    required this.serverDomain,
    required this.serverTypeId,
    required this.serverApiToken,
    required this.storageSize,
    required this.customSshKey,
    required this.location,
  });

  final DnsProviderCredential dnsApiCredential;
  final ServerDomain serverDomain;
  final String serverTypeId;
  final String serverApiToken;
  final DiskSize storageSize;
  final String? customSshKey;
  final String location;
}
