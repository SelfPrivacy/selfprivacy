import 'package:selfprivacy/logic/api_maps/rest_maps/provider_api_settings.dart';

class DnsProviderApiSettings extends ProviderApiSettings {
  const DnsProviderApiSettings({
    super.hasLogger = false,
    super.isWithToken = true,
    this.customToken,
  });
  final String? customToken;
}
