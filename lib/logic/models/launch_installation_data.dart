import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

class LaunchInstallationData {
  LaunchInstallationData({
    required this.rootUser,
    required this.dnsApiToken,
    required this.dnsProviderType,
    required this.domainName,
    required this.serverType,
    required this.errorCallback,
    required this.successCallback,
  });

  final User rootUser;
  final String dnsApiToken;
  final String domainName;
  final DnsProviderType dnsProviderType;
  final ServerType serverType;
  final Function() errorCallback;
  final Function(ServerHostingDetails details) successCallback;
}
