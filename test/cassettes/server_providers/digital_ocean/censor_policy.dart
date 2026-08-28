import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy digitalOceanServerCensorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization', 'cf-ray', 'x-request-id'],
  jsonBodyKeys: <String>[
    'API_TOKEN',
    'DNS_PROVIDER_TOKEN',
    'DNS_PROVIDER_TOKEN_ID',
    'DNS_PROVIDER_SECONDARY_TOKEN',
    'SSH_AUTHORIZED_KEY',
  ],
);
