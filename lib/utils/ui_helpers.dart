import 'package:intl/intl.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static String getDomainName(final ServerInstallationState config) =>
      config.isDomainSelected ? config.serverDomain!.domainName : 'example.com';

  static String formatWithPrecision(
    final double value, {
    final int fraction = 2,
  }) {
    final NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = fraction;
    return formatter.format(value);
  }
}
