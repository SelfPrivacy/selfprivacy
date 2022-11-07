import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

/// it's ui helpers use only for ui components, don't use for logic components.

class UiHelpers {
  static String getDomainName(final ServerInstallationState config) =>
      config.isDomainSelected ? config.serverDomain!.domainName : 'example.com';

  static Future<bool> launchExternalApplicationURL(final url) async {
    bool launched = false;

    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      print(e);
    }

    return launched;
  }
}
