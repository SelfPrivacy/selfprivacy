import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
export 'package:selfprivacy/logic/api_maps/generic_result.dart';

abstract class ServerProviderApi extends ApiMap {
  /// Provider name key which lets infect understand what kind of installation
  /// it requires, for example 'digitaloceal' for Digital Ocean
  String get infectProviderName;

  /// Actual provider name to render on information page for user,
  /// for example 'Digital Ocean' for Digital Ocean
  String get displayProviderName;
}
