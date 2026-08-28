import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy cloudflareCensorPolicy = CensorPolicy(
  headerKeys: <String>['Authorization', 'cf-auditlog-id', 'cf-ray'],
);
