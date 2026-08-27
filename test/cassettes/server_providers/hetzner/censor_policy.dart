import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy hetznerCensorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization'],
  jsonBodyKeys: <String>[
    'API_TOKEN',
    'DNS_PROVIDER_TOKEN',
    'DNS_PROVIDER_TOKEN_ID',
    'DNS_PROVIDER_SECONDARY_TOKEN',
    'SSH_AUTHORIZED_KEY',
  ],
);
