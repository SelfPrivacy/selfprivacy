import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
export 'package:selfprivacy/logic/api_maps/generic_result.dart';
export 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';

class DomainNotFoundException implements Exception {
  DomainNotFoundException(this.message);
  final String message;
}

abstract class DnsProviderApi extends ApiMap {}
