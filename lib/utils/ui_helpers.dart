import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static String getDomainName(final ServerInstallationState config) =>
      config.isDomainFilled ? config.serverDomain!.domainName : 'example.com';
}
