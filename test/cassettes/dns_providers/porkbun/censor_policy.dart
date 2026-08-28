import 'package:sp_vcr/sp_vcr.dart';

const CensorPolicy porkbunCensorPolicy = CensorPolicy(
  headerKeys: <String>['X-API-Key', 'X-Secret-API-Key', 'x-request-id'],
);
