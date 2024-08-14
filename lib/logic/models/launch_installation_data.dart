import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

class LaunchInstallationData {
  LaunchInstallationData({
    required this.rootUser,
    required this.dnsApiToken,
    required this.dnsProviderType,
    required this.serverDomain,
    required this.serverTypeId,
    required this.errorCallback,
    required this.successCallback,
    required this.storageSize,
    required this.customSshKey,
    required this.location,
  });

  final User rootUser;
  final String dnsApiToken;
  final ServerDomain serverDomain;
  final DnsProviderType dnsProviderType;
  final String serverTypeId;
  final Function() errorCallback;
  final Function(ServerHostingDetails details) successCallback;
  final DiskSize storageSize;
  final String? customSshKey;
  final String location;
}
