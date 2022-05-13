import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static String getDomainName(AppConfigState config) =>
      config.isDomainFilled ? config.serverDomain!.domainName : 'example.com';
}
