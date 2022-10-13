import 'package:selfprivacy/logic/api_maps/rest_maps/provider_api_settings.dart';

class ServerProviderApiSettings extends ProviderApiSettings {
  const ServerProviderApiSettings({
    required this.region,
    super.hasLogger = false,
    super.isWithToken = true,
  });

  final String region;
}
