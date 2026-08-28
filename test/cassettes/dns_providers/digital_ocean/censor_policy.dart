import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy digitalOceanDnsCensorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization', 'x-request-id', 'cf-ray'],
);
