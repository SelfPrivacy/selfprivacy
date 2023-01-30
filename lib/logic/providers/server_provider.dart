import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';

abstract class ServerProvider {
  Future<APIGenericResult<bool>> isApiTokenValid(final String apiToken);
}
