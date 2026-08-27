import 'package:sp_vcr/sp_vcr.dart';

Censors providerCensors(final CensorPolicy policy) =>
    Censors.defaultCredentialCensors..withPolicy(policy);
