import 'package:intl/intl.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static String getDomainName(final ServerInstallationState config) =>
      config.isDomainSelected ? config.serverDomain!.domainName : 'example.com';

  static final _formatter = NumberFormat()..minimumFractionDigits = 0;

  static String formatWithPrecision(
    final double value, {
    final int fraction = 2,
  }) {
    _formatter.maximumFractionDigits = fraction;
    return _formatter.format(value);
  }
}
